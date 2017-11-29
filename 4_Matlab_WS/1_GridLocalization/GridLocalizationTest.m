% Grid-Localization-Test

load('corridor_map_fixed.mat');

bag     = rosbag('../../5_BagFiles/CorridorBag.bag');
bag     = select(bag, 'Time', [2193.106, bag.EndTime]); %First-Scan is off

T       = bag.StartTime;
Ta      = 0.2;


dx      = 1/map.Resolution; dy = dx;
dTheta  = deg2rad(2);
p_x     = 0.5*ones(map.GridSize(1), map.GridSize(2), 2*pi/dTheta);

%Extract z_t
subbag   = select(bag, 'Time', [T, T+Ta]);
scanbag  = select(subbag, 'Topic', '/scan');
scanmsgs = readMessages(scanbag);
z_t      = scanmsgs{size(scanmsgs,1)};

%Extract u_t
v = 0; w = 0;
odombag  = select(subbag, 'Topic', '/odom');
odommsgs = readMessages(odombag);
for k = 1:size(odommsgs,1)
    v = v + odommsgs{k}.Twist.Twist.Linear.X;
    w = w + odommsgs{k}.Twist.Twist.Angular.Z;
end
v = v/size(odommsgs,1); w = w/size(odommsgs,1);
u_t = [v;w];

%Run GridLocalization
%tic;
p_x = GridLocalization(p_x, u_t, z_t, map, Ta, dx, dy, dTheta);
%toc;