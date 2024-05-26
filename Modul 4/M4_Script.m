pos_ref_values = [[58,0]; [0,58]; [-58,0]; [47,29]; [-50,29]];
% pos_ref_values_tugas = [[-25,33]; [33,-25]; [28.58,41.5]; [21.65,20.5]; [4.00,50.23];];
% pos_ref_deg =         [[90,90]; [0,-90]; [30,60]; [90,-120]; [120,-60];];
l1 = 33; l2 = 25;

% --------------- Prompt user for input
prompt = { 
    'NRP:', ...
    'Posisi referensi tugas (5 data berbeda): contoh,', ...
    'Use default model path (1 for yes, 0 for no):', ...
    'Use default folder path (1 for yes, 0 for no):'
};
dlgtitle = 'Input Modul 4 Parameters';
dims = [1 50];
definput = {
    '21', ...            % Default NRP
    '[-25,33]; [33,-25]; [28.58,41.5]; [21.65,20.5]; [4.00,50.23];', ...% Default posisi referensi tugas
    '1', ...             % Default use default model path
    '1' ...              % Default use default folder path
    };

answer = inputdlg(prompt, dlgtitle, dims, definput);
% --------------- End of user input

if isempty(answer)
    error('No input provided. Program terminated.');
end

% create figure
figure_size = [100, 50, 600, 600];
fig         = figure('Position', figure_size);

% ----------- Handle input prompt
% Parse user input
NRP = str2num(answer{1});
pos_ref_values_tugas = str2num(answer{2});
use_default_model_path = str2num(answer{3});
model_path = '';
use_default_folder_path = str2num(answer{4});
folder_path = '';
tugas_folder_path = '';
save_folder  = '';

% If the user chose to use the default model path, set it accordingly
if use_default_model_path
    model_path = 'Modul 4\M4_P1.slx';
else
    % If the user didn't select a model path, prompt them to choose one
    if isempty(model_path)
        [filename, pathname] = uigetfile('*.slx', 'Select the Simulink model Modul 4 file');
        if filename == 0
            error('No file selected. Program terminated.');
        end
        model_path = fullfile(pathname, filename);
    end
end

% If the user chose to use the default folder path, set it accordingly
if use_default_folder_path
    folder_path = 'Modul 4\Grafik\';
    tugas_folder_path = 'Modul 4\Tugas Grafik\';
