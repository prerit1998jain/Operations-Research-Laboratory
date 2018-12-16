/*********************************************
 * OPL 12.5 Model
 * Author: user_2
 * Creation Date: Mar 15, 2018 at 3:43:12 PM
 *********************************************/
int ncargo=3;
int ncom=3;

range cargo=1..ncargo;
range com=1..ncom;

int w_cargo[cargo]=[2000,3000,1500];
int cap_cargo[cargo]=[100000,135000,30000];

int w_com[com]=[6000,4000,2000];
int vol_com[com]=[60,50,25];
int pro_com[com]=[60,80,50];

dvar float+ q[cargo][com]; 

maximize 
  sum (i in cargo, j in com) q[i][j]*pro_com[j];
  
  subject to{
	  ct1:  
      forall (j in cargo)
      sum (i in com) w_com[i]*q[j][i] <= w_cargo[j] ;
      
	  ct2:  
      forall (j in cargo)
      sum (i in com) vol_com[i]*w_com[i]*q[j][i] <= cap_cargo[j] ;
      
      ct3:  
      (sum (i in com) w_com[i]*q[1][i])/cap_cargo[1] == (sum (i in com) w_com[i]*q[2][i])/cap_cargo[2];
      (sum (i in com) w_com[i]*q[1][i])/cap_cargo[1] == (sum (i in com) w_com[i]*q[3][i])/cap_cargo[3];
} 