%Forward-Value-Iteration

load('corridor_map_fixed.mat');
map_arr = map2Array(map);

x1_cor = [-7, -1.5]; xG_cor = [-6, 1];
x1 = map.world2grid(x1_cor);
xG = map.world2grid(xG_cor);
x1_cor = map.grid2world(x1);
xG_cor = map.grid2world(xG);

path = x1;
U    = [ [1,0]; [-1, 0]; [0, 1]; [0, -1] ];
x    = x1;


tic;
while(true)
    X = x - U;
    C = zeros(4,1);
    for k = 1:length(X)
        C(k) = costFunction1(x, X(k,:), map_arr); 
    end
    
    min_index = find(C==min(C));
    min_index = min_index(1);
    x = X(min_index,:);
    path = [path; x];
    if(x == xG)
        break;
    end
end
toc;

show(map);

path_cor = zeros(size(path));

for k = 1:size(path,1)
    path_cor(k,:) = map.grid2world(path(k,:)); 
end

hold on; plot(path_cor(:,1), path_cor(:,2)); hold off;
hold on; plot(x1_cor(1), x1_cor(2), 'r*'); hold off;
hold on; plot(xG_cor(1), xG_cor(2), 'g*'); hold off;