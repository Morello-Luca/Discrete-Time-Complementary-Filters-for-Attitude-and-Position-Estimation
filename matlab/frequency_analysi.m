%% Inizializzazione delle variabli
% l'analisi è effettuata come da articolo considerando i valori Q(0) e R=I
T = 1/56;
z = tf('z',T);
Q_0 = [0, 0, 1
       0, 1, 0
       1, 0, 0];
Q_0_inv = Q_0^-1;
R_0 = [1, 0, 0
       0, 1, 0
       0, 0, 1];
R_0_inv = R_0^-1;

%% transfer function - Attitude
% transfer function for
%   input: [omega; lambda_MPS]'
%   output: [lambda_hat]

A = [eye(3) - Q_0*K1_lambda*Q_0_inv,       -T*Q_0;
     zeros(3,3) - K2_lambda*Q_0_inv,     eye(3)];
B = [T*Q_0,         Q_0*K1_lambda;
     zeros(3,3),    K2_lambda];
C = [eye(3), zeros(3,3)];

TF_lambda = ss(A,B,C,[],T);

% transfer function for
%   input: [omega]
%   output: [lambda_omega]

A = eye(3);
B = T*Q_0;
C = eye(3);

TF_omega = tf(ss(A,B,C,[],T));

%% transfer function - Position
% transfer function for
%   input: [a; p_GPS]
%   output: [p_hat]

A = [eye(3) - K1_p,       T*R_0;
     -R_0_inv*K2_p,     R_0_inv*R_0];
B = [T^2/2*R_0,         K1_p;
     T*R_0_inv*R_0,    R_0_inv*K2_p];
C = [eye(3), zeros(3,3)];

TF_p = tf(ss(A,B,C,[],T));

% transfer function for
%   input: [a]
%   output: [p_a]

A = [eye(3),     T*eye(3);
     zeros(3,3),  eye(3)];
B = [T^2/2*eye(3);
     T*eye(3)];
C = [eye(3), zeros(3,3)];

TF_pa = tf(ss(A,B,C,[],T));

%% Calcolo di f.d.t. SISO per semplicità di grafici 
%% t.f. lambda_MPS to lambda_hat (yaw_MPS to yaw_hat)
T1_lambda = TF_lambda(1,6);

%% t.f. lambda_omega to lambda_hat (yaw_omega to yaw_hat)
T2_lambda = TF_lambda(1:3,1:3)*TF_omega^-1;
T2_lambda = T2_lambda(1,1);

%% t.f. p_GPS to p_hat  (x_GPS to x_hat)
T1_p = TF_p(1,4);

%% t.f. p_a to p_hat (x_a to x_hat)
T2_p = TF_p(1:3,1:3)*TF_pa^-1;
T2_p = T2_p(1,1);

%% FIGURE
close all
figure(1)
hold on
bodemag(T1_lambda,{1e-1,1e2})
bodemag(T2_lambda,{1e-1,1e2})
bodemag(T1_lambda+T2_lambda,{1e-1,1e2})
grid on
legend('T1(z) = λ_hat(z)/λ_MPS(z)','T2(z) = λ_hat(z)/ λ_ω(z)','T1(z)+T2(z)')


figure(2)
hold on
bodemag(T1_p,{1e-1,1e2})
bodemag(T2_p,{1e-1,1e2})
bodemag(T1_p+T2_p,{1e-1,1e2})
grid on
legend('T1(z) = p_hat(z)/p_GPS(z)','T2(z) = p_hat(z)/ p_a(z)','T1(z)+T2(z)')