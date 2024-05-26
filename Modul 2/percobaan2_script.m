NRP = 25;   % Ganti NRP mu
pos_ref_values = [5, 10, 100, 1000];
time    = 60;
L       = 0.062;
R       = 2.5;
Ktn     = 0.026 + (0.001 * NRP);
Kb      = 0.02 + (0.001 * NRP);
J_eff   = 0.00004 + (0.00001 * NRP);
f_eff   = 0.001 + (0.001 * NRP);

modelP      = "Modul 2\Percobaan 2\M2_P2_P.slx";
modelPI     = "Modul 2\Percobaan 2\M2_P2_PI.slx";
modelPD     = "Modul 2\Percobaan 2\M2_P2_PD.slx";
modelPID    = "Modul 2\Percobaan 2\M2_P2_PID.slx";
figure_size = [100, 50, 800, 600];
fig         = figure('Position', figure_size);
simRes      = cell(1, length(pos_ref_values));

% Proportional
load_system(modelP);
for i = 1:length(pos_ref_values)
    Pos_ref = pos_ref_values(i);
    simRes{i} = sim(modelP);
    err_vel = simRes{i}.err_vel;
    vel     = simRes{i}.vel;
    err_pos = simRes{i}.err_pos;
    Pos     = simRes{i}.Pos;
    
    plot(err_vel);
    title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler P');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'P1:2 & P2:2','P1:1 & P2:1'},'location','northeast');
    filename = ['Modul 2\Percobaan 2\p\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler P');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'Kecepatan Referensi','P1:2 & P2:2','P1:1 & P2:1'},'location','northeast');
    filename = ['Modul 2\Percobaan 2\p\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler P');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'P1:2 & P2:2','P1:1 & P2:1'},'location','northeast');
    filename = ['Modul 2\Percobaan 2\p\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(Pos);
    title('Respon Posisi pada multi stage kontroler menggunakan kontroler P');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Posisi Referensi','P1:2 & P2:2','P1:1 & P2:1'},'location','southeast');
    filename = ['Modul 2\Percobaan 2\p\P2 Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
end

% Proportional Integral
load_system(modelPI);
for i = 1:length(pos_ref_values)
    Pos_ref = pos_ref_values(i);
    simRes{i} = sim(modelPI);
    err_vel = simRes{i}.err_vel;
    vel     = simRes{i}.vel;
    err_pos = simRes{i}.err_pos;
    Pos     = simRes{i}.Pos;
    
    plot(err_vel);
    title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler PI');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({['P1:20, I1:0.05' newline 'P2:0.1, I2:1'],['P1:10, I1:0.05' newline 'P2:0.1, I2:1']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pi\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler PI');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({['P1:20, I1:0.05' newline 'P2:0.1, I2:1'],['P1:10, I1:0.05' newline 'P2:0.1, I2:1']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pi\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler PI');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({['P1:20, I1:0.05' newline 'P2:0.1, I2:1'],['P1:10, I1:0.05' newline 'P2:0.1, I2:1']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pi\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(Pos);
    title('Respon Posisi pada multi stage kontroler menggunakan kontroler PI');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Posisi Referensi',['P1:20, I1:0.05' newline 'P2:0.1, I2:1'],['P1:10, I1:0.05' newline 'P2:0.1, I2:1']},'location','southeast');
    filename = ['Modul 2\Percobaan 2\pi\P2 Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
end

% Proportional Derivative
load_system(modelPD);
for i = 1:length(pos_ref_values)
    Pos_ref = pos_ref_values(i);
    simRes{i} = sim(modelPD);
    err_vel = simRes{i}.err_vel;
    vel     = simRes{i}.vel;
    err_pos = simRes{i}.err_pos;
    Pos     = simRes{i}.Pos;
    
    plot(err_vel);
    title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler PD');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({['P1:20, D1:0.5' newline 'P2:1, D2:0.5'],['P1:20, D1:5' newline 'P2:1, D2:2']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pd\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler PD');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({['P1:20, D1:0.5' newline 'P2:1, D2:0.5'],['P1:20, D1:5' newline 'P2:1, D2:2']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pd\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler PD');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({['P1:20, D1:0.5' newline 'P2:1, D2:0.5'],['P1:20, D1:5' newline 'P2:1, D2:2']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pd\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(Pos);
    title('Respon Posisi pada multi stage kontroler menggunakan kontroler PD');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Posisi Referensi',['P1:20, D1:0.5' newline 'P2:1, D2:0.5'],['P1:20, D1:5' newline 'P2:1, D2:2']},'location','southeast');
    filename = ['Modul 2\Percobaan 2\pd\P2 Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
end

% Proportional Integral Derivative
load_system(modelPID);
for i = 1:length(pos_ref_values)
    Pos_ref = pos_ref_values(i);
    simRes{i} = sim(modelPID);
    err_vel = simRes{i}.err_vel;
    vel     = simRes{i}.vel;
    err_pos = simRes{i}.err_pos;
    Pos     = simRes{i}.Pos;
    
    plot(err_vel);
    title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler PID');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({['P:2 I:0.5 D:3' newline 'P:2 I:0.1 D:0.5'],['P:5 I:0.5 D:0.1' newline 'P:2 I:0.5 D:0.3']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pid\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler PID');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({['P:2 I:0.5 D:3' newline 'P:2 I:0.1 D:0.5'],['P:5 I:0.5 D:0.1' newline 'P:2 I:0.5 D:0.3']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pid\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler PID');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({['P:2 I:0.5 D:3' newline 'P:2 I:0.1 D:0.5'],['P:5 I:0.5 D:0.1' newline 'P:2 I:0.5 D:0.3']},'location','northeast');
    filename = ['Modul 2\Percobaan 2\pid\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(Pos);
    title('Respon Posisi pada multi stage kontroler menggunakan kontroler PID');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Posisi Referensi',['P:2 I:0.5 D:3' newline 'P:2 I:0.1 D:0.5'],['P:5 I:0.5 D:0.1' newline 'P:2 I:0.5 D:0.3']},'location','southeast');
    filename = ['Modul 2\Percobaan 2\pid\P2 Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
end
close(fig);