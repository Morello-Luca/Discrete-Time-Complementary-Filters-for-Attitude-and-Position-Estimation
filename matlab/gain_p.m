%% SEZIONE PER LA SELEZIONE DELLE 'MANOPOLE DI TUNING' DEI GUADAGNI
%% Parametri per il tuning
Sigma_p = 5e-2*eye(3);  % std.dev position (piccoli disturbi o altro)
Sigma_a = 10*eye(3);    % std.dev accelerometro
Theta_p = 1*eye(3);     % std.dev GPS


%% SEZIONE PER IL CALCOLO DEI GUADAGNI 

% Definizione sistema
Sigma = [Sigma_p,       zeros(3,3);
         zeros(3,3),  Sigma_a];

F = [eye(3), T*eye(3);
    zeros(3,3),  eye(3)];

G = [eye(3), -T^2/2*eye(3);
    zeros(3,3),   -T*eye(3)];

H = [eye(3), zeros(3,3)];

% calcolo
P_inf = idare(F', H', G*Sigma*G', Theta_p, [], []);

K_inf = F*P_inf*H'/(Theta_p+H*P_inf*H');
K1_p = K_inf(1:3,:);
K2_p = K_inf(4:6,:);

disp(K1_p)
disp(K2_p)

%% Definizione sistema espanso
T_gps=14*T;
n_t = T_gps/T;

Sigma_p_nt = zeros(3*n_t,3*n_t);        % std.dev position
Sigma_a_nt = zeros(3*n_t,3*n_t);        % std.dev accelerometro
for i = 0:n_t-1
    Sigma_p_nt(i*3+1:(i+1)*3 , i*3+1:(i+1)*3 ) = Sigma_p;
    Sigma_a_nt(i*3+1:(i+1)*3 , i*3+1:(i+1)*3 ) = Sigma_a;
end
Theta_p_nt = Theta_p;                   % std.dev GPS

Sigma_nt = [Sigma_p_nt,       zeros(3*n_t,3*n_t);
         zeros(3*n_t,3*n_t),  Sigma_a_nt];

% Propago in avanti le nt volte prima di una nuova misura
F_nt = F^n_t;               
% Considero gli nt ingressi prima di nua nuova misura
G_nt = zeros(6,6*n_t);
for i = 0:n_t-1
    G_nt(:,i*6+1 : (i+1)*6 ) = F^(n_t-i-1)*G;
end
% L'uscita è la posizione ogni nt passi
H_nt = H;


% calcolo (extended sys)
P_inf = idare(F_nt', H_nt', G_nt*Sigma_nt*G_nt', Theta_p_nt, [], []);

K_inf = F_nt*P_inf*H_nt'/(Theta_p_nt+H_nt*P_inf*H_nt');

K1_p = K_inf(1:3,:);
K2_p = K_inf(4:6,:);


disp(K1_p)
disp(K2_p)


%% SEZIONE PER IL CALCOLO DEI GUADAGNI OTTENUTI PER SIMULAZIONE
% eseguire il file SIMULINK convergenzak.slx ed utilizzare la seguente sezione per
% importare i guadagni ottenuti nell'ultimo istante di simulazione

K_inf = F_nt* out.P_p_inf(:,:,end)*H_nt'/(Theta_p_nt+H_nt* out.P_p_inf(:,:,end)*H_nt');

K1_p = K_inf(1:3,:);
K2_p = K_inf(4:6,:);

disp(K1_p)
disp(K2_p)
