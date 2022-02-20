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
     ITImin = 0.5, 
     ITImean = 2.0, 
     ITImax = 10.0, 
     confoundorder = 3, 
     maxrep = 8, 
     hardprob = False, 
     t_pre = 0.0, 
     t_post = 1.0, 
) 
 
seed = 7207 
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
# POP.download()
#%#
ITI=POP.bestdesign.ITI
order=POP.bestdesign.order
print(ITI)
print(order)

# #%%
# alldes = POP.designs
# countcat=[None]*4
# for i in range(20):
#     ordercar = alldes[i].order
#     for j in range(4):
#         countcat[j]= ordercar.count(j)
#     print(countcat)
#     if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
#         print(i)
# #%% ok series
# [2,2,0,0,1,1,2,2,3,3,3,3,1,1,0,0,2,2,1,1,1,1,3,3,2,2,0,0,0,0,3,3]
# [2,1,1,3,0,1,2,2,3,3,3,0,0,1,0,0,2,1,1,1,3,3,2,2,2,2,0,0,0,3,3,1]
# [1,1,3,0,0,2,2,2,3,3,3,3,1,1,0,0,2,2,1,1,1,1,3,3,2,2,0,0,0,0,3,2]
# [2,1,3,0,0,2,2,2,3,3,3,3,1,1,0,0,2,2,1,1,1,1,3,3,2,2,0,0,0,0,3,1]
#%% test order
countcat=[None]*4
ordercar = order
for j in range(4):
    countcat[j]= ordercar.count(j)
print(countcat)
if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
    print("ok")
# #%% manually create order with best design
# orderlist=[[1, 3, 0, 0, 2, 2, 2, 0, 3, 3, 1, 1, 1, 3, 0, 2],\
#            [1, 3, 0, 0, 2, 2, 2, 0, 3, 3, 1, 1, 0, 1, 2, 3],\
#                [0, 3, 1, 0, 2, 2, 2, 0, 3, 3, 1, 1, 0, 1, 2, 3],\
#                    [0, 3, 1, 0, 2, 2, 2, 0, 3, 3, 1, 1, 2, 3, 0, 1]]

# fullDECseq = list()
# for nrep in range(4):
#     seq16 = orderlist[np.random.randint(0,4)]
#     seq16 = np.array(seq16) + np.random.randint(0,4)
#     for el in range(16):
#         if seq16[el]>=4:
#             seq16[el] = seq16[el]-4
#         # if nrep>=2:
#         #     seq16[el] = seq16[el]+4
#         fullDECseq.append(seq16[el])
    
# #%% save
# import pickle

# orderDECphase = [order, ITI]
 
# file_name = "D:/Users/install/SemLink/DECparam.pkl"
# open_file = open(file_name, "wb")
# pickle.dump(orderDECphase, open_file)
# open_file.close()

# open_file = open(file_name, "rb")
# loaded_list = pickle.load(open_file)

#%% change for dec trials so that = objects
import numpy as np
order[32:]=list(np.array(order[32:])+4)
#%% add file names
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
with open("DECOK.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)
