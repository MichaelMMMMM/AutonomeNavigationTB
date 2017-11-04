%Generate Corridor-Map

map = robotics.OccupancyGrid(12, 10, 4);
map.GridLocationInWorld = [-9,-4]; 

map.OccupiedThreshold = 0.95;
map.FreeThreshold     = 0.05;

load('corridor_map.mat');

for k = 1:map.GridSize(2)
    setOccupancy(map, grid2world(map, [1, k]), 1); 
    setOccupancy(map, grid2world(map, [2, k]), 1); 
    setOccupancy(map, grid2world(map, [3, k]), 1); 
    setOccupancy(map, grid2world(map, [4, k]), 1); 
    setOccupancy(map, grid2world(map, [5, k]), 1); 
    setOccupancy(map, grid2world(map, [6, k]), 1); 
    setOccupancy(map, grid2world(map, [7, k]), 1); 
    
    setOccupancy(map, grid2world(map, [36, k]), 1);
    setOccupancy(map, grid2world(map, [37, k]), 1); 
    setOccupancy(map, grid2world(map, [38, k]), 1); 
    setOccupancy(map, grid2world(map, [39, k]), 1); 
    setOccupancy(map, grid2world(map, [40, k]), 1); 
end

for k = 1:map.GridSize(1)
    setOccupancy(map, grid2world(map, [k, 1]), 1);  
    setOccupancy(map, grid2world(map, [k, 2]), 1);  
    setOccupancy(map, grid2world(map, [k, 3]), 1);  
    setOccupancy(map, grid2world(map, [k, 4]), 1);  
    
    setOccupancy(map, grid2world(map, [k, 48]), 1);  
    setOccupancy(map, grid2world(map, [k, 47]), 1);  
    setOccupancy(map, grid2world(map, [k, 46]), 1);  
    setOccupancy(map, grid2world(map, [k, 45]), 1);
    setOccupancy(map, grid2world(map, [k, 44]), 1);  
    setOccupancy(map, grid2world(map, [k, 43]), 1);  
end

for k = 13:48
    setOccupancy(map, grid2world(map, [16, k]), 1);
    setOccupancy(map, grid2world(map, [17, k]), 1);
end


