%% Load data
load ex1_data.mat

%% Question 1
sys = ss(A,B,C,D);

%% a)
poles = pole(sys);


% b) System is not stable because we have positive poles.

% c)
[Z, NRK] = tzero(sys);

% d)
X1 = [A B;C D];

X2 = [eye(7), zeros(7,3); 
      zeros(3, 7) zeros(3,3)];

[eigVec, eigVal] = eig(X1, X2);

% Verification
v1 = eigVec(:,1); % Initital state
M1 = [eye(7), zeros(7,3); 
      zeros(3, 7) zeros(3,3)];
M2 = [-A -B;C D];
% eigVal(1) is the transmission zero
M = eigVal(1)*M1 + M2;

y = M*v1; % y is zero so correct

%% e)
% Some zeros are the same as in a) and c)

[sys_num, sys_den] = ss2tf(A,B,C,D, 3);
sys_first_out = sys_num(1,:);

sys_G11 = tf(sys_first_out, sys_den);
sys_11_poles = pole(sys_G11);
sys_11_zeros = zero(sys_G11);


%G = tf(sys);
%G11_org = G(1,1);

%poles11_org = pole(G11_org);
%zeros11_org = zero(G11_org);





%% Question 2

%% a)
% Controlability matrix test -> Not controllable because rank(C_M) != n
C_M = [B A*B A^2*B A^3*B A^4*B A^5*B A^6*B];
r1 = rank(C_M);

% PBH test -> Not Controlable since some left eigenvectors of A are orthogonal to B.
%[U1,S1,VT] = svd(A);
[U2, S2] = eig(A');
t2 = B' * U2;


%% b)
% Controlability matrix test -> Non observable since rank(O_M) != n
O_M = [C; C*A; C*A^2; C*A^3; C*A^4; C*A^5; C*A^6];
r2 = rank(O_M);

% PBH test -> Not observabe since some right eigenvectors of A are orthogonal to C.
%[U1,S1,VT] = svd(A);
[U3, S3] = eig(A);
t3 = C * U3;

%% c)
% Controlable
s11 = diag(S2);
modes_contr = s11([1:3,5,7]);

% Observable
s22 = diag(S3);
modes_obs = s22([1:3,5:6]);

% Stablizable
% Not stabilizable because we cant control the pole (0.6731 + 0.0000i)

% Detectability
% Not detectable because we cant observe the pole (0.1251 + 0.0000i)

% d)
% The new system only includes poles that are both controlable and observable.
min_sys = minreal(sys);
min_poles = pole(min_sys);


%% Question 3
a = 1;
NUM = [ 0 1 a];
DEN = [1 7 12];
%sys_tf = tf(NUM, DEN);
sys_tf = tf(NUM, DEN);
sys = ss(sys_tf);
% a)
sys_con = canon(sys);
sys_obs = canon(sys, "companion");

% PBH test -> Not Controlable since some left eigenvectors of A are orthogonal to B.
%[U1,S1,VT] = svd(A);
[U2, S2] = eig(sys_con.A);

A = sys_con.A;
B = sys_con.B;
C = sys_con.C;

C_M = [B A*B];
r1 = rank(C_M);

tcon = sys_con.B' * U2;

% Controlability matrix test -> Non observable since rank(O_M) != n
O_M = [C; C*A];
r2 = rank(O_M);




% b)

% c)

% d)

% e) 