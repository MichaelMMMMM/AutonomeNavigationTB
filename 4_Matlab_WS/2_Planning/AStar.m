%Dijkstra's Algorithm
load('corridor_map_fixed.mat');
map_arr = map2Array(map);
global cost_map;
cost_map = ones(size(map_arr));
for n = 1:size(map_arr,1)
    for k = 1:size(map_arr,2) 
        if(map_arr(n,k) == 1)
            cost_map(n,k) = inf;
        end
    end
end

x1_cor = [-7, -1.5]; xG_cor = [0, 3]; %xG_cor = [-6.5, -1.5];
x1 = map.world2grid(x1_cor);
global xG;
xG = map.world2grid(xG_cor);
x1_cor = map.grid2world(x1);
xG_cor = map.grid2world(xG);

visited = CPath(x1, @aStarCostFunction);

U = [ [1,0]; [-1, 0]; [0, 1]; [0, -1] ];

Q = CCostList();
Q.push(CPath(x1, @aStarCostFunction));

tic;
while(true)
    [path, flag] = Q.pop();
    if( flag == 0)
        break;
    end
    x = path.mPath(end, :);
    if(x == xG)
        disp('Search suceeded');
        break;
    end
    
    for ku = 1:size(U,1)
        u = U(ku, :);
        y = x+u;
        new_path = path.copy();
        new_path.append(y);
        
        visited_flag  = 0;
        visited_idnex = 0;
        for kv = 1:length(visited)
            if(y == visited(kv).mPath(end,:))
                 visited_flag = 1;
                 visited_index = kv;
                 break;
            end
        end
        if(visited_flag == 0)
            visited = [visited, new_path];
            Q.push(new_path);
        else
            if(visited(visited_index).mCost > new_path.mCost)
                visited(visited_index) = new_path; 
            end
        end

    end 
end
toc;

show(map);

path_cor = zeros(size(path.mPath));

for k = 1:size(path.mPath,1)
    path_cor(k,:) = map.grid2world(path.mPath(k,:)); 
end

hold on; plot(path_cor(:,1), path_cor(:,2)); hold off;
hold on; plot(x1_cor(1), x1_cor(2), 'r*'); hold off;
hold on; plot(xG_cor(1), xG_cor(2), 'g*'); hold off;