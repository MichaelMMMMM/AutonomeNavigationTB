function [ret] = heading(x_G, x, u, Ta)
x_next = movementModel(x, u, Ta);
phi    = atan2(x_G(2)-x_next(2), x_G(1)-x_next(1));
theta  = phi - x_next(3);
ret = pi - abs(theta);
end

