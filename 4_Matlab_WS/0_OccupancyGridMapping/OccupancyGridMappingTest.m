%OccupancyGridMapping Test

scan_subscriber         = rossubscriber('/scan');
model_states_subscriber = rossubscriber('/gazebo/model_states');

map_publisher           = rospublisher('/CustomMap', 'nav_msgs/OccupancyGrid');
map_msg                 = rosmessage('nav_msgs/OccupancyGrid');

map = robotics.OccupancyGrid(6, 6, 4);
map.GridLocationInWorld = [-3,-3]; 

while(true)
    %Receive current laserscan
    scan_msg = receive(scan_subscriber);

    %Receive current statequat 
    model_states_msg         = receive(model_states_subscriber);
    pos_msg                  = model_states_msg.Pose(10);
    eul = quat2eul([pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W]);
    x_t = [pos_msg.Position.X, pos_msg.Position.Y, eul(3)];
    
    tic;
    t = cputime;
    map = occupancyGridMapping2(map, x_t, scan_msg);
    cputime - t
    toc;
    show(map); grid;
    hold on; plot(x_t(1), x_t(2), 'r*'); hold off;
    writeOccupancyGrid(map_msg, map);
    map_msg.Info.Origin.Orientation.W = 1;
    send(map_publisher, map_msg);
    
    plotRobot(x_t);
    plotLaserScan(x_t, scan_msg);
end

