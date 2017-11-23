function [x_next] = movementModel(x, u, Ta)
v = u(1); w = u(2);
if(w ~= 0)
%     x_next(1) = x(1) +  v/w * ( sin(x(3))-sin(x(3)+w*Ta) );
%     x_next(2) = x(2) + -v/w * ( cos(x(3))-cos(x(3)+w*Ta) );
    x_next(1) = x(1) -  v/w * ( sin(x(3))-sin(x(3)+w*Ta) );
    x_next(2) = x(2) +  v/w * ( cos(x(3))-cos(x(3)+w*Ta) );
    x_next(3) = x(3) + w*Ta;
else 
    x_next(1) = x(1) + v*cos(x(3))*Ta;
    x_next(2) = x(2) + v*sin(x(3))*Ta;
    x_next(3) = x(3);
end
end

