function OpenBasePushToolClicked(app, event)
    % Callback function for OpenBasePushTool
    % This tool is used to open base files when in Base Record mode
    
    % Open file dialog to select base file
    [filename, pathname] = uigetfile(...
        {'*.mat;*.dat;*.bin', 'Data Files (*.mat,*.dat,*.bin)'; ...
         '*.mat', 'MATLAB Files (*.mat)'; ...
         '*.dat', 'Data Files (*.dat)'; ...
         '*.bin', 'Binary Files (*.bin)'; ...
         '*.*', 'All Files (*.*)'}, ...
        'Select Base Record File');
    
    if isequal(filename, 0) || isequal(pathname, 0)
        % User cancelled the dialog
        fprintf('File selection cancelled\n');
        return;
    end
    
    % Full path to selected file
    fullFilePath = fullfile(pathname, filename);
    
    % Add logic here to load and process the base record file
    fprintf('Opening base file: %s\n', fullFilePath);
    
    % Example: Load the file (adjust based on your file format)
    try
        if endsWith(filename, '.mat')
            data = load(fullFilePath);
            fprintf('Successfully loaded MAT file\n');
        else
            % Handle other file formats as needed
            fprintf('File loaded: %s\n', filename);
        end
    catch ME
        fprintf('Error loading file: %s\n', ME.message);
        uialert(app.UIFigure, sprintf('Error loading file: %s', ME.message), 'File Load Error');
    end
end