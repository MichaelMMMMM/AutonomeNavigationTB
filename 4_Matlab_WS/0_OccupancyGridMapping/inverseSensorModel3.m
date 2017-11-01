function [cell_state] = inverseSensorModel3(m_i, x_t, z_t)
%Inverse Sensor model, return wether the cell is out of range (ret=1), the
%cell is free (ret=2) or the cell is occupied (ret=3)

alpha = 0.5;

[phi, r] = cart2pol(m_i(1)-x_t(1), m_i(2)-x_t(2));
phi_max  = x_t(3)+z_t.AngleMax;
phi_min  = x_t(3)+z_t.AngleMin;

r_max    = z_t.RangeMax;
r_min    = z_t.RangeMin;

if( (phi < phi_max) && (phi > phi_min) )
    if( (r < r_max) && (r > r_min) )
         phi_sens   = (z_t.AngleMin:z_t.AngleIncrement:z_t.AngleMax)+x_t(3);
         beam_index = find(min(abs(phi_sens-phi))==min(abs(phi_sens-phi)));
         if( r < (z_t.Ranges(beam_index) - alpha/2) )
             cell_state = 2;
             return
         else
             if( r > (z_t.Ranges(beam_index) + alpha/2) )
                 cell_state = 1;
                 return;
             else
                 cell_state = 3;
                 return;
             end
         end
    else
        cell_state = 1;
        return;
    end
else
    cell_state = 1;
    return;
end

end

