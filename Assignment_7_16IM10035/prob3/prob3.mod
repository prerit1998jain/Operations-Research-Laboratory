/*********************************************
 * OPL 12.5 Model
 * Author: Prerit Jain
 * Creation Date: Mar 15, 2018 at 3:34:53 PM
 ********************************************/
 
int nprod = 6;
int ntruck = 2;

range product =1..nprod;
range truck = 1..ntruck; 

int profit[product][truck] = [[74,52],[95,84],[65,78],[75,75],[63,82],[89,71]];
float weight[product] = [22.32,29.47,32.63,34.52,19.97,21.39];
float vol[product] = [0.42,0.73,0.31,0.40,0.22,0.56];

dvar int+  x[product][truck];
int t1 = 1;
int t2 = 1;

maximize 
   sum (i in product, j in truck) x[i][j]*profit[i][j];
  
  subject to {
  ct1:  
      sum (i in product) weight[i]*x[i][1] <= 65*t1;
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
