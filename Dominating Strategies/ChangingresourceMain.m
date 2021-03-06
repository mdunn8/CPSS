clear all;
%% Solve a non co-op game between 3 players (2 attackers 1 defender)

%% Enter Inputs
% How many cyber nodes?
nc = 4;
% How are the physical nodes connected to cyber nodes?
A = [1 1 1 0 ; 0 1 1 1];
% Player resources. X(1,:) contains first set of resources to be used
xa1 = [3;3;3];     xa2 = [3;3;3];        xd = [6;7;8];
X = [xa1 xa2 xd];
% What is the cost of each physical node to each player when down?(p1[alpha,beta..];p2...)
% A negative sign denotes defender. In this case costd is the only defender
cost1 = [1;.25];      cost2 = [.25;1];     costd = [-.75;-.75];
Cost = [cost1 cost2 costd];
% How many cyber nodes must be down for each physical node to be down
V = [1;1];

%% Create cost matrix based on all combinations that could be played between both players vs def

[CA] = resourcecombos(nc,X);

CA1 = {CA{xa1(1)} CA{xa2(1)} CA{xd(1)}};
CA2 = {CA{xa1(2)} CA{xa2(2)} CA{xd(2)}};
CA3 = {CA{xa1(3)} CA{xa2(3)} CA{xd(3)}};

matrix1 = Gamebuild(nc,CA1,A,Cost,V);
matrix2 = Gamebuild(nc,CA2,A,Cost,V);
matrix3 = Gamebuild(nc,CA3,A,Cost,V);

%% Evaluating Game #1 %%

dom_strat_1_xd = dominatingstrategies(matrix1, 'xd');
dom_strat_1_xa1 = dominatingstrategies(matrix1, 'xa1');
dom_strat_1_xa2 = dominatingstrategies(matrix1, 'xa2');

new_strat_1_xd = reduced_matrix(dom_strat_1_xd, CA1, 'xd');
new_strat_1_xa1 = reduced_matrix(dom_strat_1_xa1, CA1, 'xa1');
new_strat_1_xa2 = reduced_matrix(dom_strat_1_xa2, CA1, 'xa2');

CA1_new = {new_strat_1_xa1 new_strat_1_xa2 new_strat_1_xd};
matrix1_new = Gamebuild2(nc,CA1_new,A,Cost,V);

len_new_strat_xd_1 = size(new_strat_1_xd);
len_new_strat_xa1_1 = size(new_strat_1_xa1);
len_new_strat_xa2_1 = size(new_strat_1_xa2);

num_of_strat1 = [len_new_strat_xa1_1(1) len_new_strat_xa2_1(1) len_new_strat_xd_1(1)];

[Aa1,payoff1,iterations1,err1] = npg2(num_of_strat1,matrix1_new);

%% Evaluating Game #2 %%

dom_strat_2_xd = dominatingstrategies(matrix2, 'xd');
dom_strat_2_xa1 = dominatingstrategies(matrix2, 'xa1');
dom_strat_2_xa2 = dominatingstrategies(matrix2, 'xa2');

new_strat_2_xd = reduced_matrix(dom_strat_2_xd, CA2, 'xd');
new_strat_2_xa1 = reduced_matrix(dom_strat_2_xa1, CA2, 'xa1');
new_strat_2_xa2 = reduced_matrix(dom_strat_2_xa2, CA2, 'xa2');

CA2_new = {new_strat_2_xa1 new_strat_2_xa2 new_strat_2_xd};
matrix2_new = Gamebuild2(nc,CA2_new,A,Cost,V);

len_new_strat_xd_2 = size(new_strat_2_xd);
len_new_strat_xa1_2 = size(new_strat_2_xa1);
len_new_strat_xa2_2 = size(new_strat_2_xa2);

num_of_strat2 = [len_new_strat_xa1_2(1) len_new_strat_xa2_2(1) len_new_strat_xd_2(1)];


[Aa2,payoff2,iterations2,err2] = npg2(num_of_strat2,matrix2_new);

%% Evaluating Game #3 %%

dom_strat_3_xd = dominatingstrategies(matrix3, 'xd');
dom_strat_3_xa1 = dominatingstrategies(matrix3, 'xa1');
dom_strat_3_xa2 = dominatingstrategies(matrix3, 'xa2');

new_strat_3_xd = reduced_matrix(dom_strat_3_xd, CA3, 'xd');
new_strat_3_xa1 = reduced_matrix(dom_strat_3_xa1, CA3, 'xa1');
new_strat_3_xa2 = reduced_matrix(dom_strat_3_xa2, CA3, 'xa2');

CA3_new = {new_strat_3_xa1 new_strat_3_xa2 new_strat_3_xd};
matrix3_new = Gamebuild2(nc,CA3_new,A,Cost,V);

len_new_strat_xd_3 = size(new_strat_3_xd);
len_new_strat_xa1_3 = size(new_strat_3_xa1);
len_new_strat_xa2_3 = size(new_strat_3_xa2);

num_of_strat3 = [len_new_strat_xa1_3(1) len_new_strat_xa2_3(1) len_new_strat_xd_3(1)];

[Aa3,payoff3,iterations3,err3] = npg2(num_of_strat3,matrix3_new);

% Plot %%
figure;
plot(xd,payoff1,'-+r');
hold on
plot(xd,payoff2,':*g')
plot(xd,payoff3,'-.xk')
% legend('Payoff Player 1','Payoff Player 2','Payoff Defender')
title('Defender resources vs value of game')
xlabel('Defender resources')
ylabel('Value of n-person game')
hold off 
