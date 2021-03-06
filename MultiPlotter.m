clear all

'Select First File'
[file1 path] = uigetfile('*.txt','Select the text-file')
filestr1 = strcat(path,file1);
data1 = dlmread(filestr1) ;

'Select Second File'
[file2 path] = uigetfile('*.txt','Select the text-file')
filestr2 = strcat(path,file2);
data2 = dlmread(filestr2) ;


V1 = data1(1,:);
V2 = data2(1,:);

v1 = data1(2,:);
v2 = data2(2,:);

theta1 = data1(3,:);
theta2 = data2(3,:);


t1 = data1(6,:);
t2 = data2(6,:);


q1 = data1(7,:);
q2 = data2(7,:);

IspNet1 = data1(8,:);
IspNet2 = data2(8,:);

Alpha1 = data1(9,:);
Alpha2 = data2(9,:);

% figure out horizontal motion
H1(1) = 0;
for i = 1:length(V1)-1
H1(i+1) = v1(i)*(t1(i+1) - t1(i))*cos(theta1(i)) + H1(i);
end


H2(1) = 0;
for i = 1:length(V2)-1
H2(i+1) = v2(i)*(t2(i+1) - t2(i))*cos(theta2(i)) + H2(i);
end


figure(1)



subplot(2,6,[1,6])
title('Trajectory Comparison')
hold on
ax1 = gca;
plot(H1/1000, V1/1000, 'Color','k', 'LineStyle', '-')
plot(H2/1000, V2/1000, 'Color','k', 'LineStyle', '-.')

h = legend(ax1,  '45kPa', '55kPa');

hlt = text(...
    'Parent', h.DecorationContainer, ...
    'String', 'Maximum Dynamic Pressure', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'Position', [0.5, 1.05, 0], ...
    'Units', 'normalized');

subplot(2,6,[7,9])
hold on
ax2 = gca;

plot(t1, v1/10^3, 'Color','k', 'LineStyle', '--', 'LineWidth', 1.2)
plot(t2, v2/10^3, 'Color','k', 'LineStyle', '-', 'LineWidth', 1.2)

plot(t1, q1/10^4, 'Color','k', 'LineStyle', '-')
plot(t2, q2/10^4, 'Color','k', 'LineStyle', '-.')

plot(t1, rad2deg(theta1), 'Color','k', 'LineStyle', '--')
plot(t2, rad2deg(theta2), 'Color','k', 'LineStyle', ':', 'LineWidth', 1.5)

h = legend(ax2,  '45kPa Velocity (m/s x 10^3)', '55kPa Velocity (m/s x 10^3)', '45kPa Dynamic Pressure (kPa x 10^4)', '55kPa Dynamic Pressure (kPa x 10^4)', '45kPa Trajectory Angle (deg)', '55kPa Trajectory Angle (deg)');


subplot(2,6,[10,12])
hold on
ax3 = gca;
plot(t1, IspNet1/10^2, 'Color','k', 'LineStyle', '-')
plot(t2, IspNet2/10^2, 'Color','k', 'LineStyle', '-.')

plot(t1, Alpha1, 'Color','k', 'LineStyle', '--')
plot(t2, Alpha2, 'Color','k', 'LineStyle', ':', 'LineWidth', 1.5)

h = legend(ax3,  '45kPa Net Isp (s x 10^2)', '55kPa Net Isp (s x 10^2)', '45kPa Angle of Attack (degrees)', '55kPa Angle of Attack (degrees)');
