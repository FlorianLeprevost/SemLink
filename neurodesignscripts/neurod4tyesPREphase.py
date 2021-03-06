import os 
if 'TASK_UID' in os.environ.keys(): 
    import sys 
    sys.path.append('/usr/local/bin/') 
    from neurodesign import experiment, optimisation 
     
else: 
    from neurodesign import experiment, optimisation 
EXP = experiment( 
    TR = 2.8, 
    n_trials = 120, 
    P = [0.2, 0.2, 0.2, 0.2, 0.2], 
    C = [[0.25, -0.25, 0.25, -0.25,0.0],\
         [0.25, 0.25, -0.25, -0.25,0.0],\
             [0.5, -0.5, 0.0, 0.0,0.0],\
                 [0.0, 0.0, 0.5, -0.5,0],\
                     [0.5, 0.0, -0.5, 0.0,0.0],\
                         [0.0, 0.5, 0.0, -0.5,0.0]], 
     # C = [[0.25, -0.25, 0.25, -0.25, 0.0], [0.25, 0.25, -0.25, -0.25, 0.0], [0.5, -0.5, 0.0, 0.0, 0.0], [0.0, 0.0, 0.5, -0.5, 0.0], [0.5, 0.0, -0.5, 0.0, 0.0], [1.0, 0.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 0.0, 1.0], [0.5, -0.5, 0.0, 0.0, 0.0], [0.5, 0.0, -0.5, 0.0, 0.0], [0.5, 0.0, 0.0, -0.5, 0.0], [0.5, 0.0, 0.0, 0.0, -0.5], [0.0, 0.5, -0.5, 0.0, 0.0], [0.0, 0.5, 0.0, -0.5, 0.0], [0.0, 0.5, 0.0, 0.0, -0.5], [0.0, 0.0, 0.5, -0.5, 0.0], [0.0, 0.0, 0.5, 0.0, -0.5], [0.0, 0.0, 0.0, 0.5, -0.5]], 

     duration = None, 
     n_stimuli = 5, 
     rho = 0.3, 
     resolution = 0.25, 
     stim_duration = 1.5, 
     restnum = 0, 
     restdur = 0.0, 
     ITImodel = 'exponential', 
     ITImin = 1.5, 
     ITImean = 3, 
     ITImax = 17.0, 
     confoundorder = 3, 
     maxrep = 30, 
     hardprob = False, 
     t_pre = 0.0, 
     t_post = 0.0, 
) 
 
seed = 7207 
# seed = 7295 
POP = optimisation( 
    experiment = EXP, 
     G = 20, 
     R = [0.4, 0.4, 0.2], 
     q = 0.01, 
     weights = [0.0, 0.5, 0.25, 0.25], 
     I = 4, 
     preruncycles = 10, 
     cycles = 500, 
     convergence = 5000, 
     folder = '/tmp', 
     outdes = 50, 
     Aoptimality = True, 
     optimisation = 'GA', 
     seed = seed 
 ) 
 
POP.optimise() 
# POP.download()
#%#
ITI=POP.bestdesign.ITI
order=POP.bestdesign.order
print(ITI)
print(order)

#%%
alldes = POP.designs
countcat=[None]*5
for i in range(21):
    ordercar = alldes[i].order
    for j in range(5):
        countcat[j]= ordercar.count(j)
    print(countcat)
    if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
        print(i)
        
#%% test order
countcat=[None]*6
for i in range(4):
    ordercar = order[0+i*20:20+i*20]
    for j in range(5):
        countcat[j]= ordercar.count(j)
    print(countcat)
    if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
        print(i)
        
#%% manually create order with best design
import numpy as np

orderlist=[[4, 0, 2, 2, 3, 3, 0, 0, 1, 1, 4, 4, 3, 3, 2, 2, 4, 0, 1, 1],\
            [0, 0, 2, 2, 3, 3, 0, 0, 1, 1, 4, 4, 3, 3, 2, 1, 1, 2, 4, 4],\
                [3, 0, 1, 1, 4, 4, 2, 2, 3, 3, 1, 4, 0, 0, 1, 2, 2, 0, 4, 3],\
                    [3, 0, 1, 1, 4, 4, 2, 3, 1, 2, 4, 3, 0, 0, 1, 0, 3, 4, 2, 2]]

fullDECseq = list()
for nrep in range(4):
    seq16 = orderlist[np.random.randint(0,4)]
    seq16 = np.array(seq16) + np.random.randint(0,5)
    for el in range(20):
        if seq16[el]>=5:
            seq16[el] = seq16[el]-5
        # if nrep>=2:
        #     seq16[el] = seq16[el]+4
        fullDECseq.append(seq16[el])
    
#%% save
import pickle

orderDECphase = [order, ITI]
 
file_name = "D:/Users/install/SemLink/DECparam.pkl"
open_file = open(file_name, "wb")
pickle.dump(orderDECphase, open_file)
open_file.close()
#%%

open_file = open(file_name, "rb")
loaded_list = pickle.load(open_file)
ITI = loaded_list[1]
order = loaded_list[0]
#%% change for dec trials so that = objects
import numpy as np
order[32:]=list(np.array(order[32:])+4)
#%% add file names DEC
import csv
import random
with open('DecstimAll.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
    

data1 = data[:]
#organize by 8 types
list_names = [list()]*8
for idx in range(8):
    count = 0
    for el in data1:
        if int(el[3])== idx:
            list_names[idx] = list_names[idx] + [el]
            count+=1
            
#%%
from copy import deepcopy

Seq_d = list()
count = 0
iticount=1
stock = deepcopy(list_names)

for el in order:
    if count>15:
        stock = deepcopy(list_names)
        count = 0
    options = stock[el]
    random.shuffle(options)
    options[0].append(ITI[iticount])
    Seq_d = Seq_d + [options[0]]
    stock[el].remove(options[0])
    count +=1
    print(count)
    iticount+=1
    if iticount==64:
        iticount=0    
#% save
with open("DECOK.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)
    
#%% add file names CON
import csv
import random
with open('Condstim.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
    

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
iticount = 1

stock = deepcopy(list_names)

for el in order:
    if count>15:
        stock = deepcopy(list_names)
        count = 0
    options = stock[el]
    random.shuffle(options)
    options[0].append(ITI[iticount])
    Seq_d = Seq_d + [options[0]]
    stock[el].remove(options[0])
    count +=1
    print(count)  
    iticount+=1
    if iticount==96:
        iticount=0
#% save
with open("CONOK.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)
    
#%%
#%% add file names PRE
import csv
import random
with open('Precondstims.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
    

data1 = data[:]
#organize by 8 types
list_names = [list()]*5
for idx in range(5):
    count = 0
    for el in data1:
        if int(el[5])== idx:
            
            list_names[idx] = list_names[idx] + [el]
            count+=1
            
#%%
from copy import deepcopy

Seq_d = list()
count = 0
iticount = 0

stock = deepcopy(list_names)

for el in order:
    if count>19:
        stock = deepcopy(list_names)
        count = 0
    options = stock[el]
    random.shuffle(options)
    options[0].append(ITI[iticount])
    Seq_d = Seq_d + [options[0]]
    stock[el].remove(options[0])
    count +=1
    print(count)  
    iticount+=1
    # if iticount==120:
    #     iticount=0
#% save
with open("PREOK.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)