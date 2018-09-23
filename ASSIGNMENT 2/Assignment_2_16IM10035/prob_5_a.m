clc;
clear all;
%---------------Decision variables-----------%
% x1,x2,x3,x4,x5,x6 = 1 if item a is selected
%                     0 if not selected

%----------Objective funtion-------------%
% Maximize Z = 60x1 + 70x2 + 40x3 + 70x4 + 16x5 + 100x6

%----------Constaints---------------%
% 6x1 + 7x2 + 4x3 + 9x4 + 3x5 + 8x6 <= 20

c = [-60,-70,-40,-70,-16,-100];

intcon = [1:6];

A = [6,7,4,9,3,8];
b = [20];

lb = [0,0,0,0,0,0];
ub = [1,1,1,1,1,1];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb,ub);
fprintf('The maximum value possible is $ %d\n',-fval);
fprintf('Following items are selected:\n')
for i = 1:6
    if x(i)>0
        fprintf('Item %d\n',i);
    end
end    