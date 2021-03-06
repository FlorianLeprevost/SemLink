# -*- coding: utf-8 -*-
"""
Created on Fri Nov 19 16:44:11 2021

@author: Florian Leprevost
"""
#cd Documents/Python Scripts
import csv
import random
import numpy as np
#%% import precond list

with open('Precondstims.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)

pos = [256 for i in range(8)] +[-256 for i in range(8)] 
random.shuffle(pos)
pos = pos + [256 for i in range(4)] # controls
pos2 = list(-np.array(pos))
for el in range(len(data)):
    data[el].append(pos[el])
    data[el].append(pos2[el])
    
print(data)
#tuples
# with open('file.csv', newline='') as f:
#     reader = csv.reader(f)
#     data = [tuple(row) for row in reader]

#%% Create seq

data1 = data[:]
random.shuffle(data1)
Seq_p = list()

count = 0

while count < 6:
    data2=data1[:]
    random.shuffle(data1)
    if data1[0][0] != data2[19][0]:
        Seq_p = Seq_p + data1
        count +=1
        for i in range(20):     #reverse position
            data[i][3] = -data[i][3]
            data[i][4] = -data[i][4]
            
# save
with open("PrecondShuffled.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_p)
    
#%% Conditionning 100% contingency

with open('Condstim.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
    
data1 = data[:]
random.shuffle(data1)
Seq_c = list()

count = 0

while count < 6:
    data2=data1[:]
    random.shuffle(data1)
    if data1[0][0] != data2[15][0]:
        Seq_c = Seq_c + data1
        count +=1
        
# save
with open("CondShuffled.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_c)
    
#%% Decision

#S1
with open('Decstim1.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)   
data1 = data
random.shuffle(data1)
Seq_d = list()
count = 0
while count < 2:
    data2=data1
    random.shuffle(data1)
    if data1[0][0] != data2[15][0]:
        Seq_d = Seq_d + data1
        count +=1

#S2
with open('Condstim.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)
    data1 = data
random.shuffle(data1)
count = 0
while count < 2:
    data2=data1
    random.shuffle(data1)
    if data1[0][0] != data2[15][0]:
        Seq_d = Seq_d + data1
        count +=1
# save
with open("DecShuffled.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)

#%% MEMO

#S1
with open('memostim.csv', newline='') as f:
    reader = csv.reader(f)
    data = list(reader)   
    
#weird read
data[0][0] = data[0][0][3:]
data1 = data[:]
random.shuffle(data1)
Seq_d = [data1[0]]
data1.remove(data1[0])
count = 0
while count < 31:
    if data1[0][0] != Seq_d[count][0] and data1[0][1] != Seq_d[count][1]:
        Seq_d = Seq_d + [data1[0]]
        count +=1
        data1.remove(data1[0])
    else:
        random.shuffle(data1)

            

# save
with open("Memoshuffled.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerows(Seq_d)
    
    
#%% truncated exponential distribution of ITI
import numpy as np
import scipy.stats as ss
import matplotlib.pyplot as plt

def trunc_exp_rv(low, high, scale, size):
    rnd_cdf = np.random.uniform(ss.expon.cdf(x=low, scale=scale),
                                ss.expon.cdf(x=high, scale=scale),
                                size=size)
    return ss.expon.ppf(q=rnd_cdf, scale=scale)

# plt.hist(trunc_exp_rv(1, 10, Lambda, Size))
# plt.xlim(0, 12)
import scipy.optimize as so
def solve_for_l(low, high, ept_mean):
    A = np.array([low, high])
    return 1/so.fmin(lambda L: ((np.diff(np.exp(-A*L)*(A*L+1)/L)/np.diff(np.exp(-A*L)))-ept_mean)**2,
                     x0=0.5,
                     full_output=False, disp=False)
def F(low, high, ept_mean, size):
    return trunc_exp_rv(low, high,
                        solve_for_l(low, high, ept_mean),
                        size)

#%%
low =.5
high=10
mean =1
size=32
scale = solve_for_l(low, high, mean)
res=0
while np.mean(res) < mean-.01 or np.mean(res) > mean+.01:
    res = trunc_exp_rv(low, high, scale, size)
plt.hist(res)
print(np.mean(res))


vals = (np.round(res*1000))
values = list(vals.astype(int))
np.savetxt("truncex.csv", values, delimiter=",")


