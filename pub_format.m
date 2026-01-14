function pub_format(hfig, varargin)
% PUB_FORMAT Apply publication formatting to an existing figure
%
% Usage:
%   pub_format(hfig)  % Apply formatting using figure's stored options
%   pub_format(hfig, 'PropertyName', PropertyValue, ...)
%
% Properties (same as pub_figure):
%   'FontSize', 'FontName', 'Grid', 'Box', 'Style'
%
% Example:
%   figure;
%   plot(x, y);
%   pub_format(gcf, 'FontSize', 14, 'Grid', 'on');
% 
%
% Author: Anirudh Madhusudhan
% Email: anirudhm1311@gmail.com

if nargin < 1 || isempty(hfig)
    hfig = gcf;
end

% Get stored options or use defaults
if isfield(hfig.UserData, 'pub_options')
    opts = hfig.UserData.pub_options;
else
    opts = struct('FontSize', 17, 'FontName', 'Times', ...
        'Grid', 'off', 'Box', 'on', 'Style', 'default');
end

% Parse additional arguments
p = inputParser;
addParameter(p, 'FontSize', opts.FontSize, @isnumeric);
addParameter(p, 'FontName', opts.FontName, @ischar);
addParameter(p, 'Style', opts.Style, @ischar);
addParameter(p, 'Grid', opts.Grid, @ischar);
addParameter(p, 'Box', opts.Box, @ischar);
parse(p, varargin{:});

opts = p.Results;
opts = apply_style_preset(opts);

% Apply formatting to all axes
ax = findall(hfig, 'Type', 'axes');
for i = 1:length(ax)
    set(ax(i), 'FontSize', opts.FontSize, 'FontName', opts.FontName, ...
        'Box', opts.Box, 'TickLabelInterpreter', 'latex');
    
    % Apply grid
    if strcmpi(opts.Grid, 'on')
        grid(ax(i), 'on');
    end
    
    % Style-specific axes properties
    if strcmpi(opts.Style, 'dark')
        set(ax(i), 'Color', [0.15 0.15 0.15], ...
            'XColor', [0.9 0.9 0.9], 'YColor', [0.9 0.9 0.9]);
    end
end

% Set LaTeX as default interpreter for all text objects
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultColorbarTickLabelInterpreter', 'latex');

% Set interpreters for all text objects
set(findall(hfig, '-property', 'Interpreter'), 'Interpreter', 'latex');
set(findall(hfig, '-property', 'FontSize'), 'FontSize', opts.FontSize);
set(findall(hfig, '-property', 'FontName'), 'FontName', opts.FontName);

% Apply line width enhancements
lines = findall(hfig, 'Type', 'line');
for i = 1:length(lines)
    if lines(i).LineWidth < 1.5
        set(lines(i), 'LineWidth', 1.5);
    end
end

% Update stored options
hfig.UserData.pub_options = opts;

end

function opts = apply_style_preset(opts)
% Apply style presets (same as in pub_figure)
switch lower(opts.Style)
    case 'nature'
        opts.FontName = 'Arial';
        opts.FontSize = 8;
    case 'ieee'
        opts.FontName = 'Times';
        opts.FontSize = 10;
    case 'minimal'
        opts.FontName = 'Helvetica';
        opts.FontSize = 16;
        opts.Box = 'off';
    case 'dark'
        opts.FontName = 'Helvetica';
        opts.FontSize = 16;
    case 'colorful'
        opts.FontName = 'Helvetica';
        opts.FontSize = 16;
end
end