function ChartToggleToolClicked(app, event)
    % Callback function for ChartToggleTool
    % When ChartToggleTool is clicked and state is true,
    % set BaseToggleTool and StimToggleTool state to false
    
    if app.ChartToggleTool.State == true
        % Set other toggle tools to false
        app.BaseToggleTool.State = false;
        app.StimToggleTool.State = false;
        
        % Hide the OpenBasePushTool when not in Base mode
        app.OpenBasePushTool.Visible = 'off';
        
        % Add any specific logic for chart functionality here
        fprintf('Chart mode activated\n');
    else
        fprintf('Chart mode deactivated\n');
    end
end