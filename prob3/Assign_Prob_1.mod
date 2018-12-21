/*********************************************
 * OPL 12.5 Model
 * Author: user_2
 * Creation Date: Mar 15, 2018 at 2:57:10 PM
 *********************************************/
int nplant=3;
int nwarehouse=3;
int ndemand=4;

range plant=1..nplant;
range warehouse=1..nwarehouse;
range demand=1..ndemand;

int tcostpw [plant][warehouse] = [[5000,3000,6500],[6000,3200,2500],[5500,2300,6200]];
int tcostwd [warehouse][demand] = [[6000,4500,5000,4000],[5500,3200,2500,4700],[5500,2300,6200,8000]];
int dem [demand] =[50,130,75,90];

dvar int+ Qpw [plant][warehouse];
dvar int+ Qwd [warehouse][demand];

minimize 
  sum (i in plant, j in warehouse) Qpw[i][j]*tcostpw[i][j] +
  sum (j in warehouse, k in demand) Qwd[j][k]*tcostwd[j][k];
  
  subject to {
  ct1:  
      forall (j in warehouse)
      sum (i in plant) Qpw[i][j] == sum (k in demand)Qwd[j][k];
      
  ct2:
      forall (k in demand)
        sum (j in warehouse) Qwd[j][k] == dem[k];
  }