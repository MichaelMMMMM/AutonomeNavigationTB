function [ret] = dist(u, Ta, z, r_s, dPhi, vmax, r_T)
v = u(1); w = u(2); 
r = v/w;
rA = r+r_T;
rI = r+r_T;

if( w < 0 )
    p_R = [-r; 0];
else
    p_R = [r; 0];
end

freepath = true;
for k = 1:size(z,1)
    z_n = z(k,:);
    phi_n = z_n(1); r_n = z_n(2);
    p_n = p_R + [sin(phi_n)*r_n; cos(phi_n)*r_n]; 
    d = norm(p_n);
    dmax = d + dPhi*r_n + r_s;
    dmin = d - dPhi*r_n - r_s;
    
    if( ( (dmax < rA) && (dmax > rI) ) || ...
        ( (dmin < rA) && (dmin > rI) ) || ...
        ( (dmax > rA) && (dmin < rI) ) )
         gam = atan2(p_n(2), p_n(1));
         ret = gam*r;
         freepath = false;
         break;
    end
end
if(freepath)
    ret = vmax*Ta;
end

end

