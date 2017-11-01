function plotRobot(x_t)

R_P_W  = [cos(x_t(3)), sin(x_t(3)), 0; -sin(x_t(3)), cos(x_t(3)), 0; 0, 0, 1];
r_x    = [x_t(1), x_t(2); x_t(1)+5*cos(x_t(3)), x_t(2)+5*sin(x_t(3))];

hold on; plot(x_t(1), x_t(2), 'r*'); hold off;
hold on; plot(r_x(:,1), r_x(:,2), 'g'); hold off;

end

