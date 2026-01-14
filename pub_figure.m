function hfig = pub_figure(varargin)
% PUB_FIGURE Create a publication-quality figure with customizable properties
%
% Usage:
%   hfig = pub_figure()  % Creates figure with default settings
%   hfig = pub_figure('PropertyName', PropertyValue, ...)
%
% Properties:
%   'Width'        - Figure width in cm (default: 20)
%   'HeightRatio'  - Height/Width ratio (default: 0.65)
%   'FontSize'     - Base font size (default: 17)
%   'FontName'     - Font name (default: 'Times')
%   'Style'        - Figure style: 'default', 'nature', 'ieee', 'minimal', 
%                    'dark', 'colorful' (default: 'default')
%   'Grid'         - Show grid: 'on' or 'off' (default: 'on')
%   'Box'          - Show box: 'on' or 'off' (default: 'on')
%   'Background'   - Background color (default: 'w' for white)
%   'LineWidth'    - Width of the line (defalut: 1.5)
%
% Example:
%   hfig = pub_figure('Width', 15, 'Style', 'nature', 'Grid', 'on');
%   plot(x, y);
%   xlabel('Time (s)');
%   ylabel('Amplitude (V)');
%   pub_save(hfig, 'myfigure', 'pdf');
% 
%
% Author: Anirudh Madhusudhan
% Email: anirudhm1311@gmail.com



% Parse input arguments
p = inputParser;
addParameter(p, 'Width', 20, @isnumeric);
addParameter(p, 'HeightRatio', 0.65, @isnumeric);
addParameter(p, 'FontSize', 17, @isnumeric);
addParameter(p, 'FontName', 'Times', @ischar);
addParameter(p, 'Style', 'default', @ischar);
addParameter(p, 'Grid', 'on', @ischar);
addParameter(p, 'Box', 'on', @ischar);
addParameter(p, 'Background', 'w');
addParameter(p, 'LineWidth', 1.5)
parse(p, varargin{:});

opts = p.Results;

% Create figure
hfig = figure('Color', opts.Background);

% Apply style presets
opts = apply_style_preset(opts);

% Set figure size
set(hfig, 'Units', 'centimeters', ...
    'Position', [3 3 opts.Width opts.HeightRatio*opts.Width]);

% Set default interpreter to LaTeX for all new graphics objects
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultColorbarTickLabelInterpreter', 'latex');

% Store options in figure UserData for later use
hfig.UserData.pub_options = opts;

end

function opts = apply_style_preset(opts)
% Apply predefined style presets

switch lower(opts.Style)
    case 'nature'
        % Nature journal style
        opts.FontName = 'Arial';
        opts.FontSize = 8;
        opts.Width = 8.5;  % Single column
        opts.Box = 'on';
        
    case 'ieee'
        % IEEE style
        opts.FontName = 'Times';
        opts.FontSize = 10;
        opts.Width = 8.5;
        opts.Box = 'on';
        
    case 'minimal'
        % Minimal clean style
        opts.FontName = 'Helvetica';
        opts.FontSize = 16;
        opts.Box = 'off';
        opts.Grid = 'off';
        
    case 'dark'
        % Dark background style
        opts.Background = [0.1 0.1 0.1];
        opts.FontName = 'Helvetica';
        opts.FontSize = 16;
        
    case 'colorful'
        % Modern colorful style
        opts.FontName = 'Helvetica';
        opts.FontSize = 16;
        opts.Box = 'on';
        opts.Grid = 'on';
end

end