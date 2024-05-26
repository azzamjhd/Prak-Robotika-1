# MULTI STAGE CONTROLLER

## PID

### Respon error kecepatan

```Matlab
plot(out.err_vel);
title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler PID');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');
```

### Respon kecepatan

```Matlab
plot(out.vel);
title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler PID');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');
```

### Respon error posisi

```Matlab
plot(out.err_pos);
title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler PID');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');
```

### Respon posisi

```Matlab
plot(out.Pos);
title('Respon Posisi pada multi stage kontroler menggunakan kontroler PID');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','southeast');
```

## PD

### Respon error kecepatan


```Matlab
plot(out.err_vel);
title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler PD');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P = 1, D = 0.005','P = 1, D = 0.01','P = 2, D = 0.05'},'location','northeast');
```

### Respon kecepatan

```Matlab
plot(out.vel);
title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler PD');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','northeast');
```

### Respon error posisi

```Matlab
plot(out.err_pos);
title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler PD');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','northeast');
```

### Respon posisi

```Matlab
plot(out.Pos);
title('Respon Posisi pada multi stage kontroler menggunakan kontroler PD');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','southeast');
```

## PI
### Respon error kecepatan
```
plot(out.err_vel);
title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler PI');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');
```
### Respon kecepatan
```
plot(out.vel);
title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler PI');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');
```
### Respon error posisi
```
plot(out.err_pos);
title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler PI');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');
```
### Respon posisi
```
plot(out.Pos);
title('Respon Posisi pada multi stage kontroler menggunakan kontroler PI');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','southeast');
```

## P
#### Respon error kecepatan
```
plot(out.err_vel);
title('Respon Error Kecepatan pada multi stage kontroler menggunakan kontroler P');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P1:2 & P2:2','P1:1 & P2:1'},'location','northeast');
```
### Respon kecepatan
```
plot(out.vel);
title('Respon Kecepatan pada multi stage kontroler menggunakan kontroler P');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Kecepatan Referensi','P1:2 & P2:2','P1:1 & P2:1'},'location','northeast');
```
### Respon error posisi
```
plot(out.err_pos);
title('Respon Error Posisi pada multi stage kontroler menggunakan kontroler P');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P1:2 & P2:2','P1:1 & P2:1'},'location','northeast');
```
### Respon posisi
```
plot(out.Pos);
title('Respon Posisi pada multi stage kontroler menggunakan kontroler P');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Posisi Referensi','P1:2 & P2:2','P1:1 & P2:1'},'location','southeast');
```


# SINGLE STAGE CONTROLLER

-------  PID

plot(out.err_vel);
title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler PID');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');

plot(out.vel);
title('Respon Kecepatan pada single stage kontroler menggunakan kontroler PID');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');

plot(out.err_pos);
title('Respon Error Posisi pada single stage kontroler menggunakan kontroler PID');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','northeast');

plot(out.Pos);
title('Respon Posisi pada single stage kontroler menggunakan kontroler PID');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3, D:0.05','P:1, I:0.5, D:0.07','P:1, I:0.8, D:0.09'},'location','southeast');


-------- PD

plot(out.err_vel);
title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler PD');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P = 1, D = 0.005','P = 1, D = 0.01','P = 2, D = 0.05'},'location','northeast');

plot(out.vel);
title('Respon Kecepatan pada single stage kontroler menggunakan kontroler PD');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','northeast');

plot(out.err_pos);
title('Respon Error Posisi pada single stage kontroler menggunakan kontroler PD');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','northeast');

plot(out.Pos);
title('Respon Posisi pada single stage kontroler menggunakan kontroler PD');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P = 1, D = 0.005','P = 1, D = 0.01','P = 1, D = 0.05'},'location','southeast');


-------- PI

plot(out.err_vel);
title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler PI');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');

plot(out.vel);
title('Respon Kecepatan pada single stage kontroler menggunakan kontroler PI');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');

plot(out.err_pos);
title('Respon Error Posisi pada single stage kontroler menggunakan kontroler PI');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','northeast');

plot(out.Pos);
title('Respon Posisi pada single stage kontroler menggunakan kontroler PI');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P:1, I:0.3','P:1, I:0.6','P:1, I:0.9'},'location','southeast');


-------- P

plot(out.err_vel);
title('Respon Error Kecepatan pada single stage kontroler menggunakan kontroler P');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'P:1','P:4','P:7'},'location','northeast');

plot(out.vel);
title('Respon Kecepatan pada single stage kontroler menggunakan kontroler P');
ylabel('Kecepatan (𝝅 rad/s)');xlabel('Waktu (s)');
legend({'Referensi','P:1','P:4','P:7'},'location','northeast');

plot(out.err_pos);
title('Respon Error Posisi pada single stage kontroler menggunakan kontroler P');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'P:1','P:4','P:7'},'location','northeast');

plot(out.Pos);
title('Respon Posisi pada single stage kontroler menggunakan kontroler P');
ylabel('Posisi (𝝅 rad)');xlabel('Waktu (s)');
legend({'Referensi','P:1','P:4','P:7'},'location','southeast');