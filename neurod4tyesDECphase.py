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
     maxrep = 4, 
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

#%%
alldes = POP.designs
countcat=[None]*4
for i in range(20):
    ordercar = alldes[i].order[0:16]
    for j in range(4):
        countcat[j]= ordercar.count(j)
    if countcat[0]== countcat[1] and countcat[2]== countcat[1] and countcat[3]== countcat[1]:
        print(i)
            
    