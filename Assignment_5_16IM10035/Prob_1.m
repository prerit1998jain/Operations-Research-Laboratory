clc;
clear all;
% --------SONAR ENERGY PROBLEM----------%

% ---------Decision variables-----------%

% -- xij = Amount of coal (in tones) supplied by supplier i to the generating unit j 
%          for all i in {1,2...7} and j in {1,2,3,4,5}

% -------- Objective function -----------%

% -- MINIMIZE : z = sum(sum(cij * xij)) + sum((ci * xij))
%                   where cij = Transportation cost incurred inorder to transport coal 
%                               from supplier i to generating unit j. 
%                               for all i in {1,2...7} and j in {1,2,3,4,5}
%                          ci = Cost (per ton) to purchase coal from supplier i 
%                               for all i in {1,2...7}

%----------- Supply Constraints ----------%

%-- x11 + x12 + x13 + x14 + x15 = 350000      ( Supplier 1)
%-- x21 + x22 + x23 + x24 + x25 = 300000      ( Supplier 2)
%-- x31 + x32 + x33 + x34 + x35 = 275000      ( Supplier 3)
%-- x41 + x42 + x43 + x44 + x45 <= 200000     ( Supplier 4)
%-- x51 + x52 + x53 + x54 + x55 <= 175000     ( Supplier 5)
%-- x61 + x62 + x63 + x64 + x65 <= 200000     ( Supplier 6)
%-- x71 + x72 + x73 + x74 + x75 <= 180000     ( Supplier 7)

%------------ Demand contraints -----------%

%-- 13*x11 + 13.3*x21 + 12.6*x31 + 12.25*x41 + 12*x51 + 12*x61 + 11.3*x71 >= 550000*10.5
%-- 13*x12 + 13.3*x22 + 12.6*x32 + 12.25*x42 + 12*x52 + 12*x62 + 11.3*x72 >= 500000*10.2
%-- 13*x13 + 13.3*x23 + 12.6*x33 + 12.25*x43 + 12*x53 + 12*x63 + 11.3*x73 >= 650000*10.1
%-- 13*x14 + 13.3*x24 + 12.6*x34 + 12.25*x44 + 12*x54 + 12*x64 + 11.3*x74 >= 750000*10
%-- 13*x15 + 13.3*x25 + 12.6*x35 + 12.25*x45 + 12*x55 + 12*x65 + 11.3*x75 >= 1100000*10

%-------- Non Negativity Constraint---------%

%-- xij>=0  for all i in {1,2,3,4,5,6,7} and j in {1,2,3,4,5}

f=[ 27    ; 27    ; 26.75 ;   27  ; 26.75 ;
    29.75 ; 29.75 ; 29.5  ; 29.75 ; 29.5  ;
    25    ; 25    ; 24.75 ; 25    ; 24.75 ;
    35.25 ; 35.25 ; 34.85 ; 35.25 ; 34.85 ;
    40    ; 40    ; 39.75 ; 40    ; 39.75 ;
    33.25 ; 33.25 ; 33    ; 33.25 ; 33    ;
    35    ;  35   ; 34.6  ; 35    ; 34.6  ;];

