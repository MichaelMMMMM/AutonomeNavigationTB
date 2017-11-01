function [ occ_state ] = inverseSensorModel2( m_i, x_t, z_t)
%Inverse Sensor model, return wether the cell is out of range (ret=1), the
%cell is free (ret=2) or the cell is occupied (ret=3)

% Alpha is the thickness of the occupied area around the measured range
alpha = 1;
% Beat is the Anglerange of the sensor
beta  = z_t.AngleMax - z_t.AngleMin;

% Distance between the roboter position and the mapcell m_i
r   = sqrt( (m_i(1) - x_t(1))^2 + (m_i(2) - x_t(2))^2 );
% Angle between the roboter direction and the mapcell m_i 
phi = atan2(m_i(2) - x_t(2), m_i(1) - x_t(1)) - x_t(3);
% Beam-Angle
phi_sens = z_t.AngleMin:z_t.AngleIncrement:z_t.AngleMax;
phi_diff = abs(phi - phi_sens);
k = find(min(phi_diff)==phi_diff);
if( ( abs(m_i(1)) < 0) && ( abs(m_i(2)) < 0) )
    bp = 23;
end
if( ( r >  min([z_t.RangeMax, z_t.Ranges(k)+alpha/2]) ) || ...
    ( abs(phi - phi_sens(k)) > (beta/2) ) || isnan(z_t.Ranges(k)) ) 
    occ_state = 1;
end
if( ( z_t.Ranges(k) < z_t.RangeMax )  && ...
    ( abs(r-z_t.Ranges(k)) < (alpha/2) ) )
    occ_state = 3;
end
if( r < z_t.Ranges(k) )
     occ_state = 2;
end
end

