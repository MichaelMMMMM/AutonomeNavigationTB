function map_array = map2Array(map)
    map_array = zeros(map.GridSize);
    for kr = 1:map.GridSize(1)
        for kc = 1:map.GridSize(2)
             if(map.getOccupancy(map.grid2world([kr, kc])) > 0.9)
                 map_array(kr, kc) = 1;
             end
        end
    end
end