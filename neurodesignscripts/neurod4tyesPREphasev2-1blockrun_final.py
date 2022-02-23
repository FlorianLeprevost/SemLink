for blocknb in range(1,13):
    #To fill
    # blocknb = 1 #write the nb of the block this is for
    # seed = 7207  #to have a different result each time, change the number
    seed = blocknb*2
    # seed = 1289
    # seed = 1234
    # seed = 9876
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
        n_trials = 20, 
        P = [0.2, 0.2, 0.2, 0.2, 0.2], 
        # C = [[0.25, -0.25, 0.25, -0.25,0.0],\
        #      [0.25, 0.25, -0.25, -0.25,0.0],\
        #          [0.5, -0.5, 0.0, 0.0,0.0],\
        #              [0.0, 0.0, 0.5, -0.5,0],\
        #                  [0.5, 0.0, -0.5, 0.0,0.0],\
        #                      [0.0, 0.5, 0.0, -0.5,0.0]], 
          C = [[0.25, -0.25, 0.25, -0.25, 0.0], [0.25, 0.25, -0.25, -0.25, 0.0], [0.5, -0.5, 0.0, 0.0, 0.0], [0.0, 0.0, 0.5, -0.5, 0.0], [0.5, 0.0, -0.5, 0.0, 0.0], [1.0, 0.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 1.0, 0.0], [0.0, 0.0, 0.0, 0.0, 1.0], [0.5, -0.5, 0.0, 0.0, 0.0], [0.5, 0.0, -0.5, 0.0, 0.0], [0.5, 0.0, 0.0, -0.5, 0.0], [0.5, 0.0, 0.0, 0.0, -0.5], [0.0, 0.5, -0.5, 0.0, 0.0], [0.0, 0.5, 0.0, -0.5, 0.0], [0.0, 0.5, 0.0, 0.0, -0.5], [0.0, 0.0, 0.5, -0.5, 0.0], [0.0, 0.0, 0.5, 0.0, -0.5], [0.0, 0.0, 0.0, 0.5, -0.5]], 
    
         duration = None, 
         n_stimuli = 5, 
         rho = 0.3, 
         resolution = 0.25, 
         stim_duration = 1.5, 
         restnum = 0, 
         restdur = 0.0, 
         ITImodel = 'exponential', 
         ITImin = 1.5, 
         ITImean = 2.5, 
         ITImax = 10.0, 
         confoundorder = 3, 
         maxrep = 4, 
         hardprob = False, 
         t_pre = 0.0, 
         t_post = 0.0, 
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
    
    
            
    #% test order
    
    countcat=[None]*5
    ordercar = order
    for j in range(5):
        countcat[j]= ordercar.count(j)
    print(countcat)
    if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
        print("ok")
    
    
        #% add file names PRE
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
                    
        
        #%
        from copy import deepcopy
        
        Seq_d = list()
        iticount = 0
        random.shuffle(list_names)
        random.shuffle(list_names)
        random.shuffle(list_names)
        random.shuffle(list_names)
        stock = deepcopy(list_names)
        
        for el in order:
            options = stock[el]
            random.shuffle(options)
            options[0].append(ITI[iticount])
            Seq_d = Seq_d + [options[0]]
            stock[el].remove(options[0]) 
            iticount+=1
        
        filename= "PREOKblock" + str(blocknb) + ".csv"
        with open(filename, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerows(Seq_d)