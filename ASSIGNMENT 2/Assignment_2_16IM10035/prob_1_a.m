clc;
clear all;
%-----------Decision variables-----------%
% xij = no. of units of product transported from plant i to warehouse j; 
% xij >= 0; i = {1,2,3} & j = {1,2,3,4}
% yij = no. of units of product transferred from warehouse i to demand point j; 
% yij >= 0; i = {1,2,3}; j = {1,2,3,4}

%%----------Objective function-------------%%
% Minimize cost Z = 5000x11 + 3000x12 + ....6200x33 + 6000y11 + 4500y12
% +.......8000y34

%-----------Constraints-------------%%

%-----Demand Constraints-------%
% y11 + y21 + y31 >= 50
% y12 + y22 + y32 >= 130
% y13 + y23 + y33 >= 75
% y14 + y24 + y34 >= 90

%-----Warehouse Constraints--------%
% y11 + y12 + y13 + y14 <= x11 + x21 + x31
% y21 + y22 + y23 + y24 <= x12 + x22 + x32
% y31 + y32 + y33 + y34 <= x13 + x23 + x33

c = [5000;3000;6500;6000;3200;2500;5500;2300;6200;6000;4500;5000;4000;5500;3200;2500;4700;5500;2300;6200;8000];

intcon = [1:21];

A = [0,0,0,0,0,0,0,0,0,-1,0,0,0,-1,0,0,0,-1,0,0,0;
    0,0,0,0,0,0,0,0,0,0,-1,0,0,0,-1,0,0,0,-1,0,0;
    0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,-1,0,0,0,-1,0;
    0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,-1,0,0,0,-1;
    -1,0,0,-1,0,0,-1,0,0,1,1,1,1,0,0,0,0,0,0,0,0;
    0,-1,0,0,-1,0,0,-1,0,0,0,0,0,1,1,1,1,0,0,0,0;
    0,0,-1,0,0,-1,0,0,-1,0,0,0,0,0,0,0,0,1,1,1,1];

b = [-50;-130;-75;-90;0;0;0];
lb = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb);

fprintf('Optimum cost of transportation is Rs %f \n',fval);

fprintf('The respective amounts transported  :\n');
for k = 1:21
    fprintf('%f\n',x(k));
end    