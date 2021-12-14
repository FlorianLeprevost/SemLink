# -*- coding: utf-8 -*-
"""
Created on Thu Nov 25 15:45:47 2021

@author: Florian Leprevost
"""
#cd D:\Users\install\SemLink
import pandas as pd
import matplotlib as plt
from math import isnan
import numpy as np
df = pd.read_csv("subject-140.csv")


#%% find trials

cnt = df["count_fixation_dot_1"]
idx_cond_trials=[None] * len(cnt)
for i in range(1,len(cnt)):
    if cnt[i] == cnt[i-1] or isnan(cnt[i]) :
        idx_cond_trials[i]=0
    else:
        idx_cond_trials[i]=1    
idx_cond_trials[0]=0

cnt = df["count_fixation_dot_1_1"]
idx_dec_trials=[None] * len(cnt)
for i in range(1,len(cnt)):
    if cnt[i] == cnt[i-1] or isnan(cnt[i]) : # select only trials of specific phase
        idx_dec_trials[i]=0
    else:
        idx_dec_trials[i]=1    
idx_dec_trials[0]=0

#%% new df
#add columns
df2 = df
df2["trials_cond"] = idx_cond_trials
df2["trials_dec"] = idx_dec_trials

idxok = np.array(idx_cond_trials) + np.array(idx_dec_trials)

dfok = df2[idxok==1]

#aggregate response times
RT = list(df2["response_time_con_resp"][np.array(idx_cond_trials)==1])
RT2 = list(df2["response_time_con_resp_1"][np.array(idx_dec_trials)==1])
RT = RT + RT2
dfok["RT"]=RT
#%% divide 2 phases
dfcond = dfok[dfok["trials_cond"]==1]
dfdec = dfok[dfok["trials_dec"]==1]

#%%
DFc = dfcond[49:]#select one df
DFc[["correct", "paired", "Reward", "RT"]].groupby(["paired", "Reward"]).mean()

#%%
DFc.boxplot(column=["RT"], by=["paired", "Reward"],grid=False)
#%%
DFc.boxplot(column=["RT"], by=["Reward"],grid=False)
#%%
DFc.boxplot(column=["RT"], by=["paired"],grid=False)
#%%
# #which trial rewarded
# idx_cond_reward = [df["Reward"][i] for i in range(len(cnt)) if idx_cond_trials[i]==1]
# #current winnings
# money_cond = [i for indx,i in enumerate(df["money"]) if idx_cond_trials[indx]]
# #which trial correct
# correct_cond = [i for indx,i in enumerate(df["correct"]) if idx_cond_trials[indx]]
# # which trials corrects, divided by rewarded or not condition
# correct_cond_rew1 = [i for indx,i in enumerate(correct_cond) if idx_cond_reward[indx]==1]
# correct_cond_rew0 = [i for indx,i in enumerate(correct_cond) if idx_cond_reward[indx]==0]
# #which trial correct
# idx_cond_paired = [df["paired"][i] for i in range(len(cnt)) if idx_cond_trials[i]==1]
# #which trial correct, by pairing
# correct_cond_pai1 = [i for indx,i in enumerate(correct_cond) if idx_cond_paired[indx]==1]        
# correct_cond_pai0 = [i for indx,i in enumerate(correct_cond) if idx_cond_paired[indx]==0]  

# #%%
# plt.pyplot.scatter(range(48),correct_cond_rew1)
# plt.pyplot.scatter(range(48),correct_cond_rew0)
# #%%
# plt.pyplot.scatter(range(48),correct_cond_pai1)
# plt.pyplot.scatter(range(48),correct_cond_pai0)
# #%%

# cnt = df["count_fixation_dot_1_1"]
# idx_dec_trials=[None] * len(cnt)
# for i in range(1,len(cnt)):
#     if cnt[i] == cnt[i-1] or isnan(cnt[i]) : # select only trials of specific phase
#         idx_dec_trials[i]=0
#     else:
#         idx_dec_trials[i]=1    
# idx_dec_trials[0]=0

# idx_dec_reward = [df["Reward"][i] for i in range(len(cnt)) if idx_dec_trials[i]==1]
# money_dec = [i for indx,i in enumerate(df["money"]) if idx_dec_trials[indx]]
# correct_dec = [i for indx,i in enumerate(df["correct"]) if idx_dec_trials[indx]]

# correct_dec_r = [i for indx,i in enumerate(correct_dec) if idx_dec_reward[indx]==1]
# correct_dec_n = [i for indx,i in enumerate(correct_dec) if idx_dec_reward[indx]==0]

# idx_dec_paired = [df["paired"][i] for i in range(len(cnt)) if idx_dec_trials[i]==1]
# #which trial correct, by pairing
# correct_dec_pai1 = [i for indx,i in enumerate(correct_dec) if idx_dec_paired[indx]==1]        
# correct_dec_pai0 = [i for indx,i in enumerate(correct_dec) if idx_dec_paired[indx]==0]  
            

# #%%
# plt.pyplot.scatter(range(32),correct_dec_r)
# plt.pyplot.scatter(range(32),correct_dec_n)
# #%% 
# plt.pyplot.scatter(range(32),correct_dec_pai1)
# plt.pyplot.scatter(range(32),correct_dec_pai0)

