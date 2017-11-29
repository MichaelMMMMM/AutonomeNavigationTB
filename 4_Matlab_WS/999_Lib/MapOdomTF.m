%Localization Bridge

tfmsg = rosmessage('geometry_msgs/TransformStamped');
tfmsg.ChildFrameId = 'odom';
tfmsg.Header.FrameId = 'map';

tfmsg.Header.Stamp = rostime('now');

tfmsg.Transform.Rotation.Z = 1;

tfmsg2 = rosmessage('geometry_msgs/TransformStamped');
tfmsg2.ChildFrameId = 'base_footprint';
tfmsg2.Header.FrameId = 'odom';
tfmsg2.Header.Stamp = rostime('now');
tfmsg2.Transform.Rotation.Z = 1;

tftree = rostf;
while(true)
    sendTransform(tftree, tfmsg);
    %sendTransform(tftree, tfmsg2);
    pause(0.01); 
end