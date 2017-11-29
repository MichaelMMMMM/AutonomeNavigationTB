function [p_t] = GridLocalization(p_tm1, u_t, z_t, m, dT, dx, dy, dTheta)
    p_t = p_tm1;
    inverse_n = 0;
    for kx = 1:size(p_tm1,1)
        for ky = 1:size(p_tm1,2)
            for kT = 1:size(p_tm1,3)
                tic;
                p_tmp = 0;
                x_k   = [(kx-0.5)*dx; (ky-0.5)*dy; (kT-0.5)*dTheta];
                for ix = 1:size(p_tm1, 1)
                    for iy = 1:size(p_tm1, 2)
                        for iT = 1:size(p_tm1, 3)
                            x_i = [(ix-0.5)*dx; (iy-0.5)*dy; (iT-0.5)*dTheta];
                            p_i_tm1 = p_tm1(ix, iy, iT);
                            p_tmp = p_tmp + p_i_tm1 * motion_model(x_k, u_t, x_i, dT);
                        end
                    end
                end
                toc;
                %Missing normalizer
                p_k   = p_tmp * measurement_model(z_t, x_k, m);
                %Sum up all posterior, non-normalized probabilities
                inverse_n = inverse_n + p_k;
                p_t(kx, ky, kT) = p_k;
            end
        end
    end
    %Carry out normalization in order to achieve a proper probabilty
    %distribution
    p_t = p_t./inverse_n;
end

