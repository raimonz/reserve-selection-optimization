
function y = optimalMSC1 (x)
%#codegen
clear;

addpath('C:\IBM\ILOG\CPLEX_Studio125\cplex\matlab\x64_win64')
% C = csvread ('amphibians2.csv');
% 
% B = C.';


 m=1000; %cells
 n=100; %species

%BUSCAR GAP EN CPLEX!!!!! GAP 1%??? - 5% TESTAR SI CAMBIA MUCHO
 % this is P
B = rand(n,m);

%now calculate q = 1-p

for i = 1 : n
    
    for j = 1 : m
        
        B(i,j)=log (1-B(i,j));
        
    end
end

size (B)

[row_species,col_cells]= size (B);

   

% col_cells=200; %cells
% row_species=20;  %species

%B= randi ([0 1],row_species,col_cells);

Alpha=0.95

A= 1*B;

f=ones(col_cells,1);

d = ones(row_species,1);

for i=1:row_species
d(i)= log(1-Alpha);
end

b=1*d;

tStart = tic;

[x,fval,exitflag,output] = cplexbilp(f,A,b);

tElapsed = toc(tStart)

i=1;
z=0;
x
while i<length(x)
   if x(i)~=0
       i
       x(i)
       z=z+1;
   end
   i=i+1;
end


z

tElapsed

