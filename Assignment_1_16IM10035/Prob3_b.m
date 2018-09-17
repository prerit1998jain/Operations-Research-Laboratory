%Rajat Singh
%16IM30016
%----- CO-Tech Salary Problem -----%
%----- Decision Variables -----%
% ---x1,x2,x3,x4,x5,x6,x7=Salary of A,B,C,D,E,F,G respectively
% Objective Function : z = min(max(x1,x2,x3,x4,x5,x6,x7)) 
% -------------------- z=min x3 (as in previous part x3 was highest) %
%------ Salary Constraints ------%
% ---Constraint 1 : x1>=20000 =>-x1<=-20000 
% ---Constraint 2: x2>=5000+x1 =>x1-x2<=-5000
% ---Constraint 3: x3>=5000+x1 =>x1-x3<=-5000
% ---Constraint 4: x4>=5000+x1 =>x1-x4<=-5000
% ---Constraint 5: x5>=x1+x2 =>x1+x2-x5<=0
% ---Constraint 6: x6-x5=200
% ---Constraint 7: x3+x4>=2(x1+x2) =>2x1+2x2-x3-x4<=0
% ---Constraint 8: x7-x4>=0 =>x4-x7<=0
% ---Constraint 9: x7-x2>=0 =>x2-x7<=0
% ---Constraint 10: x7+x2>=60000 =>-x7-x2<=-60000
% ---Constraint 11: x6<=x7+x1 =>x6-x1-x7<=0
%-----Highest salary constraint(while minimising x3 we need to ensure it is
%                                       higher than others)--------
%---x3>=x1 =>x1-x3<=0
%---x3>=x2 =>x2-x3<=0
%---x3>=x4 =>x4-x3<=0
%---x3>=x5 =>x5-x3<=0
%---x3>=x6 =>x6-x3<=0
%---x3>=x7 =>x7-x3<=0
%-----Non negativity constraint------
%---x1,x2,x3,x4,x5,x6,x7>=0

c=[0;0;1;0;0;0;0];
A=[-1,0,0,0,0,0,0;1,-1,0,0,0,0,0;1,0,-1,0,0,0,0;1,0,0,-1,0,0,0;1,1,0,0,-1,0,0;2,2,-1,-1,0,0,0;0,0,0,1,0,0,-1;
    0,1,0,0,0,0,-1;0,-1,0,0,0,0,-1;-1,0,0,0,0,1,-1;1,0,-1,0,0,0,0;0,1,-1,0,0,0,0;
    0,0,-1,1,0,0,0;0,0,-1,0,1,0,0;0,0,-1,0,0,1,0;0,0,-1,0,0,0,1];
b=[-20000;-5000;-5000;-5000;0;0;0;0;-60000;0;0;0;0;0;0;0];
lb=[0;0;0;0;0;0;0;];
Aeq=[0,0,0,0,-1,1,0];
beq=[200];
[x,fval]=linprog(c,A,b,Aeq,beq,lb);
fprintf (' The Total Salary Expenses(in rs) is : %d \n',  fval);
for i=1:7
    fprintf(' Salary (in rs) of Person %d is : %d \n', i, x(i));
end
