function [l_xu] = costFunction1(x, x_new, map_arr)
x_G = [21, 12];

distance_old = norm(x_G-x);
distance_new = norm(x_G-x_new);

if(distance_old > distance_new)
    l_xu = 1;
else
    l_xu = 2;
end

if(map_arr(x_new(1), x_new(2)) == 1)
    l_xu = 100;
end

end

