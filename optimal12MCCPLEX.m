function opt = optimalMC1 (inp)
clear
addpath('C:\IBM\ILOG\CPLEX_Studio125\cplex\matlab\x64_win64')
tStart = tic;   

col_cells=30; %cells
row_species=5;  %species

budget=zeros(1,1)

budget(1,1)= -1;

B= randi ([0 1],row_species,col_cells);
A= -1*B;


d = ones(row_species,1);

b=-1*d;

y = -1*eye(row_species);

cost= -1*(ones(1,col_cells));

lastzeros = zeros (1,row_species);

lastrow = horzcat (cost,lastzeros);

W=horzcat(B,y);

A=vertcat(W,lastrow);

-y

f=zeros(col_cells,1);
 
g=ones(row_species,1);

f

g

bounds=zeros(row_species,1)



e=vertcat(f,g);
cost;
A
e
f=-1*e; % maximization
bounds

budget

finalbounds=vertcat(bounds,budget)

negativeA=-1*A;
negativeFinalbounds=-1*finalbounds

[x,fval,exitflag,output] = cplexbilp(f,negativeA,negativeFinalbounds)

x
fval

tElapsed = toc(tStart)

