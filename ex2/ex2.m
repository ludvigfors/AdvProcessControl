%% load data
load ex2_data.mat
G = rand(2,5);
%% First set of poles
eig1 = [ -3 1; -1 -3];
eig2 = [-3 -1; 1 -3];
eig3 = -1;
Lambda = blkdiag(eig1,eig2,eig3);

X = lyap(A,-Lambda,-B2*G);

K1 = G/X;

sys1 = ss(A-B2*K1,B2,C2,zeros(2,2));
pole(sys1)
% The choice of G has a strong influence on how close the poles of
% the system are to the desired poles. In general they are fairly close


%% Second set of poles
eig1 = [ -10 2.5; -2.5 -10];
eig2 = [-10 -2.5; 2.5 -10];
eig3 = -12.1;
Lambda = blkdiag(eig1,eig2,eig3);

X = lyap(A,-Lambda,-B2*G);

K2 = G/X;

sys2 = ss(A-B2*K2,B2,C2,zeros(2,2));
pole(sys2)

%% exercise 2
Q = C1'*C1*10;
R = D1'*D1*10;
P = are(A,B2*inv(R)*B2',Q);
K = inv(R)*B2'*P;
sys = ss(A-B2*K,B2,C2,zeros(2,2));
pole(sys)

[K_lqr,n,m] = lqr(A,B2,Q,R);

