% Depth-First Search

load('corridor_map_fixed.mat');
map_arr = map2Array(map);

x1_cor = [-7, -1.5]; xG_cor = [0, 3.5];
x1 = map.world2grid(x1_cor);
xG = map.world2grid(xG_cor);
x1_cor = map.grid2world(x1);
xG_cor = map.grid2world(xG);

visited = [ x1 ];
%Consider Occupied States as visited
for rk = 1:size(map_arr,1)
    for rc = 1:size(map_arr,2)
        if(map_arr(rk, rc) == 1)
            visited = [visited; [rk, rc]];
        end
    end
end

U = [ [1,0]; [-1, 0]; [0, 1]; [0, -1] ];
%U = [ [-1,0]; [0, -1]; [1, 0]; [0, 1] ];

Q = CLIFO();
Q.push(x1);

tic;
while(true)
    [path, flag] = Q.pop();
    if( flag == 0)
        break;
    end
    x = path(end, :);
    if(x == xG)
        disp('Search suceeded');
        break;
    end
    
    for ku = 1:size(U,1)
        u = U(ku, :);
        y = x+u;
        if(sum(ismember(visited, y, 'rows')) == 0)
            visited = [visited; y];
            new_path = [path; y];
            Q.push(new_path);
        end
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
