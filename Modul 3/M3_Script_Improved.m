% Ask user for Kp, Ki, Kd values, model path, and folder path
prompt = {'Enter Kp values (comma-separated):', ...
          'Enter Ki values (comma-separated):', ...
          'Enter Kd values (comma-separated):', ...
          'Use default simulink model path (1 for yes, 0 for no):', ...
          'Use default save folder path (1 for yes, 0 for no):', ...
          'NRP:'
            };
dlgtitle = 'Input Modul 3 Parameters';
dims = [1 50];
definput = {'4,3,1', ...        % Default Kp values
            '1,0.2,0.5', ...    % Default Ki values
            '0.5,0.2,0.1', ...  % Default Kd values
            '1', ...            % Default use default model path
            '1', ...            % Default use default folder path
            '21' ...            % Default NRP
            };
answer = inputdlg(prompt, dlgtitle, dims, definput);

% Parse user input
Kp_values   = str2num(answer{1});
Ki_values   = str2num(answer{2});
Kd_values   = str2num(answer{3});
use_default_model_path = str2num(answer{4});
model_path  = '';
use_defaul_folder_path = str2num(answer{5});
folder_path = '';
NRP         = str2num(answer{6});

% If the user chose to use the default model path, set it accordingly
if use_default_model_path
    model_path = 'Modul 3\M3_P1.slx';
else
    % If the user didn't select a model path, prompt them to choose one
    if isempty(model_path)
        [filename, pathname] = uigetfile('*.slx', 'Select the Simulink model file');
        if filename == 0
            error('No file selected. Program terminated.');
        end
        model_path = fullfile(pathname, filename);
    end
end

% If the user chose to use the default folder path, set it accordingly
if use_defaul_folder_path
    folder_path = 'Modul 3\';
else
    if isempty(folder_path)
        pathname = uigetdir('Select the folder to save the figures');
        if pathname == 0
            error('No folder selected. Program terminated.');
        end
        folder_path = pathname;
    end
end

