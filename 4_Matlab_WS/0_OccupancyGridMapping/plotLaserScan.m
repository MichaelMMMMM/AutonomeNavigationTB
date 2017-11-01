function plotLaserScan(x_t, scan_msg, nbrOfPoints)

r      = scan_msg.RangeMax;
phi_l  = x_t(3)+scan_msg.AngleMax;
sens_l = [x_t(1), x_t(2); x_t(1)+r*cos(phi_l), x_t(2)+r*sin(phi_l)];
phi_r  = x_t(3)+scan_msg.AngleMin;
sens_r = [x_t(1), x_t(2); x_t(1)+r*cos(phi_r), x_t(2)+r*sin(phi_r)];

for k = 1:639/nbrOfPoints:640
    k   = round(k);
    phi = x_t(3)+scan_msg.AngleMin+scan_msg.AngleIncrement*(k-1);
    r   = scan_msg.Ranges(k);
    p   = [x_t(1)+r*cos(phi), x_t(2)+r*sin(phi)];
    hold on; plot(p(1), p(2), 'b*'); hold off;   
end

hold on; plot(sens_l(:,1),sens_l(:,2), 'g'); hold off;
hold on; plot(sens_r(:,1), sens_r(:,2), 'g'); hold off;

end

