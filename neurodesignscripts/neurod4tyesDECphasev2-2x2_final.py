blocknb = 4 #write the nb of the block this is for
# seed = 7207  #to have a different result each time, change the number
# seed = 6512
# seed = 1289
# seed = 1234
seed = 9876
# seed = 9584
# seed = 6514
# seed = 3584
# seed = 6328 bad

import os 
if 'TASK_UID' in os.environ.keys(): 
    import sys 
    sys.path.append('/usr/local/bin/') 
    from neurodesign import experiment, optimisation 
     
else: 
    from neurodesign import experiment, optimisation 
EXP = experiment( 
    TR = 2.8, 
     n_trials = 32, 
     P = [0.25, 0.25, 0.25, 0.25], 
     C = [[0.25, -0.25, 0.25, -0.25],\
          [0.25, 0.25, -0.25, -0.25],\
              [0.5, -0.5, 0.0, 0.0],\
                  [0.0, 0.0, 0.5, -0.5],\
                      [0.5, 0.0, -0.5, 0.0],\
                          [0.0, 0.5, 0.0, -0.5]], 
     duration = None, 
     n_stimuli = 4, 
     rho = 0.3, 
     resolution = 0.25, 
     stim_duration = 1.5, 
     restnum = 0, 
     restdur = 0.0, 
     ITImodel = 'exponential', 
     ITImin = 0.56, 
     ITImean = 2.0, 
     ITImax = 10.0, 
     confoundorder = 3, 
     maxrep = 8, 
     hardprob = False, 
     t_pre = 0.0, 
     t_post = 1.0, 
) 
 
POP = optimisation( 
    experiment = EXP, 
     G = 20, 
     R = [0.4, 0.4, 0.2], 
     q = 0.01, 
     weights = [0.0, 0.5, 0.25, 0.25], 
     I = 4, 
     preruncycles = 10, 
     cycles = 100, 
     convergence = 1000, 
     folder = '/tmp', 
     outdes = 50, 
     Aoptimality = True, 
     optimisation = 'GA', 
     seed = seed 
 ) 
 
POP.optimise() 
ITI=POP.bestdesign.ITI
order=POP.bestdesign.order
print(ITI)
print(order)

#%

#% test order
countcat=[None]*4
ordercar = order
for j in range(4):
    countcat[j]= ordercar.count(j)
print(countcat)
if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
    print("ok")

#% add file names
import csv
import random
with open('DecstimScenes.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)

    data1 = data[:]
    #organize by 8 types
    list_names = [list()]*4
    for idx in range(4):
        count = 0
        for reps in range(2):
            for el in data1:
                if int(el[3])== idx:
                    list_names[idx] = list_names[idx] + [el]
                    count+=1

    Continue =1
    fail=0
    while Continue ==1:
                    
        Seq_d = list()
        iticount = 0
        empty_list = list()
        random.shuffle(list_names)
        random.shuffle(list_names)
        random.shuffle(list_names)
        stock = deepcopy(list_names)
        
        store_prev = [0,0,0,0]
        
        for el in order:
            options = stock[el]
            empty_list.append(el) #    
            #remake list that tracks nb of rep of each categ
            for i in range(4):
                store_prev[i] = empty_list.count(i)
                
            if store_prev[el]%4==0:
                random.shuffle(options)
            if iticount>=1:
                count2 = 0
                #check no repetition, track faillures but allow to continue
                while options[0] == Seq_d[-1][0:4] and count2<200:
                    random.shuffle(options)
                    count2+=1
                if count2 == 200:
                    fail=1
            
            xel = deepcopy(options[0])
            xel.append(ITI[iticount])
            
            Seq_d = Seq_d + [xel]
            stock[el].remove(options[0])
            print(iticount)  
            iticount+=1
        
        if fail !=1:
            Continue = 0
    #% save
filename = "DECOKSCENESblock"  + str(blocknb) + ".csv"
with open(filename, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)
            
    
#%%
data1 = data[:]
#organize by 8 types
list_names = [list()]*4
for idx in range(4):
    count = 0
    for el in data1:
        if int(el[3])== idx:
            list_names[idx] = list_names[idx] + [el]
            count+=1
            
#%%
from copy import deepcopy

Seq_d = list()
count = 0
stock = deepcopy(list_names)

for el in order:
    if count>15:
        stock = deepcopy(list_names)
        count = 0
    options = stock[el]
    random.shuffle(options)
    Seq_d = Seq_d + [options[0]]
    stock[el].remove(options[0])
    count +=1
    print(count)    
#% save
filename = "DECOKSCENESblock"  + str(blocknb) + ".csv"
with open(filename, "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)
