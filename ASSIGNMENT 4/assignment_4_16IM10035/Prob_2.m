clear all;
clc;
%---------  Travelling Salesman problem    ----------%
%------- Decision variables  -----%
%--- xij = 1 if job i moves to job j for all i,j in {1,2,3,4} and
%            i!=j(As cost given in this case is infinite so moving
%            job i to job i is not possible)
%        = 0 if job i is not moved to job j

%-------  Objective function---------%
%------- Minimize z = (4x12 + 7x13 + 3x14 + 4x21 + ... + 3x41 + 3x42 + 7x43)

%-----------------Constraints---------------%
%-- ith job should be performed only once
%-- x12 + x13 + x14 = 1 ( Job 1)
%-- x21 + x23 + x24 = 1 ( Job 2)
%-- x31 + x32 + x34 = 1 ( Job 3)
%-- x41 + x42 + x43 = 1 ( Job 4)

%-------------- Constraints----------------%

%-- jth job should be reached only once
%-- x21 + x31 + x41 = 1 ( Job 1)
%-- x12 + x32 + x42 = 1 ( Job 2)
%-- x13 + x23 + x43 = 1 ( Job 3)
%-- x14 + x24 + x34 = 1 ( Job 4)

%-------------- Sub-tour Elimination Constraints --------------%
%------- Sub tour of size 2 ----------%
%-- x12 + x21 <=1 (To eliminate subtour 1-2-1 or 2-1-2)
%-- x13 + x31 <=1 (To eliminate subtour 1-3-1 or 3-1-3)
%-- x14 + x41 <=1 (To eliminate subtour 1-4-1 or 4-1-4)
%-- x32 + x23 <=1 (To eliminate subtour 3-2-3 or 2-3-2)
%-- x42 + x24 <=1 (To eliminate subtour 4-2-4 or 2-4-2)
%-- x34 + x43 <=1 (To eliminate subtour 3-4-3 or 4-3-4)

%-------- Sub-tour of size 3---------%
%-- x12 + x23 + x31 <= 2 (To eliminate subtour 1-2-3-1)
%-- x13 + x32 + x21 <= 2 (To eliminate subtour 1-3-2-1)
%-- x13 + x34 + x41 <= 2 (To eliminate subtour 1-3-4-1)
%-- x14 + x43 + x31 <= 2 (To eliminate subtour 1-4-3-1)
%-- x23 + x34 + x42 <= 2 (To eliminate subtour 2-3-4-2)
%-- x24 + x43 + x32 <= 2 (To eliminate subtour 2-4-3-2)
%-- x12 + x24 + x41 <= 2 (To eliminate subtour 1-2-4-1)
%-- x14 + x42 + x21 <= 2 (To eliminate subtour 1-4-2-1)

%------------------Non negativity and integer constraint--------%
%-- xij is a binary variable and xij >= 0 for all i,j

c=[4;7;3;4;6;3;7;6;7;3;3;7];
A=[1,0,0,1,0,0,0,0,0,0,0,0;
    0,1,0,0,0,0,1,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,1,0,0;
    0,0,0,0,1,0,0,1,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,1,0,0,1;
    1,0,0,0,1,0,1,0,0,0,0,0;
    0,1,0,1,0,0,0,1,0,0,0,0;
    0,1,0,0,0,0,0,0,1,1,0,0;
    0,0,1,0,0,0,1,0,0,0,0,1;
    0,0,0,0,1,0,0,0,1,0,1,0;
    0,0,0,0,0,1,0,1,0,0,0,1;
    1,0,0,0,0,1,0,0,0,1,0,0;
    0,0,1,1,0,0,0,0,0,0,1,0];
b=[1;1;1;1;1;1;2;2;2;2;2;2;2;2];
Aeq=[1,1,1,0,0,0,0,0,0,0,0,0;
    0,0,0,1,1,1,0,0,0,0,0,0;
    0,0,0,0,0,0,1,1,1,0,0,0;
    0,0,0,0,0,0,0,0,0,1,1,1;
    0,0,0,1,0,0,1,0,0,1,0,0;
    1,0,0,0,0,0,0,1,0,0,1,0;
    0,1,0,0,1,0,0,0,0,0,0,1;
    0,0,1,0,0,1,0,0,1,0,0,0];
beq=[1;1;1;1;1;1;1;1];
intcon=[1:12];
lb=[0;0;0;0;0;0;0;0;0;0;0;0;];
ub=[1;1;1;1;1;1;1;1;1;1;1;1;];
[x,fval]=intlinprog(c,intcon,A,b,Aeq,beq,lb,ub);
fprintf('The total time is :%d\n',fval);
for i=1:12
    fprintf('The value of variable %d is : %d\n',i,x(i));
end
fprintf('The route followed is: Job 3-1-4-2-3');

    
    