%Simple Algorithm test for a 1D-map

p_0            = 0.3;
l_0            = log(p_0/(1-p_0));
p_free         = 0.2;
l_free         = log(p_free/(1-p_free));
p_occupied     = 0.8;
l_occupied     = log(p_occupied/(1-p_occupied));
map            = p_0*ones(1,10);
obstacle_index = 7;
alpha          = 2;

n = 0;
while(n < 50)
    n = n + 1;
    l_map = zeros(size(map));
    for k = 1:length(map)
         l_map(k) = log(map(k)/(1-map(k)));
         if(k >= (obstacle_index - alpha/2) && k <= (obstacle_index + alpha/2) )
             l_map(k) = l_map(k) + l_occupied - l_0;
         else
             if( k < (obstacle_index - alpha/2) )
                 l_map(k) = l_map(k) + l_free - l_0;
             end
         end
         map(k) = 1 - (1 / (1+exp(l_map(k))));
    end
end