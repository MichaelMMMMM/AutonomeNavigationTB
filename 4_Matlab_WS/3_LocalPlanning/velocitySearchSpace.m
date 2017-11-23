function [V,W] = velocitySearchSpace(vmax, wmax, v_d_max, w_d_max, Ta, nv, nw, va, wa)
vamax = va+v_d_max*Ta;
vamin = va-v_d_max*Ta;
wamax = wa+w_d_max*Ta;
wamin = wa-w_d_max*Ta;
wmin  = -wmax;

if( vmax > vamax) vamax = vamax; end
if( vamin < 0 ) vamin = 0; end
if( wmax > wamax) wamax = wamax; end
if( wamin > wmin) wamin = wamin; end

dv = (vamax - vamin) / nv;
dw = (wamax - wamin) / nw;

v  = vamin:dv:vamax;
w  = wamin:dw:wamax;

[V,W] = meshgrid(v,w);

end

