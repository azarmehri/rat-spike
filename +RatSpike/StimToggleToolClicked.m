function StimToggleToolClicked(app, event)
    % Callback function for StimToggleTool
    % When StimToggleTool is clicked and state is true,
    % set BaseToggleTool and ChartToggleTool state to false
    
    if app.StimToggleTool.State == true
        % Set other toggle tools to false
        app.BaseToggleTool.State = false;
        app.ChartToggleTool.State = false;
        
        % Hide the OpenBasePushTool when not in Base mode
        app.OpenBasePushTool.Visible = 'off';
        
        % Add any specific logic for stim record functionality here
        fprintf('Stim Record mode activated\n');
    else
        fprintf('Stim Record mode deactivated\n');
    end
end