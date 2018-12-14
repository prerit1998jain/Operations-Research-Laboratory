
%-------------------- Rent problem -------------%
%---------- Decision variables --------%

%-- xij = size of land taken into rent for j months in ith month .

%------------- Objective function -------------%
% ---  Minimize z = ( 28000x11 + 45000x12 + 60000x13 + 28000x21 + 45000x22 + 28000x31)

%------------ Constraints---------------%

%----------Space constraint------------%

%--- x11 + x12 + x13 >= 25 => -x11 - x12 - x13 <= -25           ( Month 1)
%--- x12 + x13 + x21 + x22 >= 10 => -x12 -x13 -x21 -x23 <= -10  ( Month 2)
%--- x13 + x22 + x31 >= 20 => - x13 - x22 - x31 <= -20          ( Month 3)

%------------Non-negativity and integer constraint------------%

%--  All variables are integers and are greater than equal to 0

c=[28000;45000;60000;28000;45000;28000];

A=[-1,-1,-1,0,0,0;
    0,-1,-1,-1,-1,0;
    0,0,-1,0,-1,-1];

b=[-25;-10;-20];

intcon=[1:6];

lb=[0;0;0;0;0;0;];

[x,fval]=intlinprog(c,intcon,A,b,[],[],lb);

fprintf('The total money to be spent is :%d\n',fval);
fprintf('The amount of land(in 1000m^3) to be rented in first month for 1 month is:%d\n',x(1));
fprintf('The amount of land(in 1000m^3) to be rented in first month  for 2 months is:%d\n',x(2));
fprintf('The amount of land(in 1000m^3) to be rented in first month  for 3 months is:%d\n',x(3));
fprintf('The amount of land(in 1000m^3) to be rented in second month  for 1 month is:%d\n',x(4));
fprintf('The amount of land(in 1000m^3) to be rented in second month  for 2 months is:%d\n',x(5));
fprintf('The amount of land(in 1000m^3) to be rented in third month  for 1 month is:%d\n',x(6));
