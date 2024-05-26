NRP = 25;   % Ganti NRP mu
pos_ref_values = [5, 10, 100, 1000];
time    = 60;
L       = 0.062;
R       = 2.5;
Ktn     = 0.026 + (0.001 * NRP);
Kb      = 0.02 + (0.001 * NRP);
J_eff   = 0.00004 + (0.00001 * NRP);
f_eff   = 0.001 + (0.001 * NRP);

modelP      = "Modul 2\Percobaan 1\M2_P1_P.slx";
modelPI     = "Modul 2\Percobaan 1\M2_P1_PI.slx";
modelPD     = "Modul 2\Percobaan 1\M2_P1_PD.slx";
modelPID    = "Modul 2\Percobaan 1\M2_P1_PID.slx";
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
    
    plot(Pos);
    title('Respon Posisi pada single stage kontroler menggunakan kontroler P');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Referensi','P:1','P:4','P:7'},'location','southeast');
    filename = ['Modul 2\Percobaan 1\p\P2 Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada single stage kontroler menggunakan kontroler P');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'P:1','P:4','P:7'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\p\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada single stage kontroler menggunakan kontroler P');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'Referensi','P:1','P:4','P:7'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\p\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_vel);
    title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler P');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'P:1','P:4','P:7'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\p\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
end

% Proportional Integral
load_system(modelPI)
for i = 1:length(pos_ref_values)
    Pos_ref = pos_ref_values(i);
    simRes{i} = sim(modelPI);
    err_vel = simRes{i}.err_vel;
    vel     = simRes{i}.vel;
    err_pos = simRes{i}.err_pos;
    Pos     = simRes{i}.Pos;

    plot(err_vel);
    title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler PI');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pi\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada single stage kontroler menggunakan kontroler PI');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'Referensi','P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pi\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada single stage kontroler menggunakan kontroler PI');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pi\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(Pos);
    title('Respon Posisi pada single stage kontroler menggunakan kontroler PI');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Referensi','P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','southeast');
    filename = ['Modul 2\Percobaan 1\pi\P2 Pos ', num2str(Pos_ref), '.png'];
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
    title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler PD');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'P = 1, D = 0.005','P = 1, D = 0.01','P = 2, D = 0.05'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pd\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada single stage kontroler menggunakan kontroler PD');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'Referensi','P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pd\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada single stage kontroler menggunakan kontroler PD');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pd\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
    
    plot(Pos);
    title('Respon Posisi pada single stage kontroler menggunakan kontroler PD');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Referensi','P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','southeast');
    filename = ['Modul 2\Percobaan 1\pd\P2 Pos ', num2str(Pos_ref), '.png'];
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
    title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler PID');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pid\P2 Err Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(vel);
    title('Respon Kecepatan pada single stage kontroler menggunakan kontroler PID');
    ylabel('Kecepatan (rad/s)');xlabel('Waktu (s)');
    legend({'Referensi','P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pid\P2 Vel ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(err_pos);
    title('Respon Error Posisi pada single stage kontroler menggunakan kontroler PID');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');
    filename = ['Modul 2\Percobaan 1\pid\P2 Err Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');

    plot(Pos);
    title('Respon Posisi pada single stage kontroler menggunakan kontroler PID');
    ylabel('Posisi (rad)');xlabel('Waktu (s)');
    legend({'Referensi','P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','southeast');
    filename = ['Modul 2\Percobaan 1\pid\P2 Pos ', num2str(Pos_ref), '.png'];
    print(fig,filename,'-dpng');
end
close(fig);