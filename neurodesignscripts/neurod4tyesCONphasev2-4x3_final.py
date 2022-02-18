#To fill
blocknb = 5 #write the nb of the block this is for
# seed = 7207  #to have a different result each time, change the number
# seed = 1289
# seed = 1234
# seed = 9876
seed = 9584
# seed = 9876


import os 
if 'TASK_UID' in os.environ.keys(): 
    import sys 
    sys.path.append('/usr/local/bin/') 
    from neurodesign import experiment, optimisation 
     
else: 
    from neurodesign import experiment, optimisation 
EXP = experiment( 
    TR = 2.8, 
     n_trials = 48, 
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
     ITImin = 0.56,         #because resolution = TR/10, so if I don't do .56 instaest of .5 I get ITIs of .28 
     ITImean = 2.0, 
     ITImax = 10.0, 
     confoundorder = 3, 
     maxrep = 12, 
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

#% makes sure equal numner of repeition of each stim
countcat=[None]*4
ordercar = order
for j in range(4):
    countcat[j]= ordercar.count(j)
print(countcat)
if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
    print("ok")
    

    #% create a block from order, ITI and stim names
    
    from copy import deepcopy
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
        for reps in range(3):
            for el in data1:
                if int(el[3])== idx:
                    list_names[idx] = list_names[idx] + [el]
                    count+=1
                
    Seq_d = list()
    count = 0
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
        if count>=1:
            print(options[0])
            print(Seq_d[-1][0:4])
            print('xxxxxxxx')
            while options[0] == Seq_d[-1][0:4]: #no repetition
                random.shuffle(options)
    
        
        xel = deepcopy(options[0])
        xel.append(ITI[iticount])
        
        Seq_d = Seq_d + [xel]
        stock[el].remove(options[0])
        print(iticount)  
        iticount+=1
    
    #% save
    filename = "CONOKblock" + str(blocknb) + ".csv"
    with open(filename, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(Seq_d)
        