Aeq = [1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
       0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
       0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
 
 A=[ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1;
     -13,0,0,0,0,-13.3,0,0,0,0,-12.6,0,0,0,0,-12.25,0,0,0,0,-12,0,0,0,0,-12,0,0,0,0,-11.3,0,0,0,0;
     0,-13,0,0,0,0,-13.3,0,0,0,0,-12.6,0,0,0,0,-12.25,0,0,0,0,-12,0,0,0,0,-12,0,0,0,0,-11.3,0,0,0;
     0,0,-13,0,0,0,0,-13.3,0,0,0,0,-12.6,0,0,0,0,-12.25,0,0,0,0,-12,0,0,0,0,-12,0,0,0,0,-11.3,0,0;
     0,0,0,-13,0,0,0,0,-13.3,0,0,0,0,-12.6,0,0,0,0,-12.25,0,0,0,0,-12,0,0,0,0,-12,0,0,0,0,-11.3,0;
     0,0,0,0,-13,0,0,0,0,-13.3,0,0,0,0,-12.6,0,0,0,0,-12.25,0,0,0,0,-12,0,0,0,0,-12,0,0,0,0,-11.3;];
     
beq=[ 350000 ; 300000 ; 275000];

b=[ 200000 ; 175000 ; 200000 ; 180000 ; -5775000 ; -5100000 ; -6565000 ; -7500000 ; -11000000];

lb=[0;0;0;0;0;0;0;
    0;0;0;0;0;0;0;
    0;0;0;0;0;0;0;
    0;0;0;0;0;0;0;
    0;0;0;0;0;0;0;];

[x,fval]=linprog(f,A,b,Aeq,beq,lb);

fprintf('The total cost is : %d \n',fval);
fprintf('\n');

fprintf('The amount of coal(in tons) purchased from supplier 1 is: %d \n',x(1)+x(2)+x(3)+x(4)+x(5));
fprintf('The amount of coal(in tons) purchased from supplier 2 is: %d \n',x(6)+x(7)+x(8)+x(9)+x(10));
fprintf('The amount of coal(in tons) purchased from supplier 3 is: %d \n',x(11)+x(12)+x(13)+x(14)+x(15));
fprintf('The amount of coal(in tons) purchased from supplier 4 is: %d \n',x(16)+x(17)+x(18)+x(19)+x(20) );
fprintf('The amount of coal(in tons) purchased from supplier 5 is: %d \n',x(21)+x(22)+x(23)+x(24)+x(25));
fprintf('The amount of coal(in tons) purchased from supplier 6 is: %d \n',x(26)+x(27)+x(28)+x(29)+x(30));
fprintf('The amount of coal(in tons) purchased from supplier 7 is: %d \n',x(31)+x(32)+x(33)+x(34)+x(35));
fprintf('\n');

fprintf('24 pargana E will get %d tons of coal\n',x(1)+x(6)+x(11)+x(16)+x(21)+x(26)+x(31));
fprintf('24 pargana W will get %d tons of coal\n',x(2)+x(7)+x(12)+x(17)+x(22)+x(27)+x(32));
fprintf('  Paradip    will get %d tons of coal\n',x(3)+x(8)+x(13)+x(18)+x(23)+x(28)+x(33));
fprintf('  Durgapur   will get %d tons of coal\n',x(4)+x(9)+x(14)+x(19)+x(24)+x(29)+x(34));
fprintf('  Darjeeling will get %d tons of coal\n',x(5)+x(10)+x(15)+x(20)+x(25)+x(30)+x(35));
fprintf('\n');

fprintf('24 pargana E will spend %d Rupees on coal\n',(22*x(1)+26*x(6)+22*x(11)+32*x(16)+35*x(21)+31*x(26)+33*x(31))/7);
fprintf('24 pargana W will spend %d Rupees on coal\n',(22*x(2)+26*x(7)+22*x(12)+32*x(17)+35*x(22)+31*x(27)+33*x(32))/7);
fprintf('  Paradip    will spend %d Rupees on coal\n',(22*x(3)+26*x(8)+22*x(13)+32*x(18)+35*x(23)+31*x(28)+33*x(33))/7);
fprintf('  Durgapur   will spend %d Rupees on coal\n',(22*x(4)+26*x(9)+22*x(14)+32*x(19)+35*x(24)+31*x(29)+33*x(34))/7);
fprintf('  Darjeeling will spend %d Rupees on coal\n',(22*x(5)+26*x(10)+22*x(15)+32*x(20)+35*x(25)+31*x(30)+33*x(35))/7);
fprintf('\n');

fprintf('24 pargana E will get %d average BTUs per tons of coal\n',(13000000*x(1)+13300000*x(6)+12600000*x(11)+12250000*x(16)+12000000*x(21)+12000000*x(26)+11300000*x(31))/7);
fprintf('24 pargana W will get %d average BTUs per tons of coal\n',(13000000*x(2)+13300000*x(7)+12600000*x(12)+12250000*x(17)+12000000*x(22)+12000000*x(27)+11300000*x(32))/7);
fprintf('   Paradip   will get %d average BTUs per tons of coal\n',(13000000*x(3)+13300000*x(8)+12600000*x(13)+12250000*x(18)+12000000*x(23)+12000000*x(28)+11300000*x(33))/7);
fprintf('   Durgapur  will get %d average BTUs per tons of coal\n',(13000000*x(4)+13300000*x(9)+12600000*x(14)+12250000*x(19)+12000000*x(24)+12000000*x(29)+11300000*x(34))/7);
fprintf('   Darjeeling will get %d average BTUs per tons of coal\n',(13000000*x(5)+13300000*x(10)+12600000*x(15)+12250000*x(20)+12000000*x(25)+12000000*x(30)+11300000*x(35))/7);

    
    
    