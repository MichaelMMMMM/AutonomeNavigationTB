function cost = costFunction2(x, x_new)
global cost_map;
cost = cost_map(x_new(1), x_new(2));
end