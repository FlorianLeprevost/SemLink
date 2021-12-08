# -*- coding: utf-8 -*-
"""
Created on Thu Nov 25 15:45:47 2021

@author: Florian Leprevost
"""

import pandas as pd
import matplotlib as plt
from math import isnan
df = pd.read_csv("subject-10.csv")

cnt = df["count_fixation_dot_1"]
idx_cond_trials=[None] * len(cnt)
for i in range(1,len(cnt)):
    if cnt[i] == cnt[i-1] or isnan(cnt[i]) :
        idx_cond_trials[i]=0
    else:
        idx_cond_trials[i]=1    
idx_cond_trials[0]=0

idx_cond_reward = [df["Reward"][i] for i in range(len(cnt)) if idx_cond_trials[i]==1]
money_cond = [i for indx,i in enumerate(df["money"]) if idx_cond_trials[indx]]
correct_cond = [i for indx,i in enumerate(df["correct"]) if idx_cond_trials[indx]]

correct_cond_r = [i for indx,i in enumerate(correct_cond) if idx_cond_reward[indx]==1]
correct_cond_n = [i for indx,i in enumerate(correct_cond) if idx_cond_reward[indx]==0]

            

#%%
plt.pyplot.scatter(range(48),correct_cond_r)
plt.pyplot.scatter(range(48),correct_cond_n)
#%%

cnt = df["count_fixation_dot_1_1"]
idx_dec_trials=[None] * len(cnt)
for i in range(1,len(cnt)):
    if cnt[i] == cnt[i-1] or isnan(cnt[i]) :
        idx_dec_trials[i]=0
    else:
        idx_dec_trials[i]=1    
idx_dec_trials[0]=0

idx_dec_reward = [df["Reward"][i] for i in range(len(cnt)) if idx_dec_trials[i]==1]
money_dec = [i for indx,i in enumerate(df["money"]) if idx_dec_trials[indx]]
correct_dec = [i for indx,i in enumerate(df["correct"]) if idx_dec_trials[indx]]

correct_dec_r = [i for indx,i in enumerate(correct_dec) if idx_dec_reward[indx]==1]
correct_dec_n = [i for indx,i in enumerate(correct_dec) if idx_dec_reward[indx]==0]

            

#%%
plt.pyplot.scatter(range(32),correct_dec_r)
plt.pyplot.scatter(range(32),correct_dec_n)
#%%
