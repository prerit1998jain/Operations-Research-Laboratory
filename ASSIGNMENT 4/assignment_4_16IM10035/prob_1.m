clc;
clear all;
%---------Container - Product Problem---------%
%-------------Decision variable----------%
%
%-------- xij = 1  ;   if product i is placed in container j for i in {1,2...10}
%                      and j= {1,2,3,4,5}
%-------- xij = 0  ;   otherwise 

%-------- yj = 1   ;   if container j is selected for all j=1,2,3,4,5
%-------- yj = 0   ;   otherwise


%----------Objective function--------------%

%----  Maximize z = (cij*xij-cj*yj) for all i in {1,2...10} and j in
%                                     {1,2,3,4,5}
%                    
%----  cij = profit gained if product i is stored in container j 
%----  cj = fixed cost of container j for j=1,2,3,4,5
%      Assuming V=10(constant)

%---------   Constraints  -------------%

%--------- Volume constraint  -------------%

%-- 250x11 + 270x21 + 150x31 + ... + 500x91 + 220x101 <= 1000  (Container 1)
%-- 250x12 + 270x22 + 150x32 + ... + 500x92 + 220x102 <= 1200  (Container 2)
%-- 250x13 + 270x23 + 150x33 + ... + 500x93 + 220x103 <= 800   (Container 3)
%-- 250x14 + 270x24 + 150x34 + ... + 500x94 + 220x104 <= 1000  (Container 4)
%-- 250x15 + 270x25 + 150x35 + ... + 500x95 + 220x105 <= 1500  (Container 5)

%------------ Product Constraint-------------%

%-- x11 + x12 + x13 + x14 + x15 = 1         ( Product 1)
%-- x21 + x22 + x23 + x24 + x25 = 1         ( Product 2)
%-- x31 + x32 + x33 + x34 + x35 = 1         ( Product 3)
%-- x41 + x42 + x43 + x44 + x45 = 1         ( Product 4)
%-- x51 + x52 + x53 + x54 + x55 = 1         ( Product 5)
%-- x61 + x62 + x63 + x64 + x65 = 1         ( Product 6)
%-- x71 + x72 + x73 + x74 + x75 = 1         ( Product 7)
%-- x81 + x82 + x83 + x84 + x85 = 1         ( Product 8)
%-- x91 + x92 + x93 + x94 + x95 = 1         ( Product 9)
%-- x101 + x102 + x103 + x104 + x105 = 1    ( Product 10)

%------------Container Selection constraint----------%

%---Let M be a large positive number = 100 (say)
%--- yj = 1 if xij = 1 for all j 
%                  = 0 otherwise
%-- x11 + x21 + x31 + x41 + x51 + x61 + x71 + x81 + x91 + x101 <= My1 ( Container 1)
%-- x12 + x22 + x32 + x42 + x52 + x62 + x72 + x82 + x92 + x102 <= My2 ( Container 2)
%-- x13 + x23 + x33 + x43 + x53 + x63 + x73 + x83 + x93 + x103 <= My3 ( Container 3)
%-- x14 + x24 + x34 + x44 + x54 + x64 + x74 + x84 + x94 + x104 <= My4 ( Container 4)
%-- x15 + x25 + x35 + x45 + x55 + x65 + x75 + x85 + x95 + x105 <= My5 ( Container 5)

%-----------------Integer and non-negativity constraint------------%
%--- xij,yj are binary variables
%--- xij,yj>=0 for all i=1,2,...10 and j=1,2,3,4,5

