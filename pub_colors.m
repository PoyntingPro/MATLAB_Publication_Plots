function colors = pub_colors(scheme, n)
% PUB_COLORS Get publication-quality color schemes
%
% Usage:
%   colors = pub_colors(scheme)      % Get default number of colors
%   colors = pub_colors(scheme, n)   % Get n colors from scheme
%
% Available schemes:
%   'default'    - MATLAB default colors (enhanced)
%   'nature'     - Nature journal style colors
%   'vibrant'    - Vibrant, distinguishable colors
%   'pastel'     - Soft pastel colors
%   'colorblind' - Colorblind-friendly palette
%   'grayscale'  - Grayscale for B&W printing
%   'warm'       - Warm color palette
%   'cool'       - Cool color palette
%   'contrast'   - High contrast colors
%
% Output:
%   colors - n×3 matrix of RGB values (0-1 range)
%
% Example:
%   colors = pub_colors('nature', 5);
%   figure; hold on;
%   for i = 1:5
%       plot(x, y(:,i), 'Color', colors(i,:), 'LineWidth', 2);
%   end
% 
%
% Author: Anirudh Madhusudhan
% Email: anirudhm1311@gmail.com

if nargin < 2
    n = 7;  % Default number of colors
end

% Define color schemes
switch lower(scheme)
    case 'default'
        base_colors = [
            0.15, 0.55, 0.87;  % Blue
            0.85, 0.33, 0.10;  % Red
            0.93, 0.69, 0.13;  % Yellow
            0.49, 0.18, 0.56;  % Purple
            0.47, 0.67, 0.19;  % Green
            0.30, 0.75, 0.93;  % Cyan
            0.64, 0.08, 0.18;  % Dark red
        ];
        
    case 'nature'
        base_colors = [
            0.12, 0.47, 0.71;  % Blue
            0.89, 0.10, 0.11;  % Red
            0.20, 0.63, 0.17;  % Green
            1.00, 0.50, 0.00;  % Orange
            0.42, 0.24, 0.60;  % Purple
            0.69, 0.35, 0.16;  % Brown
            0.94, 0.89, 0.26;  % Yellow
        ];
        
    case 'vibrant'
        base_colors = [
            0.90, 0.16, 0.54;  % Pink
            0.24, 0.71, 0.54;  % Teal
            1.00, 0.60, 0.00;  % Orange
            0.40, 0.40, 0.95;  % Blue
            0.95, 0.90, 0.25;  % Yellow
            0.60, 0.20, 0.80;  % Purple
            0.20, 0.80, 0.20;  % Green
        ];
        
    case 'pastel'
        base_colors = [
            0.68, 0.78, 0.91;  % Light blue
            1.00, 0.80, 0.80;  % Light red
            0.80, 0.92, 0.77;  % Light green
            1.00, 0.93, 0.70;  % Light yellow
            0.87, 0.80, 0.94;  % Light purple
            0.95, 0.87, 0.73;  % Light orange
            0.90, 0.90, 0.90;  % Light gray
        ];
        
    case 'colorblind'
        % Colorblind-friendly palette (Wong 2011)
        base_colors = [
            0.00, 0.45, 0.70;  % Blue
            0.90, 0.62, 0.00;  % Orange
            0.00, 0.62, 0.45;  % Green
            0.80, 0.47, 0.65;  % Pink
            0.34, 0.71, 0.91;  % Sky blue
            0.94, 0.89, 0.26;  % Yellow
            0.84, 0.37, 0.00;  % Vermillion
        ];
        
    case 'grayscale'
        gray_vals = linspace(0.1, 0.9, 7);
        base_colors = [gray_vals', gray_vals', gray_vals'];
        
    case 'warm'
        base_colors = [
            0.80, 0.00, 0.00;  % Red
            1.00, 0.40, 0.00;  % Orange
            1.00, 0.80, 0.00;  % Gold
            0.90, 0.60, 0.40;  % Tan
            0.60, 0.20, 0.00;  % Brown
            1.00, 0.20, 0.40;  % Hot pink
            0.80, 0.40, 0.00;  % Dark orange
        ];
        
    case 'cool'
        base_colors = [
            0.00, 0.40, 0.80;  % Blue
            0.00, 0.60, 0.60;  % Teal
            0.40, 0.00, 0.80;  % Purple
            0.00, 0.80, 0.80;  % Cyan
            0.20, 0.00, 0.60;  % Indigo
            0.40, 0.80, 1.00;  % Sky blue
            0.60, 0.40, 0.80;  % Lavender
        ];
        
    case 'contrast'
        base_colors = [
            0.00, 0.00, 0.00;  % Black
            1.00, 0.00, 0.00;  % Red
            0.00, 0.00, 1.00;  % Blue
            1.00, 0.65, 0.00;  % Orange
            0.00, 0.50, 0.00;  % Green
            0.75, 0.00, 0.75;  % Magenta
            0.00, 0.75, 0.75;  % Cyan
        ];
        
    otherwise
        warning('Unknown color scheme. Using default.');
        base_colors = pub_colors('default', n);
        return;
end

% If n is larger than base colors, interpolate
if n > size(base_colors, 1)
    colors = interp_colors(base_colors, n);
else
    colors = base_colors(1:n, :);
end

end

function colors_interp = interp_colors(base_colors, n)
% Interpolate colors to get n colors
m = size(base_colors, 1);
t_base = linspace(0, 1, m);
t_interp = linspace(0, 1, n);

colors_interp = zeros(n, 3);
for i = 1:3
    colors_interp(:,i) = interp1(t_base, base_colors(:,i), t_interp, 'pchip');
end

% Ensure values are in [0,1]
colors_interp = max(0, min(1, colors_interp));
end