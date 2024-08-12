% % clear

%% SEZIONE PER LA SELEZIONE DELLA TRAIETTORIA DESIDERATA
%% Selezione traiettoria
% commentare/scommentare la riga con la traiettoria desiderata
% TRAIETTORIA = 1;       % TRAIETTORIA CIRCOLARE
TRAIETTORIA = 2;       % TRAIETTORIA RETTILINEA
%% Selezione outage GPS
EN_OUTAGE = true;      % abilita outage GPS
% EN_OUTAGE = false;    % disabilita outage GPS

interval1 = [100; 140];     % intervallo numero 1
interval2 = [280; 320];     % intervallo numero 2


%% SEZIONE PER L'INIZZIALIZZAZIONE DEL SISTEMA
%% Inizializzazione stato nominale
lambda0= [0;0;0];
p0 = [0;0;0];
v0 = [0;0;0];

%% Gyroscope
gyro_sigmax = deg2rad(0.18);
gyro_sigmay = deg2rad(0.18);
gyro_sigmaz = deg2rad(0.18);

gyro_biasx = deg2rad(.05);
gyro_biasy = 2*deg2rad(.05);
gyro_biasz = 3*deg2rad(.05);

gyro_bias_sigmax = 1e-10 ;
gyro_bias_sigmay = 1e-10 ;
gyro_bias_sigmaz = 1e-10 ;


T = 1/56;

T_gps = 1/4;
T_mag = 1/8;

%% IMU
m = [270; 100; 0]; 
mag_sigmax = 1 ;
mag_sigmay = 1 ;
mag_sigmaz = 1 ;

g = [0; 0; 9.81]; 
acc_sigmax = 2.6e-3 ;
acc_sigmay = 2.6e-3 ;
acc_sigmaz = 2.6e-3 ;

%% GPS
gps_sigmax = 3 ;
gps_sigmay = 3 ;
gps_sigmaz = 3 ;

%% Inizializzazione stato stimato
% per valutare le prestazioni usare i seguenti errori di bias
% bias_eps_x = .0003*deg2rad(.2); % errore di bias
% bias_eps_y = .0003*deg2rad(.2); % errore di bias
% bias_eps_z = .0003*deg2rad(.2); % errore di bias
% per valutare le prestazioni di convergenza degli errori di bias
bias_eps_x = 3*deg2rad(.2); % errore di bias
bias_eps_y = 3*deg2rad(.2); % errore di bias
bias_eps_z = 3*deg2rad(.2); % errore di bias

lambda_hat_0= [0;0;0];
bias_hat_0  = [gyro_biasx + bias_eps_x; gyro_biasy + bias_eps_y; gyro_biasz + bias_eps_z];
P_lambda_0= deg2rad(5)*eye(3);


p_hat_0= [0;0;0];
v_B_hat_0  = [0; 0; 0];

%% filter gain
% Eseguire il file gain_lambda.m per caricare guadagni ottenuti come
% soluzione della ARE
gain_lambda
%
%               oppure
%
% Per usare i guadagni proposti dall'articolo scommentare le seguenti righe 

% K1_lambda = 2.97e-1*eye(3);     
% K2_lambda = -9.41e-5*eye(3);

% Eseguire il file gain_p.m per caricare guadagni ottenuti come
% soluzione della ARE/simulazione
gain_lambda
%
%               oppure
%
% Per usare i guadagni proposti dall'articolo scommentare le seguenti righe 

K1_p = 0.59*eye(3);
K2_p = 0.14*eye(3);