/*********************************************
 * OPL 12.5 Model
 * Author: Prerit Jain
 * Creation Date: Mar 15, 2018 at 4:18:18 PM
 *********************************************/
int nprod = 10;
int ntruck = 2;

range product =1..nprod;
range truck = 1..ntruck; 

int profit[product][truck] = [[74,52],[95,84],[65,78],[75,75],[63,82],[89,71],[90,80],[93,95],[58,72],[77,90]];
float weight[product] = [22.32,29.47,32.63,34.52,19.97,21.39,30.06,29.07,27.19,35.11];
float vol[product] = [0.42,0.73,0.31,0.40,0.22,0.56,0.31,0.42,0.31,0.29];

dvar int+  x[product][truck];
dvar int+ t1;
dvar int+ t2;

maximize 
   sum (i in product, j in truck) x[i][j]*profit[i][j];
  
  subject to {
  ct1:  
      sum (i in product) weight[i]*x[i][1] <= 60*t1;
  ct2:
      sum (i in product) weight[i]*x[i][2] <= 100*t2;
      
  ct3:
      sum (i in product) vol[i]*x[i][1] <= 1.5*t1;
      
  ct4:
    sum (i in product) vol[i]*x[i][2] <= 2*t2;
    
  ct5:
    forall(i in product)
      sum (j in truck) x[i][j] <= 1;
    
  ct6:
    forall (i in product, j in truck) x[i][j] <=1;
  }
 