c=[-1.1*250;-1.3*250;-2.0*250;-1.0*250;-30*250;
   -2.0*270;-2.0*270;-1.5*270;-3.0*270;-1.0*270;
   -3.0*150;-2.0*150;-1.0*150;-2.0*150;-1.5*150;
   -3.5*300;-2.0*300;-1.0*300;-2.0*300;-3.0*300;
   -1.5*320;-6.0*320;-1.5*320;-2.0*320;-4.0*320;
   -1.0*180;-3.0*180;-1.5*180;-2.0*180;-1.5*180;
   -6.0*400;-2.0*400;-7.5*400;-1.0*400;-3.0*400;
   -3.0*450;-4.0*450;-2.5*450;-1.5*450;-2.0*450;
   -5.0*500;-6.0*500;-4.5*500;-3.0*500;-4.0*500;
   -2.5*220;-3.0*220;-2.5*220;-2.0*220;-2.0*220;
    700;1000;700;800;1200];

A=[250,0,0,0,0,270,0,0,0,0,150,0,0,0,0,300,0,0,0,0,320,0,0,0,0,180,0,0,0,0,400,0,0,0,0,450,0,0,0,0,500,0,0,0,0,220,0,0,0,0,0,0,0,0,0;
    0,250,0,0,0,0,270,0,0,0,0,150,0,0,0,0,300,0,0,0,0,320,0,0,0,0,180,0,0,0,0,400,0,0,0,0,450,0,0,0,0,500,0,0,0,0,220,0,0,0,0,0,0,0,0;
    0,0,250,0,0,0,0,270,0,0,0,0,150,0,0,0,0,300,0,0,0,0,320,0,0,0,0,180,0,0,0,0,400,0,0,0,0,450,0,0,0,0,500,0,0,0,0,220,0,0,0,0,0,0,0;
    0,0,0,250,0,0,0,0,270,0,0,0,0,150,0,0,0,0,300,0,0,0,0,320,0,0,0,0,180,0,0,0,0,400,0,0,0,0,450,0,0,0,0,500,0,0,0,0,220,0,0,0,0,0,0;
    0,0,0,0,250,0,0,0,0,270,0,0,0,0,150,0,0,0,0,300,0,0,0,0,320,0,0,0,0,180,0,0,0,0,400,0,0,0,0,450,0,0,0,0,500,0,0,0,0,220,0,0,0,0,0;
   1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-100,0,0,0,0; 
   0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-100,0,0,0;
   0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-100,0,0;
   0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-100,0;
   0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-100];

b=[1000;1200;800;1000;1500;0;0;0;0;0];

Aeq=[1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0];

beq=[1;1;1;1;1;1;1;1;1;1];

intcon=[1:55];

lb=[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;];

ub=[1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;];

[x,fval]=intlinprog(c,intcon,A,b,Aeq,beq,lb,ub);

fprintf('The total profit at V=10 is:%d\n',-fval);
for i=51:55
    if(x(i)>0)
        fprintf('Container %d is selected\n',i-50);
    else
        fprintf('Container %d is not selected\n',i-50);
    end
end

for i=1:50
    if(x(i)>0 && i<=5 )
        if mod(i,5)>0
            fprintf('Product 1 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 1 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>5 && i<=10 )
        if mod(i,5)>0
            fprintf('Product 2 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 2 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>10 && i<=15 )
        if mod(i,5)>0
            fprintf('Product 3 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 3 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>15 && i<=20 )
        if mod(i,5)>0
            fprintf('Product 4 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 4 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>20 && i<=25 )
        if mod(i,5)>0
            fprintf('Product 5 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 5 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>25 && i<=30 )
        if mod(i,5)>0
            fprintf('Product 6 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 6 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>30 && i<=35 )
        if mod(i,5)>0
            fprintf('Product 7 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 7 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>35 && i<=40 )
        if mod(i,5)>0
            fprintf('Product 8 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 8 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>40 && i<=45 )
        if mod(i,5)>0
            fprintf('Product 9 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 9 is placed in container %d\n',mod(i,5)+5);
        end
    end
    if(x(i)>0 && i>45 && i<=50 )
        if mod(i,5)>0
            fprintf('Product 10 is placed in cotainer %d\n',mod(i,5));
        else
            fprintf('Product 10 is placed in container %d\n',mod(i,5)+5);
        end
    end
end    
    
    



















