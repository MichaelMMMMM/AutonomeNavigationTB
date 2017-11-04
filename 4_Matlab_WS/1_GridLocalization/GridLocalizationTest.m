% Grid-Localization-Test

load('corridor_map_fixed.mat');

model_states_subscriber = rossubscriber('/gazebo/model_states');
velocity_subscriber     = rossubscriber('/mobile_base/commands/velocity');

%Receive current statequat 
model_states_msg         = receive(model_states_subscriber);
pos_msg                  = model_states_msg.Pose(10);
eul = quat2eul([pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W]);
x_tm1 = [pos_msg.Position.X, pos_msg.Position.Y, eul(3)];

while(true)
    %Receive current statequat 
    model_states_msg         = receive(model_states_subscriber);
    pos_msg                  = model_states_msg.Pose(10);
    eul = quat2eul([pos_msg.Orientation.X, pos_msg.Orientation.Y, pos_msg.Orientation.Z, pos_msg.Orientation.W]);
    x_t = [pos_msg.Position.X, pos_msg.Position.Y, eul(3)];
    
    %Receive 
    
end