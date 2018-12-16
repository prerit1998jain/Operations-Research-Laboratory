
/*********************************************
 * OPL 12.7.9.0 Model
 * Author: Prerit Jain
 * Creation Date: Mar 17, 2018 at 12:00:39 PM
 *********************************************/
 int nplace = 3;
 int ncomm = 3;
 range place = 1..nplace;
 range comm = 1..ncomm;
 
 int weight [place] = [2000,3000,1500];
 int capacity[place] = [100000,135000,30000];
 
 int weightCom [comm] = [6000,4000,2000];
 int volume_ton [comm] = [60,50,25];
 int profit [comm] = [60,80,50];
 
 dvar float+ cip [place][comm];
 
 maximize
 sum (i in place, j in comm) cip[i][j]*profit[j];
 
 subject to {
   ct1:
    sum(j in comm) cip[2][j] == 1.35*sum(j in comm) cip[1][j];
    sum(j in comm) cip[3][j] == 4.5*sum(j in comm) cip[2][j];
    
   ct2:
     forall (i in place)
       sum (j in comm) cip[i][j] <= weight[i];
       
   ct3:
     forall (j in comm)
       sum (i in place) cip[i][j] <= weightCom[j];
       
   ct4:
     forall (i in place)
       sum(j in comm) cip[i][j]*volume_ton[j] <= capacity[i];

   } 