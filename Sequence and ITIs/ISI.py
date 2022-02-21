# -*- coding: utf-8 -*-
"""
Created on Tue Feb 15 11:01:05 2022

@author: install
"""
#%% PREOK 1
import numpy as np
import csv
from copy import deepcopy

Allblocks = list()

for block in range(7,13):
    file = 'PREOKblock' + str(block) + '.csv'
    with open(file, newline='') as f:
        reader = csv.reader(f)
        data = list(reader)
    stock = deepcopy(data)
        
    #fix ITI (suppress 17 and 1st=0)
    # ma = len(data) -1
    # for nb in range(ma):
    #     data[ma - nb][6] = data[ma - nb -1][6]
    # data[0][6] = 0
    
    Allblocks = Allblocks +data

# add ITIs
isis = [.800,1.000,1.200,.800,1.000,1.200]
list_order = [i[0] for i in Allblocks]
for el in range(len(data)):
    indices = [index for index, element in enumerate(list_order) if element == list_order[el]]
    
    #jittered stim
    np.random.shuffle(isis)
    
    for nb in range(len(indices)):
        Allblocks[indices[nb]].append(isis[nb])

with open("PREOKALL.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Allblocks)
#%% PREOK 2
import numpy as np
import csv
from copy import deepcopy

Allblocks = list()

new_order = list(range(1,7))
np.random.shuffle(new_order)

for block in new_order:
    file = 'PREOKblock' + str(block) + '.csv'
    with open(file, newline='') as f:
        reader = csv.reader(f)
        data = list(reader)
    stock = deepcopy(data)
        
    #fix ITI (suppress 17 and 1st=0)
    # ma = len(data) -1
    # for nb in range(ma):
    #     data[ma - nb][6] = data[ma - nb -1][6]
    # data[0][6] = 0
    
    Allblocks = Allblocks +data

# add ITIs
isis = [.800,1.000,1.200,.800,1.000,1.200]
list_order = [i[0] for i in Allblocks]
for el in range(len(data)):
    indices = [index for index, element in enumerate(list_order) if element == list_order[el]]
    
    #jittered stim
    np.random.shuffle(isis)
    
    for nb in range(len(indices)):
        Allblocks[indices[nb]].append(isis[nb])

with open("PREOKALL2.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Allblocks)
#%% CONBLOCKS

import numpy as np
import csv
from copy import deepcopy

Allblocks = list()

for block in range(1,9):
    file = 'CONOKblock' + str(block) + '.csv'
    with open(file, newline='') as f:
        reader = csv.reader(f)
        data = list(reader)
    stock = deepcopy(data)
        
    #fix ITI (suppress 17 and 1st=0)
    # ma = len(data) -1
    # for nb in range(ma):
    #     data[ma - nb][4] = data[ma - nb -1][4]
    # data[0][4] = 0
    
    

    # add ITIs
    isis = [.800,1.000,1.200]
    with open('Condstim.csv', newline='') as f:
        reader = csv.reader(f)
        base = list(reader)
    list_order = [i[0] for i in data]
    base = [i[0] for i in base]

    for el in range(len(base)):
        indices = [index for index, element in enumerate(list_order) if element == base[el]]
        
        #jittered stim
        np.random.shuffle(isis)
        
        for nb in range(len(indices)):
            data[indices[nb]].append(isis[nb])

    file2 = "CONOKblock" + str(block) + 'ISI.csv'
    with open(file2, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(data)