else
    if isempty(folder_path)
        pathname = uigetdir('Select the folder to save the figures');
        if pathname == 0
            error('No folder selected. Program terminated.');
        end
        save_folder = pathname;
        folder_path = [pathname, '\Grafik\'];
        tugas_folder_path = [pathname, '\Tugas Grafik\'];
    end
end
% ----------- End of handle input prompt

% Motor DC MP parameter
L       = 0.062;                        % Induktansi motor
R       = 2.5;                          % Hambatan motor
Ktn     = 0.026 + (0.001 * NRP);        % Konstanta torsi motor
Kb      = 0.02 + (0.001 * NRP);         % Konstanta tegangan balik emf
J_eff   = 0.00004 + (0.00001 * NRP);    % Momen inersia rotor dan beban
f_eff   = 0.001 + (0.001 * NRP);        % Koefisien viscous rotor dan beban

if isempty(pos_ref_values_tugas)
    % Save and plot end effector pos
    pos_ref_values_tugas = save_and_plot_end_effector_pos(fig, l1, l2, save_folder);
end

% =======================================================================================================================================
% Plot pos_ref_values
for i = 1:5
    inputx = pos_ref_values(i,1);
    inputy = pos_ref_values(i,2);
    simRes = sim(model_path);
    errorXY = simRes.error_xy;
    posactXY = simRes.posact_xy;
    posact = simRes.posact;
    posact_timeseries = simRes.posact_time;
    vel = simRes.vel;
    error_polar = simRes.err;
    plotXY(fig, inputx, inputy, errorXY, posactXY, posact, l1, l2, folder_path);
    plot_and_save(fig, 'Respon Aktual Posisi Polar RTDS', {'ref θ1','ref θ2','act θ1','act θ2'}, posact_timeseries, 'Posisi (rad)', folder_path, inputx, inputy, 'posact', 'northeast');
    plot_and_save(fig, 'Respon Kecepatan RTDS', {'v1','v2'}, vel, 'Kecepatan (rad/s)', folder_path, inputx, inputy, 'vel', 'northeast');
    plot_and_save(fig, 'Respon Error Polar RTDS', {'e1','e2'}, error_polar, 'Error (rad)', folder_path, inputx, inputy, 'error', 'northeast');
    if license('test', 'image_toolbox')
        combine_images(inputx, inputy, folder_path);
    else
        disp('Image Processing Toolbox is not available.');
    end
end

% Plot pos_ref_values_tugas
for i = 1:5
    inputx = pos_ref_values_tugas(i,1);
    inputy = pos_ref_values_tugas(i,2);
    simRes = sim(model_path);
    errorXY = simRes.error_xy;
    posactXY = simRes.posact_xy;
    posact = simRes.posact;
    posact_timeseries = simRes.posact_time;
    vel = simRes.vel;
    error_polar = simRes.err;
    plotXY(fig, inputx, inputy, errorXY, posactXY, posact, l1, l2, tugas_folder_path);
    plot_and_save(fig, 'Respon Aktual Posisi Polar RTDS', {'ref θ1','ref θ2','act θ1','act θ2'}, posact_timeseries, 'Posisi (rad)', tugas_folder_path, inputx, inputy, 'posact', 'northeast');
    plot_and_save(fig, 'Respon Kecepatan RTDS', {'v1','v2'}, vel, 'Kecepatan (rad/s)', tugas_folder_path, inputx, inputy, 'vel', 'northeast');
    plot_and_save(fig, 'Respon Error Polar RTDS', {'e1','e2'}, error_polar, 'Error (rad)', tugas_folder_path, inputx, inputy, 'error', 'northeast');
    if license('test', 'image_toolbox')
        combine_images(inputx, inputy, tugas_folder_path);
    else
        disp('Image Processing Toolbox is not available.');
    end
end
close(fig);
% =======================================================================================================================================

% Combine 4 images into 1 image
function combine_images(inputx, inputy, folder_path)
    img1 = imread([folder_path, [sprintf('posactXY_%.2f_%.2f.png', inputx, inputy)]]);
    img2 = imread([folder_path, [sprintf('posact_%.2f_%.2f.png', inputx, inputy)]]);
    img3 = imread([folder_path, [sprintf('vel_%.2f_%.2f.png', inputx, inputy)]]);
    img4 = imread([folder_path, [sprintf('error_%.2f_%.2f.png', inputx, inputy)]]);

    % Define the margins to crop [top, bottom, left, right]
    margins = [40, 40, 50, 65];

    % Crop the images
    img1 = imcrop(img1, [margins(3), margins(1), size(img1, 2)-margins(3)-margins(4), size(img1, 1)-margins(1)-margins(2)]);
    img2 = imcrop(img2, [margins(3), margins(1), size(img2, 2)-margins(3)-margins(4), size(img2, 1)-margins(1)-margins(2)]);
    img3 = imcrop(img3, [margins(3), margins(1), size(img3, 2)-margins(3)-margins(4), size(img3, 1)-margins(1)-margins(2)]);
    img4 = imcrop(img4, [margins(3), margins(1), size(img4, 2)-margins(3)-margins(4), size(img4, 1)-margins(1)-margins(2)]);

    [rows, cols, ~] = size(img1);
    img2 = imresize(img2, [rows cols]);
    img3 = imresize(img3, [rows cols]);
    img4 = imresize(img4, [rows cols]);

    combinedImage = [img1 img2; img3 img4];
    imwrite(combinedImage, [folder_path, [sprintf('result_%.2f_%.2f.png', inputx, inputy)]]);
end

% Plot and save Cartesian data
function plotXY(fig, inputx, inputy, errorXY, posactXY, posact, l1, l2, folder_path)
    plot(posactXY(:,1), posactXY(:,2), 'HandleVisibility', 'off');
    lastposX = posactXY(end,1);
    lastposY = posactXY(end,2);
    title('End Effector Position for L1 and L2');
    max_val = max(max(abs([posactXY])));
    padding = max_val * 0.1;
    hold on;
    xlim([-max_val-padding, max_val+padding]);
    ylim([-max_val-padding, max_val+padding]);
    % plot origin
    plot(0,0, 'bo')
    % plot inputXY
    plot(inputx, inputy, 'ro');
    % text inputXY
    text(0, -10, sprintf('%.2f, %.2f', inputx, inputy), 'Color', 'blue');
    % plot lastposXY
    plot(lastposX, lastposY, 'go');
    % text lastposXY
    text(0, -15, sprintf('%.2f, %.2f', lastposX, lastposY), 'Color', 'black');
    % text errorXY
    text(0, -20, sprintf('%.2f, %.2f', errorXY(end,1), errorXY(end,2)), 'Color', 'red');
    % plot arm 1
    plot([0,l1*sin(posact(end,1))], [0,l1*cos(posact(end,1))], 'b', 'LineWidth', 2);
    % plot arm 2
    plot([l1*sin(posact(end,1)), l1*sin(posact(end,1))+l2*(sin(posact(end,1)+posact(end,2)))], [l1*cos(posact(end,1)), l1*cos(posact(end,1))+l2*(cos(posact(end,1)+posact(end,2)))], 'g', 'LineWidth', 2);

    axis equal;
    hold off;
    grid on;
    
    legend_str = {'Origin', 'Ref', 'Act'};
    legend(legend_str, 'Location', 'northeast');

    if ~exist(folder_path, 'dir')
        mkdir(folder_path);
    end
    % Save the figure
    filename = [folder_path, [sprintf('posactXY_%.2f_%.2f.png', inputx, inputy)]];
    print(fig, filename, '-dpng');
end

% Plot and save data
function plot_and_save(fig, title_str, legend_str, data, ylabel_str, folder_path, inputx, inputy, file_name, legend_pos)
    plot(data);
    title(title_str);
    ylabel(ylabel_str); xlabel('Waktu (s)');
    legend(legend_str, 'Location', legend_pos);
    % save the figure
    if ~exist(folder_path, 'dir')
        mkdir(folder_path);
    end
    filename = [folder_path, file_name, [sprintf('_%.2f_%.2f', inputx, inputy)],'.png'];
    print(fig, filename, '-dpng');
end

function random_posref_tugas =  save_and_plot_end_effector_pos(fig, l1, l2, save_folder)
    pos_ref_values = [0, 30, 45, 60, 90, 120, -30, -45, -60, -90, -120];
    % Initialize pos_car_matrix to store pos_car values for each pos_ref_values pair
    pos_car_matrix = cell(length(pos_ref_values));

    for i = 1:length(pos_ref_values)
        inputT1 = deg2rad(pos_ref_values(i));
        for j = 1:length(pos_ref_values)
            inputT2 = deg2rad(pos_ref_values(j));
            pos_car = [l1*sin(inputT1)+l2*(sin(inputT1+inputT2)), l1*cos(inputT1)+l2*(cos(inputT1+inputT2))];
            pos_car_matrix{i, j} = pos_car;
        end
    end

    % randomly choose 5 data from pos_car_matrix and assigned it to random_posref_tugas
    random_posref_tugas = zeros(5, 2);
    indices = randperm(size(pos_car_matrix, 1) * size(pos_car_matrix, 2), 5);
    for k = 1:5
        [i, j] = ind2sub(size(pos_car_matrix), indices(k));
        random_posref_tugas(k, 1) = pos_car_matrix{i, j}(1);
        random_posref_tugas(k, 2) = pos_car_matrix{i, j}(2);
    end

    % Initialize pos_car_str_cell to store pos_car values as strings
    pos_car_str_cell = cell(size(pos_car_matrix));

    % Iterate through each cell of pos_car_matrix and convert it to a string
    for i = 1:size(pos_car_matrix, 1)
        for j = 1:size(pos_car_matrix, 2)
            pos_car_str_cell{i, j} = sprintf('%.2f,%.2f', pos_car_matrix{i, j}(1), pos_car_matrix{i, j}(2));
        end
    end

    % Save pos_car_str_cell to an Excel file
    filename = [save_folder, '\Range End Effector.xlsx'];
    writecell(pos_car_str_cell, filename);
    % Create a colormap
    colors = jet(length(pos_ref_values));
    % Plot pos_car_matrix
    hold on; % hold on to plot all points on the same figure
    for i = 1:size(pos_car_matrix, 1)
        for j = 1:size(pos_car_matrix, 2)
            % Plot the position of the first arm
            plot([0, l1*sin(deg2rad(pos_ref_values(i)))], [0, l1*cos(deg2rad(pos_ref_values(i)))], 'Color', colors(i, :));
            % Plot the position of the second arm
            plot([l1*sin(deg2rad(pos_ref_values(i))), pos_car_matrix{i, j}(1)], [l1*cos(deg2rad(pos_ref_values(i))), pos_car_matrix{i, j}(2)], 'Color', colors(i, :));
            % Plot the position of the end effector
            plot(pos_car_matrix{i, j}(1), pos_car_matrix{i, j}(2), 'go');
            % Add a label to the arm
            text(l1*sin(deg2rad(pos_ref_values(i)))/2, l1*cos(deg2rad(pos_ref_values(i)))/2, sprintf('%.2f', pos_ref_values(i)), 'Color', colors(i, :));
        end
    end
    title('End Effector Position for L1 and L2');
    xlabel('X Position');
    ylabel('Y Position');
    grid on;
    axis equal;
    hold off; % release the hold on the figure
    % Save the figure
    filename = [save_folder, '\End Effector Position.png'];
    print(fig, filename, '-dpng');
end