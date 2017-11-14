function cost = aStarCostFunction(x, x_new)
global xG;
global cost_map;
cost = cost_map(x_new(1), x_new(2)) + abs(xG(1)-x_new(1)) + abs(xG(2)-x_new(2));

end