% Set position reference values: n/6*pi.
pos_ref_values  = [-1, 2, 4, 6, 1, 1.5, 2.5, 3];
% Motor DC MP parameter
L       = 0.062;                        % Induktansi motor
R       = 2.5;                          % Hambatan motor
Ktn     = 0.026 + (0.001 * NRP);        % Konstanta torsi motor
Kb      = 0.02 + (0.001 * NRP);         % Konstanta tegangan balik emf
J_eff   = 0.00004 + (0.00001 * NRP);    % Momen inersia rotor dan beban
f_eff   = 0.001 + (0.001 * NRP);        % Koefisien viscous rotor dan beban
% Figure size
figure_size = [100, 50, 800, 800];      % [left, bottom, width, height]
fig         = figure('Position', figure_size);
% Main loop for each position reference value
for i = 1:length(pos_ref_values)
    Pos_ref = pos_ref_values(i);
    % set panjang lengan berdasarkan posisi referensi
    if i <= 4
        Lengan = 6.8;   % Lengan 1 untuk posisi referensi -1, 2, 4, 6
    else
        Lengan = 5.3;   % Lengan 2 untuk posisi referensi 1, 1.5, 2.5, 3
    end
    % Loop for each controller type: P, PI, PD, PID
    for k = 1:4
        [Kp, Ki, Kd, controller_name] = set_controller_params(k, Kp_values, Ki_values, Kd_values);
        legend_str = set_legend(k, Kp_values, Ki_values, Kd_values, Pos_ref);
        % Run simulation
        simRes = sim(model_path);   % Simulasi model simulink
        vel     = simRes.vel;       % Data Kecepatan
        posact  = simRes.posact;    % Data posisi aktual
        err_pos = simRes.err_pos;   % Data error posisi
        posx    = simRes.posx;      % Data posisi X
        posy    = simRes.posy;      % Data posisi Y
        controller_folder = [folder_path,'\', controller_name, '\'];
        % Plot and save position response
        plot_and_save(fig, 1, ['Respon posisi RTSS kontrol ', controller_name], legend_str, posact, 'Posisi (rad)', Pos_ref);
        % Plot and save position error response
        plot_and_save(fig, 2, ['Respon error posisi RTSS kontrol ', controller_name], legend_str(2:4), err_pos, 'Posisi (rad)', Pos_ref);
        % Plot and save velocity response
        plot_and_save(fig, 3, ['Respon kecepatan RTSS kontrol ', controller_name], legend_str(2:4), vel, 'Kecepatan (rad/s)', Pos_ref);

        % Plot and save Forward kinematics
        plot_XY(fig, 4, ['Respon posisi End Effector kontrol ', controller_name], legend_str(2:4), posx, posy, 'X', 'Y', 'southwest');

        % Save the figure
        if ~exist(controller_folder, 'dir')
            mkdir(controller_folder);
        end
        filename = [controller_folder, 'All ', num2str(Pos_ref/6*pi), '.png'];
        print(fig, filename, '-dpng');

    end
    
end
% Close figure
close(fig);

% Plot and save data
function plot_and_save(fig, subplot_index, title_str, legend_str, data, ylabel_str, Pos_ref)
    subplot(2, 2, subplot_index);
    plot(data);
    title(title_str);
    ylabel(ylabel_str); xlabel('Waktu (s)');
    if Pos_ref < 0
        if subplot_index == 1
            legend(legend_str, 'Location', 'northeast');
        else
            legend(legend_str, 'Location', 'southeast');
        end
    else
        if subplot_index == 1
            legend(legend_str, 'Location', 'southeast');
        else
            legend(legend_str, 'Location', 'northeast');
        end
    end
end

% Plot X and Y effector
function plot_XY(fig, subplot_index, title_str, legend_str, dataX, dataY, xlabel_str, ylabel_str, legend_pos)
    subplot(2, 2, subplot_index);
    plot(dataX, dataY, 'HandleVisibility', 'off');
    title(title_str);
    ylabel(ylabel_str); xlabel(xlabel_str);
    % posisi terkahir data
    lastPointX = dataX(end,2);
    lastPointY = dataY(end,2);
    % Calculate the maximum absolute value from all elements in dataX and dataY
    max_val = max(max(abs([dataX(:); dataY(:)])));
    % Calculate padding
    padding = max_val * 0.1;
    hold on;
    % Set the limits of the x and y axes
    xlim([-max_val - padding, max_val + padding]);
    ylim([-max_val - padding, max_val + padding]);
    % Make the axes equal
    axis equal;
    % Add a dot at the origin (0,0)
    plot(0, 0, 'ro');
    % Add a dot at the last position
    plot(lastPointX, lastPointY, 'bo');
    hold off;
    % Activate the grid
    grid on;
    % Add a legend
    legend_str = {['Origin'], [sprintf('%.2f' ,lastPointX) ',' sprintf('%.2f',lastPointY)]};
    legend(legend_str, 'Location', legend_pos);
end

% Set controller parameters based on controller type
function [Kp, Ki, Kd, controller_name] = set_controller_params(k, Kp_values, Ki_values, Kd_values)
    Kp = [0, 0, 0];
    Ki = [0, 0, 0];
    Kd = [0, 0, 0];
    if k == 1
        controller_name = 'P';
        for j = 1:3
            Kp(j) = Kp_values(j);
            Ki(j) = 0;
            Kd(j) = 0;
        end
    elseif k == 2
        controller_name = 'PI';
        for j = 1:3
            Kp(j) = Kp_values(j);
            Ki(j) = Ki_values(j);
            Kd(j) = 0;
        end
    elseif k == 3
        controller_name = 'PD';
        for j = 1:3
            Kp(j) = Kp_values(j);
            Ki(j) = 0;
            Kd(j) = Kd_values(j);
        end
    else
        controller_name = 'PID';
        for j = 1:3
            Kp(j) = Kp_values(j);
            Ki(j) = Ki_values(j);
            Kd(j) = Kd_values(j);
        end
    end
end

% Set legend string based on controller type
function legend_str = set_legend(k, Kp_values, Ki_values, Kd_values, Pos_ref)
    if k == 1
        legend_str = {...
            ['Ref:', num2str(Pos_ref/6*pi)], ...
            ['P:', num2str(Kp_values(1))], ...
            ['P:', num2str(Kp_values(2))], ...
            ['P:', num2str(Kp_values(3))]...
        };
    elseif k == 2
        legend_str = {...
            ['Ref:', num2str(Pos_ref/6*pi)], ...
            ['P:', num2str(Kp_values(1)), ', I:', num2str(Ki_values(1))], ...
            ['P:', num2str(Kp_values(2)), ', I:', num2str(Ki_values(2))], ...
            ['P:', num2str(Kp_values(3)), ', I:', num2str(Ki_values(3))]...
        };
    elseif k == 3
        legend_str = {...
            ['Ref:', num2str(Pos_ref/6*pi)], ...
            ['P:', num2str(Kp_values(1)), ', D:', num2str(Kd_values(1))], ...
            ['P:', num2str(Kp_values(2)), ', D:', num2str(Kd_values(2))], ...
            ['P:', num2str(Kp_values(3)), ', D:', num2str(Kd_values(3))]...
        };
    elseif k == 4
        legend_str = {...
            ['Ref:', num2str(Pos_ref/6*pi)], ...
            ['P:', num2str(Kp_values(1)), ', I:', num2str(Ki_values(1)), ', D:', num2str(Kd_values(1))], ...
            ['P:', num2str(Kp_values(2)), ', I:', num2str(Ki_values(2)), ', D:', num2str(Kd_values(2))], ...
            ['P:', num2str(Kp_values(3)), ', I:', num2str(Ki_values(3)), ', D:', num2str(Kd_values(3))]...
        };
    end
end