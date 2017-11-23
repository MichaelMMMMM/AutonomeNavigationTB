%Local-Planning

load('TestPath1.mat');
load('corridor_map_fixed.mat');

x0 = path.mPath(1,:);
xG = path.mPath(end,:);

vmax = 0.65;
wmax = pi;
v_d_max = 0.65;
w_d_max = pi;

Ta = 0.25;

nv = 10;
nw = 10;

va = 0;
wa = 0;

x   = map.grid2world(path.mPath(1,:))';
x   = [x; pi/2];
xG  = [x(1)+1;x(2);0];
% x   = [x; pi/2];
% pos = x(1:2);
% xG  = map.grid2world(path.mPath(2,:))';
% dmin = 0.1;
% posIndex = 2;

path = [x'];

while(true)
    u = DynamicWindowIteration(vmax, wmax, v_d_max, w_d_max, Ta, nv, nw, va, wa, x, xG);
    x = movementModel(x,u,Ta);
    path = [path; x];
    d = norm(xG(1:2)-x(1:2)');
    if(d < dmin)
        if(posIndex == length(path.mPath))
            break;
        end
        posIndex = posIndex + 1;
        xG = map.grid2world(path.mPath(posIndex,:))';
    end
end
