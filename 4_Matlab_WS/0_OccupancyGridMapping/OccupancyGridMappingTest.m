%OccupancyGridMapping Test

scan_subscriber         = rossubscriber('/scan');
model_states_subscriber = rossubscriber('/gazebo/model_states');

map = robotics.OccupancyGrid(20, 20, 2);
map.GridLocationInWorld = [-10, -10]; 

while(true)
    %Receive current laserscan
    scan_msg = receive(scan_subscriber);

    %Receive current statequat 
    model_states_msg         = receive(model_states_subscriber);
    pos_msg                  = model_states_msg.Pose(10);
    eul = quat2eul([pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W]);
    x_t = [pos_msg.Position.X, pos_msg.Position.Y, eul(3)];
    
    map = occupancyGridMapping(map, x_t, scan_msg);
    show(map); grid;
end

