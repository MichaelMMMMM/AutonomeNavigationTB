scan_subscriber         = rossubscriber('/scan');
model_states_subscriber = rossubscriber('/gazebo/model_states');

map_publisher           = rospublisher('/CustomMap', 'nav_msgs/OccupancyGrid');
map_msg                 = rosmessage('nav_msgs/OccupancyGrid');

map = robotics.OccupancyGrid(20, 20, 2);
map.GridLocationInWorld = [-10,-10]; 

%Receive current laserscan
scan_msg = receive(scan_subscriber);

%Receive current statequat 
model_states_msg         = receive(model_states_subscriber);
pos_msg                  = model_states_msg.Pose(10);
eul = quat2eul([pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W]);
x_t = [pos_msg.Position.X, pos_msg.Position.Y, eul(3)];    %Receive current laserscan

show(map); grid;

plotRobot(x_t);
plotLaserScan(x_t, scan_msg);
