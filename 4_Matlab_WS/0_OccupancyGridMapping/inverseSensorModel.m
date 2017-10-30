function [ diff_l_i ] = inverseSensorModel( m_i, x_t, z_t, l_0 )
%Inverse Sensor Model calculating the log odds difference of mapcell i

p_free = 0.1;
p_occ  = 0.9;

l_free     = log(p_free/(1-p_free));
l_occupied = log(p_occ/(1-p_occ));

% Alpha is the thickness of the occupied area around the measured range
alpha = 0.5;
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
    diff_l_i = l_0;
end
if( ( z_t.Ranges(k) < z_t.RangeMax )  && ...
    ( abs(r-z_t.Ranges(k)) < (alpha/2) ) )
    diff_l_i = l_occupied;
end
if( r < z_t.Ranges(k) )
    diff_l_i = l_free;
end
if(exist('diff_l_i') == 0)
    bp = 23;
end
end

