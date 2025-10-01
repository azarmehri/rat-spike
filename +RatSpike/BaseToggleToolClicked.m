function BaseToggleToolClicked(app, event)
    % Callback function for BaseToggleTool
    % When BaseToggleTool is clicked and state is true, 
    % set StimToggleTool and ChartToggleTool state to false
    
    if app.BaseToggleTool.State == true
        % Set other toggle tools to false
        app.StimToggleTool.State = false;
        app.ChartToggleTool.State = false;
        
        % Show the OpenBasePushTool when BaseToggleTool is active
        app.OpenBasePushTool.Visible = 'on';
        
        % Add any specific logic for base record functionality here
        fprintf('Base Record mode activated\n');
    else
        % Hide the OpenBasePushTool when BaseToggleTool is inactive
        app.OpenBasePushTool.Visible = 'off';
        
        fprintf('Base Record mode deactivated\n');
    end
end