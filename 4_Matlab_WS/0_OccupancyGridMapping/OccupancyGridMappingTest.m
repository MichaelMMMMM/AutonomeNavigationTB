%OccupancyGridMapping Test

scan_subscriber         = rossubscriber('/scan');
model_states_subscriber = rossubscriber('/gazebo/model_states');

map_publisher           = rospublisher('/CustomMap', 'nav_msgs/OccupancyGrid');
map_msg                 = rosmessage('nav_msgs/OccupancyGrid');

map = robotics.OccupancyGrid(12, 10, 4);
map.GridLocationInWorld = [-9,-4]; 

tftree = rostf;

tf_msg                  = rosmessage('geometry_msgs/TransformStamped');
tf_msg.ChildFrameId     = '/map';
tf_msg.Header.FrameId   = 'base_footprint';
tf_msg.Transform.Translation.X = 5;
tf_msg.Transform.Translation.Y = 1;
tf_msg.Transform.Translation.Z = 0;
tf_msg.Transform.Rotation.X    = 1;
tf_msg.Transform.Rotation.Y    = 0;
tf_msg.Transform.Rotation.Z    = 1;
tf_msg.Transform.Rotation.W    = 1;
tf_msg.Header.Stamp = rostime('now');
sendTransform(tftree, tf_msg);

print_index = 0;

while(true)
    %Receive current laserscan
    scan_msg = receive(scan_subscriber);
    scan_msg.RangeMax = 5;
    %Receive current statequat 
    model_states_msg         = receive(model_states_subscriber);
    pos_msg                  = model_states_msg.Pose(10);
    eul = quat2eul([pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W]);
    x_t = [pos_msg.Position.X, pos_msg.Position.Y, eul(3)];
    
    tic;
    map = occupancyGridMapping2(map, x_t, scan_msg);
    toc;
    
    print_index = print_index + 1;
    
    if(print_index == 1)
        print_index = 0;
        show(map); grid;
        hold on; plot(x_t(1), x_t(2), 'r*'); hold off;
        writeOccupancyGrid(map_msg, map);
        send(map_publisher, map_msg);
        
        
        q = [pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W];
        r = [pos_msg.Position.X, pos_msg.Position.Y, pos_msg.Position.Z];
        v = quatrotate(q,r);
        
        plotRobot(x_t);
        plotLaserScan(x_t, scan_msg, 20);
    end
end

