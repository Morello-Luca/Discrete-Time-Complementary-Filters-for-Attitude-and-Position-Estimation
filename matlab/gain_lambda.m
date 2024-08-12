%% SEZIONE PER LA SELEZIONE DELLE 'MANOPOLE DI TUNING' DEI GUADAGNI
%% Parametri per il tuning
% commentare/scommentare la riga per il comportamento del bias desiderato
Sigma_w = deg2rad(3)*eye(3);             % std.dev giroscopio
Sigma_b = deg2rad(1e-10)*eye(3);         % std.dev random walk bias (lenta convergenza bias)
% Sigma_b = deg2rad(1e-7)*eye(3);         % std.dev random walk bias (minor variabilità bias)
Theta_lambda = deg2rad(0.8e-2)*eye(3);   % std.dev MPS

%% SEZIONE PER IL CALCOLO DEI GUADAGNI 
% Definizione sistema
Sigma = [Sigma_w,       zeros(3,3);
         zeros(3,3),  Sigma_b];
F = [eye(3), -T*eye(3);
    zeros(3,3),  eye(3)];

G = [-T*eye(3), zeros(3,3);
    zeros(3,3),   eye(3)];

H = [eye(3), zeros(3,3)];

% calcolo soluzione are
P_inf = idare(F', H', G*Sigma*G', Theta_lambda, [], []);

K_inf = F*P_inf*H'/(Theta_lambda+H*P_inf*H');
K1_lambda = K_inf(1:3,:);
K2_lambda = K_inf(4:6,:);

disp(K1_lambda)
disp(K2_lambda)

%% SEZIONE PER IL CALCOLO DEI GUADAGNI OTTENUTI PER SIMULAZIONE
% eseguire il file SIMULINK convergenzak.slx ed utilizzare la seguente sezione per
% importare i guadagni ottenuti nell'ultimo istante di simulazione

% K_inf = F* out.P_lambda_inf(:,:,end)*H'/(Theta_lambda+H* out.P_lambda_inf(:,:,end)*H');
% 
% K1_lambda = K_inf(1:3,:);
% K2_lambda = K_inf(4:6,:);
% 
% disp(K1_lambda)
% disp(K2_lambda)