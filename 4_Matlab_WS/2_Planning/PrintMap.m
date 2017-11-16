% Create the map-plot for documentation purposes
black_rgb     = [0, 0, 0];
dark_grey_rgb = [68, 84, 106]./255;
orange_rgb    = [237, 125, 49]./255;
dark_blue_rgb = [31, 78, 121]./255;

load('corridor_map_fixed.mat');
map_arr = map2Array(map);
figure;
outer_map_poly = [ [-9, -4]; [-9, 6]; [3 6]; [3, -4] ];
inner_map_poly = [ [-8.25, -2.75]; [-8.25, -0.25]; [-1, -0.25];...
                   [-1, 0.5]; [-8.25, 0.5]; [-8.25, 4.5];...
                   [1.5, 4.5]; [1.5, 2.5]; [-6.25, 2.5];...
                   [-6.25, 1.75]; [1.5, 1.75]; [1.5, -2.75] ];
%fill(outer_map_poly(:,1), outer_map_poly(:,2), dark_grey_rgb);
%fill(inner_map_poly(:,1), inner_map_poly(:,2), [1, 1, 1]);
%set(gca, 'color', dark_grey_rgb);
show(map);

%show(map); grid;
emlXLabel('X in Meter');
emlYLabel('Y in Meter');
emlTitle('Karte des Korridors');

%Print the start and goal position
x1_cor = [-7, -1.5]; xG_cor = [0, 3];
x1 = map.world2grid(x1_cor);
xG = map.world2grid(xG_cor);
x1_cor = map.grid2world(x1);
xG_cor = map.grid2world(xG);


hold on; plot(x1_cor(1), x1_cor(2), 's', 'Linewidth', 2,...
              'MarkerSize', 20,...
              'MarkerEdgeColor', black_rgb,...
              'MarkerFaceColor', orange_rgb); hold off;
hold on; plot(xG_cor(1), xG_cor(2), 's', 'LineWidth', 2,...
              'MarkerSize', 20,...
              'MarkerEdgeColor', black_rgb,...
              'MarkerFaceColor', dark_blue_rgb); hold off;
lgd = emlLegend({'Startposition', 'Endposition'});
%set(lgd, 'color', 'white');

print('img/KorridorBeispiel_img1.eps', '-depsc');