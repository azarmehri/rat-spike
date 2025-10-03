function OpenBasePushToolClicked(app, event)
    % Callback function for OpenBasePushTool
    % Opens file dialog to select .mat files for base record processing
    
    % Open file dialog to select .mat files
    [filename, pathname] = uigetfile(...
        {'*.mat', 'MATLAB Files (*.mat)'}, ...
        'Select Base Record MAT File');
    
    if isequal(filename, 0) || isequal(pathname, 0)
        % User cancelled the dialog
        fprintf('File selection cancelled\n');
        return;
    end
    
    % Full path to selected file
    fullFilePath = fullfile(pathname, filename);
    
    % Load and process the .mat file
    try
        % Create progress dialog
        progressDlg = uiprogressdlg(app.UIFigure, 'Title', 'Base File', ...
            'Message', 'Initializing...', 'Indeterminate', 'on');
        
        fprintf('Loading base file: %s\n', fullFilePath);
        
        % Update progress - checking file
        progressDlg.Message = 'Checking file contents...';
        progressDlg.Indeterminate = 'on';
        
        % Use matfile for efficient access
        matObj = matfile(fullFilePath);
        varNames = who(matObj);
        
        % Check if file contains raw_data
        if ismember('raw_data', varNames)
            % Update progress - loading data
            progressDlg.Message = 'Loading data...';
            
            raw_data = matObj.raw_data;
            if size(raw_data, 1) > size(raw_data, 2)
                raw_data = raw_data'; % Ensure column vector
            end

            app.Fs = matObj.fs;
            
            % Update progress - filtering data
            progressDlg.Message = 'Filtering data...';
            app.BaseFilteredData = FIR_filter(raw_data, app.Fs, 1, 100, 100);


            % Close progress dialog and show success
            close(progressDlg);
            
        else
            % Close progress dialog
            close(progressDlg);
            
            fprintf('Warning: raw_data variable not found in file\n');
            fprintf('Available variables: %s\n', strjoin(varNames, ', '));
            uialert(app.UIFigure, sprintf('The selected file does not contain a "raw_data" variable.\n\nAvailable variables:\n%s', ...
                strjoin(varNames, ', ')), 'Variable Not Found', 'Icon', 'warning');
        end
        
    catch ME
        % Close progress dialog if it exists
        if exist('progressDlg', 'var') && isvalid(progressDlg)
            close(progressDlg);
        end
        
        fprintf('Error loading file: %s\n', ME.message);
        uialert(app.UIFigure, sprintf('Error loading file: %s', ME.message), 'File Load Error', 'Icon', 'error');
    end
end