function [condP] = motion_model(x_t, u_t, x_tm1, dT)
    mu  = 0.5* ( (x_t(1)-x_tm1(1))*cos(x_t(3)) + (x_t(2)-x_tm1(2))*sin(x_t(3)) ) ...
          / ( (x_t(2)-x_tm1(2))*cos(x_t(3)) - (x_t(1)-x_tm1(1))*sin(x_t(3)) );
    x_c = (x_t(1)+x_tm1(1))/2 + mu*(x_t(2)-x_tm1(2));
    y_c = (x_t(2)+x_tm1(2))/2 + mu*(x_t(1)-x_t(1));
    r_c = sqrt( (x_t(1)-x_c)^2+(x_t(2)-y_c)^2);
    
    dTheta = atan2(x_tm1(2)-y_c, x_tm1(1)-x_c) - atan2(x_t(2)-y_c, x_t(1)-x_c);
    dS     = r_c*dTheta;
    v      = dS/dT;
    w      = dTheta/dT;
    gam    = (x_tm1(3)-x_t(3))/dT - w;
    
    v_err   = v - u_t(1);
    w_err   = w - u_t(2);
    gam_err = gam;
    
    condP = normpdf(v_err,0, 0.1)*normpdf(w_err, 0, 0.1)*normpdf(gam_err, 0, 0.1);
end

