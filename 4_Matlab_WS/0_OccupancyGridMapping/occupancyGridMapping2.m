function [ m_t ] = occupancyGridMapping2( m_tm1, xt, zt )
% Algorithm for occupancy grid mapping
% l_tm1 is the map in log odds at time t-1, the dataformat is a 2D-array
% with each element holding the log odds posterior p(m_i|z_1:t, x_1:t)

%
p_m_0 = 0.5;
l_0   = log(p_m_0/(1-p_m_0)); 

p_free = 0.1;
p_occ  = 0.9;

l_free     = log(p_free/(1-p_free));
l_occupied = log(p_occ/(1-p_occ));

for row_index = 1:m_tm1.GridSize(1)
    for column_index = 1:m_tm1.GridSize(2)
        %Coordinates of mapcell
        m_i = grid2world(m_tm1, [row_index,column_index]);
        %Check wether the cell is out of range, free or occupied
        occ_state = inverseSensorModel3(m_i, xt, zt);
        if(occ_state == 2)
            %Cell is free, adjust value
            %Posterior of mapcell at time t-1
            p_tm1 = getOccupancy(m_tm1, grid2world(m_tm1, [row_index, column_index]));
            %Log-Odds of posterior of mapcall at time t-1
            l_tm1 = log(p_tm1/(1-p_tm1));
            %Calculate Log-Odds at time t according to algorithm
            l_t   = l_tm1 + l_free - l_0;
            %Calculate posterior at time t
            p_t   = 1 - 1/(1+exp(l_t));
            %Save the changes in the map
            setOccupancy(m_tm1, grid2world(m_tm1, [row_index, column_index]), p_t);
        else
            if(occ_state == 3)
            %Cell is occpued, adjust value
            %Posterior of mapcell at time t-1
            p_tm1 = getOccupancy(m_tm1, grid2world(m_tm1, [row_index, column_index]));
            %Log-Odds of posterior of mapcall at time t-1
            l_tm1 = log(p_tm1/(1-p_tm1));
            %Calculate Log-Odds at time t according to algorithm
            l_t   = l_tm1 + l_occupied - l_0;
            %Calculate posterior at time t
            p_t   = 1 - 1/(1+exp(l_t));
            %Save the changes in the map
            setOccupancy(m_tm1, grid2world(m_tm1, [row_index, column_index]), p_t);
            end
        end
    end
end
m_t = m_tm1;
end

