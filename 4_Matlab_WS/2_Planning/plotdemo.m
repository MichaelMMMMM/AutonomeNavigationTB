% %Plot-Demo

x = [0:0.01:7];

y = 1 + sin(x);

plot(x, y);
hold on;
plot(0, 1, 'or');
plot(pi, 1, 'or');
plot(2*pi, 1, 'or');
hold off;

xticks([0, pi, 2*pi]);
xticklabels({'0', '\pi', '2\cdot \pi'});