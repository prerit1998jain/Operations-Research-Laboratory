clc;
clear all;

%---------Decision variables-----------%
% xi = 1 if ith lifeguard selected
%      0 if not selected
% i = {1,2,3,4,5,6,7}

%----------Objective function-----------%
% Minimize cost Z = 300x1 + 180x2 + 210x3 + 380x4 + 200x5 + 220x6 + 900x7

%----------Constraints------------------%
% x1 + x2 >= 1                  1-3    (Redundant Constraint)
% x1 >= 1                       3-4
% x1 + x3 + x4 >= 1             4-5
% x3 + x4 + x6 >= 1             5-6
% x3 + x4 + x5 + x6 >= 1        6-7    (Redundent Constraint)
% x4 + x5 + x6 >= 1             7-8
% x4 + x5 + x7 >= 1             8-9

c = [300,180,210,380,200,220,900];

intcon = [1:7];

A = [
    -1,0,0,0,0,0,0;
    -1,0,-1,-1,0,0,0;
    0,0,-1,-1,0,-1,0;
    0,0,0,-1,-1,-1,0;
    0,0,0,-1,-1,0,-1];
b = [-1;-1;-1;-1;-1];

lb = [0;0;0;0;0;0;0];
ub = [1;1;1;1;1;1;1];

[x, fval] = intlinprog(c,intcon,A,b,[],[],lb,ub);
fprintf('The least cost is Rs %d\n',fval);
fprintf('Selected lifguards:\n');
for i = 1:7
    if x(i)==1
        fprintf('%d\n',i);
    end
end    