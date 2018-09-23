clc;
clear all;
%---------------Decision variables-----------%
% x1,x2,x3,x4,x5,x6 = 1 if item a is selected
%                     0 if not selected

%----------Objective funtion-------------%
% Maximize Z = max(Z1,Z2)
% Z1 = 60x1 + 70x2 + 40x3 + 70x4 + 16x5 + 100x6
% Z2 = 60x1 + 70x2 + 40x3 + 70x4 + 16x5 + 100x6 - 15(6x1 + 7x2 + 4x3 + 9x4 + 3x5 + 8x6 - 20)
% => Z2 = -30x1 -35x2 - 20x3 -65x4 - 29x5 - 20x6 + 300

%----------Constaints---------------%
% 6x1+ 7x2 + 4x3 + 9x4 + 3x5 + 8x6 <= 20       - For Z1
% -(6x1+ 7x2+ 4x3 + 9x4 + 3x5 + 8x6) <= -20   - For Z2

c1 = [-60,-70,-40,-70,-16,-100];
c2 = [30,35,20,65,29,20];

intcon = [1:6];

A1 = [6,7,4,9,3,8];
b1 = [20];

A2 = [-6,-7,-4,-9,-3,-8];
b2 = [-20];

lb = [0,0,0,0,0,0];
ub = [1,1,1,1,1,1];

[x1, fval_1] = intlinprog(c1,intcon,A1,b1,[],[],lb,ub);
[x2, fval_2] = intlinprog(c2,intcon,A2,b2,[],[],lb,ub);
fval = max(-fval_1, -fval_2 + 300);
fprintf('The maximum value possible is $ %d\n',fval);
fprintf('Selected items:\n')
if fval == -fval_1
    for i = 1:6
        if x1(i)>0
            fprintf('Item %d\n',i);
        end
    end
elseif fval == -fval_2 + 300
    for i = 1:6
        if x2(i)>0
            fprintf('Item %d\n',i);
        end
    end
end    