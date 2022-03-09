%% Load data
load ex1_data.mat

%% Question 1
sys = ss(A,B,C,D);

% a)
p = pole(sys);

% b) System is not stable because we have positive poles.

% c)
z = tzero(sys);

% d)

% e)


%% Question 2

% a)

% b)

% c)

% d)


%% Question 3

% a)

% b)

% c)

% d)

% e)