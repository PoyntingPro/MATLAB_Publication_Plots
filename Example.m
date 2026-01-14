%% Example Script - Anirudh Madhusudhan
close all;
clc;

%% Example data
t = 0:0.02:10;
a = t.*sin(2*pi*t) + 2*rand(1,length(t));

b = t.*cos(2*pi*t) + t.*0.25.*cos(3*pi*t)+  t.*0.25.*cos(5*pi*t)+2*rand(1,length(t));

x = linspace(-2*pi, 2*pi, 100);
y =  linspace(-1*pi, 1*pi, 100);

[X, Y] = meshgrid(x,y);

Z = 4*exp(-0.25*Y.^2).*sin(2*X);


%% PLotting

hfig = pub_figure(); % The default is 20cm Width and height 13cm Standard for publication
% hfig = pub_figure('Width', 18, 'HeightRatio', 0.65); % for custom sizes

plot(t, a)
xlabel("Time in s ")
ylabel('Impedance in $\Omega$')
legend('$\Omega$')
pub_format(hfig)
pub_save(hfig, 'Example1_Plot', 'png') %% if you want to save the plot

hfig1 = pub_figure(); % The default is 20cm Width and height 13cm Standard for publication
% hfig = pub_figure('Width', 18, 'HeightRatio', 0.65); % for custom sizes

plot(t, a)
hold on;
plot(t, b);
xlabel("Time in s ")
ylabel('Impedance in $\Omega$')
legend('$\Omega_{\pi}$', '$\Omega_{ani}$')
pub_format(hfig1)
pub_save(hfig1, 'Example2_Plot', 'png') %% if you want to save the plot



hfig2 = pub_figure();

surf(X,Y, Z)
xlabel("Time in s ")
ylabel('Impedance in $\Omega$')
zlabel('Torque in $\tau$')
pub_format(hfig2)

hfig3 = pub_figure('Width', 20, 'HeightRatio', 0.8);

subplot(2,2,1)
plot(t, sin(t));
xlabel('$t$'); ylabel('sin($t$)');

subplot(2,2,2)
plot(t, cos(t));
xlabel('$t$'); ylabel('cos($t$)');

subplot(2,2,3)
plot(t, sin(t).*cos(t), 'k-');
xlabel('$t$'); ylabel('sin($t$)cos($t$)');

subplot(2,2,4)
plot(t, exp(-0.2*t));
xlabel('$t$'); ylabel('$e^{-0.2t}$');

pub_format(hfig3);
