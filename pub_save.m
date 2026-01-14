function pub_save(hfig, filename, format, varargin)
% PUB_SAVE Save figure in publication-quality format
%
% Usage:
%   pub_save(hfig, filename, format)
%   pub_save(hfig, filename, format, 'PropertyName', PropertyValue, ...)
%
% Inputs:
%   hfig     - Figure handle (use gcf for current figure)
%   filename - Output filename (without extension)
%   format   - 'pdf', 'eps', 'png', 'svg', 'tiff', or 'all'
%
% Optional Properties:
%   'Resolution' - DPI for raster formats (default: 600)
%   'Transparent' - Transparent background: true/false (default: false)
%   'Renderer'   - 'painters' or 'opengl' (default: 'painters')
%
% Examples:
%   pub_save(gcf, 'figure1', 'pdf');
%   pub_save(gcf, 'figure1', 'png', 'Resolution', 300);
%   pub_save(gcf, 'figure1', 'all');  % Saves in all formats
% 
%
% Author: Anirudh Madhusudhan
% Email: anirudhm1311@gmail.com

% Parse inputs
p = inputParser;
addParameter(p, 'Resolution', 600, @isnumeric);
addParameter(p, 'Transparent', false, @islogical);
addParameter(p, 'Renderer', 'painters', @ischar);
parse(p, varargin{:});

opts = p.Results;

% Set paper properties for proper sizing
pos = get(hfig, 'Position');
set(hfig, 'PaperPositionMode', 'Auto', 'PaperUnits', 'centimeters', ...
    'PaperSize', [pos(3), pos(4)]);

% Handle 'all' format
if strcmpi(format, 'all')
    formats = {'pdf', 'eps', 'png', 'svg'};
else
    formats = {format};
end

% Save in each requested format
for i = 1:length(formats)
    fmt = lower(formats{i});
    full_filename = filename;
    
    switch fmt
        case 'pdf'
            print(hfig, full_filename, '-dpdf', ['-' opts.Renderer], ...
                '-vector', sprintf('-r%d', opts.Resolution));
            fprintf('Saved: %s.pdf\n', filename);
            
        case 'eps'
            print(hfig, full_filename, '-depsc', ['-' opts.Renderer], ...
                '-vector', sprintf('-r%d', opts.Resolution));
            fprintf('Saved: %s.eps\n', filename);
            
        case 'png'
            if opts.Transparent
                print(hfig, full_filename, '-dpng', ['-' opts.Renderer], ...
                    sprintf('-r%d', opts.Resolution), '-transparent');
            else
                print(hfig, full_filename, '-dpng', ['-' opts.Renderer], ...
                    sprintf('-r%d', opts.Resolution));
            end
            fprintf('Saved: %s.png\n', filename);
            
        case 'svg'
            print(hfig, full_filename, '-dsvg', ['-' opts.Renderer]);
            fprintf('Saved: %s.svg\n', filename);
            
        case 'tiff'
            print(hfig, full_filename, '-dtiff', ['-' opts.Renderer], ...
                sprintf('-r%d', opts.Resolution));
            fprintf('Saved: %s.tiff\n', filename);
            
        otherwise
            warning('Unknown format: %s. Using PDF.', fmt);
            print(hfig, full_filename, '-dpdf', ['-' opts.Renderer], ...
                '-vector', sprintf('-r%d', opts.Resolution));
    end
end

fprintf('Figure saved successfully!\n');

end