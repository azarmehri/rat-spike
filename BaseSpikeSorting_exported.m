classdef BaseSpikeSorting_exported < matlab.ui.componentcontainer.ComponentContainer

    % Properties that correspond to underlying components
    properties (Access = private, Transient, NonCopyable)
        GridLayout  matlab.ui.container.GridLayout
        UIAxes      matlab.ui.control.UIAxes
    end

    methods (Access = protected)
        
        % Code that executes when the value of a public property is changed
        function update(comp)
            % Use this function to update the underlying components
            
        end

        % Create the underlying components
        function setup(comp)

            comp.Position = [1 1 512 455];
            comp.BackgroundColor = [0.94 0.94 0.94];

            % Create GridLayout
            comp.GridLayout = uigridlayout(comp);
            comp.GridLayout.ColumnWidth = {'1x'};
            comp.GridLayout.RowHeight = {'1x'};

            % Create UIAxes
            comp.UIAxes = uiaxes(comp.GridLayout);
            title(comp.UIAxes, 'Title')
            xlabel(comp.UIAxes, 'X')
            ylabel(comp.UIAxes, 'Y')
            zlabel(comp.UIAxes, 'Z')
            comp.UIAxes.Layout.Row = 1;
            comp.UIAxes.Layout.Column = 1;
        end
    end
end