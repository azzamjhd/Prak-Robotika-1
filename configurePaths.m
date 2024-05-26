% Create the input dialog
fig = figure('Name', 'Input', 'NumberTitle', 'off', 'Position', [100, 100, 400, 250]);

% Create the edit control for Kp, Ki, Kd values
ui_input = uicontrol('Style', 'edit', 'Position', [10, 200, 380, 20], 'String', 'Enter Kp values, Ki values, Kd values (comma-separated)');

% Create the checkbox
checkbox_value = uicontrol('Style', 'checkbox', 'String', 'Use default model path', 'Position', [10, 150, 300, 20], 'Value', 1);

% Create the OK button
ok_button = uicontrol('Style', 'pushbutton', 'String', 'OK', 'Position', [10, 10, 100, 30], 'Callback', {@ok_callback, ui_input, checkbox_value});

% Callback function for the OK button
function ok_callback(~, ~, ui_input, checkbox_value)
    % Get the input values
    input_string = string(ui_input.String);
    answer = strsplit(input_string, ',');
    Kp_values = str2num(answer{1});
    Ki_values = str2num(answer{2});
    Kd_values = str2num(answer{3});

    % Check the checkbox state
    checkbox_state = get(checkbox_value, 'Value');
    if checkbox_state
        % Use default model path
        model_path = 'Modul 3\M3_P1.slx';
    else
        % Prompt user to choose model path
        [filename, pathname] = uigetfile('*.slx', 'Select the Simulink model file');
        if filename == 0
            error('No file selected. Program terminated.');
        end
        model_path = fullfile(pathname, filename);
    end

    % Rest of your script...

    % Close the figure
    close(gcf);
end
