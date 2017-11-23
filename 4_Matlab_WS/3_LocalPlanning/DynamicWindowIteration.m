function [u] = DynamicWindowIteration(vmax, wmax, v_d_max, w_d_max, Ta, nv, nw, va, wa, x, xG)
    [V, W] = velocitySearchSpace(vmax, wmax, v_d_max, w_d_max, Ta, nv, nw, va, wa);
    G  = zeros(size(V));
    H  = zeros(size(V));
    VV = zeros(size(V));
    for kv = 1:size(V, 2)
        for kw = 1:size(W,1)
            h = heading(xG, x, [V(kw,kv), W(kw,kv)], Ta)/pi;
            vv = velocity(V(1,kv), W(kw,1))/vmax;
            G(kw,kv) = 0.8*h + 0.2*vv;
            H(kw,kv) = h;
            VV(kw,kv) = vv;
        end
    end

    n_opt = find(G==max(max(G)));
    u = [V(n_opt), W(n_opt)];
end