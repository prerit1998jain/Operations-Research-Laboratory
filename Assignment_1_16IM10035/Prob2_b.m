clc;
clear all;
% --- AMUL Milk Factory --------%%%
%---  Decision Variables -------------- %%%
% xi = amount of milk type i , i = 1,2,3,4,5 : xi>=0
% Objective function, z = Max 5x1 + 7.5x2 + 10x3 + 85x4 + 400x5
%% --- Constraints -----%%%%%%%

% --- Fat Constraints ------%%%%
% --- 0x1 + 0.02x2 + 0.04x3 + 0.15x4 + 0.45x5 +y <= (3.7/100)*5000+(4.9/100)*2500
% -------------------------------------------------------------------------------------------
% --- Milk Volume (excluding fat) Constraints  -------%%%%
% --- x1+ 0.98x2 + 0.96x3 + 0.85x4 + 0.55x5 <=(96.3/100)*5000+(95.1/100)*2500
%--------------------------------------------------------------------------------------------
% --- Percentage fat in skimmed milk constraints  -------%%%%
% --- y<=0.001x1
%--------------------------------------------------------------------------------------------

f = [-5;-7.5;-10;-85;-400;0];
   A = [0,0.02,0.04,0.15,0.45,1;
       1,1,1,1,1,0;
       -0.001,0,0,0,0,1;
       ];
   b = [3.7*50+4.9*25;7500;0];
  lb=[0;0;0;0;0;0;];
  
[x,fval] = linprog(f,A,b,[],[],lb);

fprintf (' Total profit is : Rs. %d \n',  -fval);
for i=1:5
    fprintf(' Amount of Milk % d to be produced is : %d \n', i, x(i));
end
fprintf (' Total amount of fat present in skimmed milk is : Rs. %d \n',  x(6));