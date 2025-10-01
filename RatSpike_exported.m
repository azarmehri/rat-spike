classdef RatSpike_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure          matlab.ui.Figure
        Toolbar           matlab.ui.container.Toolbar
        BaseToggleTool    matlab.ui.container.toolbar.ToggleTool
        OpenBasePushTool  matlab.ui.container.toolbar.PushTool
        StimToggleTool    matlab.ui.container.toolbar.ToggleTool
        ChartToggleTool   matlab.ui.container.toolbar.ToggleTool
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: BaseToggleTool
        function BaseToggleToolClicked(app, event)
            
        end

        % Callback function: StimToggleTool
        function StimToggleToolClicked(app, event)
            
        end

        % Callback function: ChartToggleTool
        function ChartToggleToolClicked(app, event)
            
        end

        % Callback function: OpenBasePushTool
        function OpenBasePushToolClicked(app, event)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create Toolbar
            app.Toolbar = uitoolbar(app.UIFigure);

            % Create BaseToggleTool
            app.BaseToggleTool = uitoggletool(app.Toolbar);
            app.BaseToggleTool.Tooltip = {'Base Record'};
            app.BaseToggleTool.ClickedCallback = createCallbackFcn(app, @BaseToggleToolClicked, true);
            app.BaseToggleTool.Icon = fullfile(pathToMLAPP, 'icons', 'waves.svg');

            % Create OpenBasePushTool
            app.OpenBasePushTool = uipushtool(app.Toolbar);
            app.OpenBasePushTool.Visible = 'off';
            app.OpenBasePushTool.Tooltip = {'Open Base File'};
            app.OpenBasePushTool.ClickedCallback = createCallbackFcn(app, @OpenBasePushToolClicked, true);
            app.OpenBasePushTool.Icon = fullfile(pathToMLAPP, 'icons', 'folder-open.svg');

            % Create StimToggleTool
            app.StimToggleTool = uitoggletool(app.Toolbar);
            app.StimToggleTool.Tooltip = {'Stim Record'};
            app.StimToggleTool.ClickedCallback = createCallbackFcn(app, @StimToggleToolClicked, true);
            app.StimToggleTool.Icon = fullfile(pathToMLAPP, 'icons', 'activity.svg');
            app.StimToggleTool.Separator = 'on';

            % Create ChartToggleTool
            app.ChartToggleTool = uitoggletool(app.Toolbar);
            app.ChartToggleTool.Tooltip = {'Chart'};
            app.ChartToggleTool.ClickedCallback = createCallbackFcn(app, @ChartToggleToolClicked, true);
            app.ChartToggleTool.Icon = fullfile(pathToMLAPP, 'icons', 'chart-spline.svg');
            app.ChartToggleTool.Separator = 'on';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = RatSpike_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end