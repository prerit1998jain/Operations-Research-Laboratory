clc;
clear all;
%---------------Manufacturing Problem-----------%
%-------------- Decision variables----------%
%----- xij = Quantity of products transported from plant i to distribution
%            centre j for i in {1,2,3} and j in {1,2,3,4}

%------------- Objective function -------------%
% Minimize z = (cij*xij) where cij = cost of transporting product from plant i to dc j


%----------------------Constraints----------------

%-------------Supply constraint-------------

%-- x11 + x12 + x13 + x14 <= 5000 (Supply from plant 1)
%-- x21 + x22 + x23 + x24 <= 6000 (Supply from plant 2)
%-- x31 + x32 + x33 + x34 <= 2500 (Supply from plant 3)

%-----------------Demand constraint------------

%-- x11 + x21 + x31 >= 6000 => - x11 - x21 - x31 <= -6000 (Demand at dc 1)
%-- x12 + x22 + x32 >= 4000 => - x12 - x22 - x32 <= -4000 (Demand at dc 2)
%-- x13 + x23 + x33 >= 2000 => - x13 - x23 -x 33 <= -2000 (Demand at dc 3)
%-- x14 + x24 + x34 >= 1500 => - x14 - x24 - x34 <= -1500 (Demand at dc 4)

%------------Non negativity and integer constraint-----------
%--xij>=0 for all i,j and all are integers

%-----------------Additional Either-Or constraint-------------
%--- Let M be a large positive number(say 100000)
%--  x12 <= My1
%--  x22 <= Mz1
%--  y1 + z1 = 1
%--  x23 <= My2
%--  x33 <= Mz2
%--  y2 + z2 = 1

c=[300;200;700;600;700;500;200;300;200;500;400;500;0;0;0;0];

A=[1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0;
    -1,0,0,0,-1,0,0,0,-1,0,0,0,0,0,0,0;
    0,-1,0,0,0,-1,0,0,0,-1,0,0,0,0,0,0;
    0,0,-1,0,0,0,-1,0,0,0,-1,0,0,0,0,0;
    0,0,0,-1,0,0,0,-1,0,0,0,-1,0,0,0,0;
    0,1,0,0,0,0,0,0,0,0,0,0,-100000,0,0,0;
    0,0,0,0,0,1,0,0,0,0,0,0,0,-100000,0,0;
    0,0,0,0,0,0,1,0,0,0,0,0,0,0,-1000000,0;
    0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,-1000000];

Aeq=[0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1];

beq=[1;1];

b=[5000;6000;2500;-6000;-4000;-2000;-1500;0;0;0;0];

intcon=[1:16];

lb=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;];

ub=[10000;10000;10000;10000;10000;10000;10000;10000;10000;10000;10000;10000;1;1;1;1;];

[x,fval]=intlinprog(c,intcon,A,b,Aeq,beq,lb);

for i=1:12
    if (i<=4)
        if (mod(i,4)>0)
            fprintf('Number of products transported from plant 1 to dc %d is:%d\n',mod(i,4),x(i));
        else
            fprintf('Number of products transported from plant 1 to dc 4 is:%d\n',x(i));
        end
    end
    if (i>4 && i<=8)
        if (mod(i,4)>0)
            fprintf('Number of products transported from plant 2 to dc %d is:%d\n',mod(i,4),x(i));
        else
            fprintf('Number of products transported from plant 2 to dc 4 is:%d\n',x(i));
        end
    end
    if (i>8)
        if (mod(i,4)>0)
            fprintf('Number of products transported from plant 3 to dc %d is:%d\n',mod(i,4),x(i));
        else
            fprintf('Number of products transported from plant 3 to dc 4 is:%d\n',x(i));
        end
    end
end

fprintf('The total cost involved is:%d',fval);
