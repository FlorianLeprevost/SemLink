# -*- coding: utf-8 -*-
"""
Created on Thu Nov 25 15:45:47 2021

@author: Florian Leprevost
"""

import pandas as pd
import matplotlib.pyplot as plt
from math import isnan
import numpy as np
df = pd.read_csv("subject-10.csv")
participant = 0

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
DFc = dfdec[0:33]#select one df
y = DFc[["correct", "paired", "Reward", "RT"]].groupby(["paired", "Reward"]).mean()

#%
DFc.boxplot(column=["RT"], by=["paired", "Reward"],grid=False)
#%
DFc.boxplot(column=["RT"], by=["Reward"],grid=False)
#%
DFc.boxplot(column=["RT"], by=["paired"],grid=False)


#%%

#%% divide more and common data for all participants
#%%
def processpart(participant_file):
    df = pd.read_csv(participant_file)
    
    # find trials
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
    
    #new df
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
    # divide 2 phases
    dfcond = dfok[dfok["trials_cond"]==1]
    dfdec = dfok[dfok["trials_dec"]==1]
    dfdecS = dfdec[0:32]
    dfdecO = dfdec[32:]
    dfcond1 = dfcond[0:16]
    dfcond26 = dfcond[16:]
    liststock = [dfcond1,dfcond26, dfdecS, dfdecO]
    return liststock

#%%
phases = ["dfcond1","dfcond26", "dfdecS", "dfdecO"]
frames = list()

part_files = ["subject-10.csv", "subject-15.csv", "subject-16.csv"]

for participant in range(len(part_files)):
    participant_file= part_files[participant]
    liststock=processpart(participant_file)
    for i in range(4):
        DFc = liststock[i]
        DFc = DFc[DFc["correct"]==1]                                                             #remove errortrials
        y = DFc[["correct", "paired", "Reward", "RT"]].groupby(["paired", "Reward"]).median() #create sun stats
        y["participant"]= participant
        y["phase"]= phases[i]
        y.reset_index(level=0, inplace=True)
        y.reset_index(level=0, inplace=True)
        frames.append(y)
    
result = pd.concat(frames)


x=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase","paired", "Reward"]).mean()
print(x)



plt.figure(1)
for i in range(4):
    plt.subplot(2,2,i+1)
#     for i in range(len(part_files)):
#         plt.scatter(list(x[x["phase"]==phases[i]]["RT"].index),list(x[x["phase"]==phases[i]]["RT"]))
    result[result["phase"]==phases[i]].boxplot(column=["RT"], by=["paired","Reward"],grid=False,ax=plt.gca())
    plt.ylim([500,1300])
    
#%% nicer figures mean + sd
avg=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase","paired", "Reward"]).mean()
avg.reset_index(level=0, inplace=True)

std=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase","paired", "Reward"]).std()
std.reset_index(level=0, inplace=True)

plt.figure(figsize=(8, 6), dpi=100)
for i in range(4):
    plt.subplot(2,2,i+1)
    dats = list(avg[avg["phase"]==phases[i]]["RT"])
    sem = np.array(list(std[std["phase"]==phases[i]]["RT"]))/np.sqrt(len(part_files))
    plt.errorbar([1,2,3,4],dats,sem, ecolor="black", c="black",linewidth=0, marker="s",elinewidth=.5)
    plt.scatter([1,2,3,4],dats, marker="s", c="black",zorder=1)
    # plt.ylim([600,1100])
    plt.xticks([1,2,3,4], [0,1,0,1])
    lims = plt.gca().get_ylim()
    limsx = plt.gca().get_xlim()
    plt.vlines(2.5, lims[0],lims[1])
    plt.title(phases[i])
    plt.text(limsx[0]+.3,lims[1]-lims[1]*.05, "unpaired") 
    plt.text(limsx[1]-.9,lims[1]-lims[1]*.05, "paired") 
    if i==3 or i ==2:
        plt.xlabel("reward")
    if i==0 or i ==2:
        plt.ylabel("RT (ms)")
plt.savefig('rewardspaired.jpg')

#%%
#%% nicer figures mean + sd REWARD
avg=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase", "Reward"]).mean()
avg.reset_index(level=0, inplace=True)

std=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase", "Reward"]).std()
std.reset_index(level=0, inplace=True)

plt.figure(figsize=(8, 6), dpi=100)
for i in range(4):
    plt.subplot(2,2,i+1)
    dats = list(avg[avg["phase"]==phases[i]]["RT"])
    sem = np.array(list(std[std["phase"]==phases[i]]["RT"]))/np.sqrt(len(part_files))
    plt.errorbar([1,2],dats,sem, ecolor="black", c="black",linewidth=.5)
    plt.scatter([1,2],dats, marker="s", c="black")
    # plt.ylim([600,1100])
    plt.xticks([1,2], [0,1])
    lims = plt.gca().get_ylim()
    limsx = plt.gca().get_xlim()
    plt.title(phases[i])

    if i==3 or i ==2:
        plt.xlabel("reward")
    if i==0 or i ==2:
        plt.ylabel("RT (ms)")
plt.savefig('rewards.jpg')
#%% nicer figures mean + sd PAIRED
avg=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase", "paired"]).mean()
avg.reset_index(level=0, inplace=True)

std=result[["phase","correct", "paired", "Reward", "RT"]].groupby(["phase", "paired"]).std()
std.reset_index(level=0, inplace=True)

plt.figure(figsize=(8, 6), dpi=100)
for i in range(4):
    plt.subplot(2,2,i+1)
    dats = list(avg[avg["phase"]==phases[i]]["RT"])
    sem = np.array(list(std[std["phase"]==phases[i]]["RT"]))/np.sqrt(len(part_files))
    plt.errorbar([1,2],dats,sem, ecolor="black", c="black",linewidth=.5)
    plt.scatter([1,2],dats, marker="s", c="black")
    # plt.ylim([600,1100])
    plt.xticks([1,2], [0,1])
    lims = plt.gca().get_ylim()
    limsx = plt.gca().get_xlim()
    plt.title(phases[i])

    if i==3 or i ==2:
        plt.xlabel("paired")
    if i==0 or i ==2:
        plt.ylabel("RT (ms)")
plt.savefig('paired.jpg')

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

