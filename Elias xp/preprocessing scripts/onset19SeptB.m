
%%script reads onset times of xls converted OpenSesame log files
clear all;
%% open file
subnum = 1; %sub to analyze;
GLM = 1; %number of GLM to store .mats
path = 'D:\reward_selective_attention_elias\fMRI\log_data\xls\CRLfmri_';
file = [path int2str(subnum) '.xls'];
[numbers, strings, raw] = xlsread(file);        %Note, that 'strings' and 'raw' contain header row, but 'numbers' does not.
                                                %Therefore, when accessing 'numbers', row indices retrieved from 'raw' or strings are
                                                %subtracted by 1 
disp(['get onsets of sub' int2str(subnum)])
%% grab indices
%grab indices of vars
sel_ind = find(ismember(strings(1,:),'time_show_stim'));
base_ind = find(ismember(strings(1,:),'basetime'));
base_ind2 = find(ismember(strings(1,:),'time_Fixation_1'));
game_disp_ind = find(ismember(strings(1,:),'time_Game_Display'));
game_fb_ind = find(ismember(strings(1,:),'time_Feedback'));
phase_ind = find(ismember(strings(1,:),'phase'));
blocknr_ind = find(ismember(strings(1,:),'blocknr'));
gamenr_ind = find(ismember(strings(1,:),'gamenr'));
target_ind = find(ismember(strings(1,:),'target_dimension'));
resp_ind = find(ismember(strings(1,:),'response_time'));
condition_ind = find(ismember(strings(1,:),'condition'));
gamenum_ind = find(ismember(strings(1,:),'gamenr'));
%correct_ind = find(ismember(strings(1,:),'correct'));
acc_ind = find(ismember(strings(1,:),'acc')); 
feedback_ind = find(ismember(strings(1,:),'rect_color'));
condition_ind = find(ismember(strings(1,:),'condition'));
instrS_ind = find(ismember(strings(1,:),'time_Selection')); %indices for trash regressor
instrG_ind = find(ismember(strings(1,:),'time_Game_start'));
fb_ind = find(ismember(strings(1,:),'time_Block_FB'));
disp('grabbing indices of vars in log file')
%% GRAB ROWS OF SELECTED EVENTS
%selection and games
sel_row = find(ismember(raw(:,phase_ind),'selection'));     %array of rows in selection phase 
sel_row = sel_row(1:8:size(sel_row,1));                     %only take first rows of one active part
game_row = find(ismember(raw(:,phase_ind),'game'));         %array of rows in game phase
%blocks
block1 = find(ismember(numbers(:,blocknr_ind),0))+1;
block2 = find(ismember(numbers(:,blocknr_ind),1))+1;
block3 = find(ismember(numbers(:,blocknr_ind),2))+1;
    %games by gamenr (first vars also contain selection trials)
gamenr1 = find(ismember(numbers(:,gamenum_ind),0))+1;
gamenr2 = find(ismember(numbers(:,gamenum_ind),1))+1;
gamenr3 = find(ismember(numbers(:,gamenum_ind),2))+1;
    %without selection trials!
gamenr1 = intersect(game_row,gamenr1);
gamenr2 = intersect(game_row,gamenr2);
gamenr3 = intersect(game_row,gamenr3);
%target_dimension in game
person = find(ismember(strings(:,target_ind),'Person'));
location = find(ismember(strings(:,target_ind),'Location'));
tool = find(ismember(strings(:,target_ind),'Tool'));
%target_dimension
P = intersect(person,game_row);
L = intersect(location,game_row);
T = intersect(tool,game_row);
%baseline 
base = numbers(:,base_ind);
base_row = find(ismember(numbers(:,base_ind),15000))+1;
disp('grabbing rows of interested events')
%% FILL ONSET ARRAYS
%selection, time_show_stim, response time selection
%block 1
b1i = intersect(block1,sel_row); 
b1j = intersect(block1,base_row);
sel1 = numbers(b1i-1,sel_ind);  
base1 = numbers(b1j-1,base_ind2);  
resp_sel1 = numbers(b1i-1,resp_ind);
%block 2
b2i = intersect(block2,sel_row);
b2j = intersect(block2,base_row);
sel2 = numbers(b2i-1,sel_ind);
base2 = numbers(b2j-1,base_ind2);
resp_sel2 = numbers(b2i-1,resp_ind);
%block 3
b3i = intersect(block3,sel_row);
b3j = intersect(block3,base_row);
sel3 = numbers(b3i-1,sel_ind);
base3 = numbers(b3j-1,base_ind2);
resp_sel3 = numbers(b3i-1,resp_ind);

%game_disp and game_fb onsets for each block
%block1
gi1 = intersect(block1,game_row);
game_disp1 = numbers(gi1-1,game_disp_ind);
game_fb1 = numbers(gi1-1,game_fb_ind);
%block2
gi2 = intersect(block2,game_row);
game_disp2 = numbers(gi2-1,game_disp_ind);
game_fb2 = numbers(gi2-1,game_fb_ind);
%block3
gi3 = intersect(block3,game_row);
game_disp3 = numbers(gi3-1,game_disp_ind);
game_fb3 = numbers(gi3-1,game_fb_ind);

%rows where feedback is positive or negative
positive= find(ismember(strings(:,feedback_ind),'lightgreen'));
negative= find(ismember(strings(:,feedback_ind),'red'));
slow = find(ismember(strings(:,feedback_ind),'white'));

%Get rows for each target dimension, split up in whether positive or
%negative feedback was received
P1 = intersect(P,block1); P1p = intersect(P1,positive); P1n = intersect(P1,negative); 
P2 = intersect(P,block2); P2p = intersect(P2,positive); P2n = intersect(P2,negative);
P3 = intersect(P,block3); P3p = intersect(P3,positive); P3n = intersect(P3,negative);
%gameP_disp1 = numbers(P1-1,game_disp_ind); gameP_disp2 = numbers(P2-1,game_disp_ind); gameP_disp3 = numbers(P3-1,game_disp_ind);
gameP_fbp1 = numbers(P1p-1,game_fb_ind); gameP_fbp2 = numbers(P2p-1,game_fb_ind); gameP_fbp3 = numbers(P3p-1,game_fb_ind);
gameP_fbn1 = numbers(P1n-1,game_fb_ind); gameP_fbn2 = numbers(P2n-1,game_fb_ind); gameP_fbn3 = numbers(P3n-1,game_fb_ind);

L1 = intersect(L,block1); L1p = intersect(L1,positive); L1n = intersect(L1,negative);
L2 = intersect(L,block2); L2p = intersect(L2,positive); L2n = intersect(L2,negative);
L3 = intersect(L,block3); L3p = intersect(L3,positive); L3n = intersect(L3,negative);
%gameL_disp1 = numbers(L1-1,game_disp_ind); gameL_disp2 = numbers(L2-1,game_disp_ind); gameL_disp3 = numbers(L3-1,game_disp_ind);
gameL_fbp1 = numbers(L1p-1,game_fb_ind); gameL_fbp2 = numbers(L2p-1,game_fb_ind); gameL_fbp3 = numbers(L3p-1,game_fb_ind);
gameL_fbn1 = numbers(L1n-1,game_fb_ind); gameL_fbn2 = numbers(L2n-1,game_fb_ind); gameL_fbn3 = numbers(L3n-1,game_fb_ind);

T1 = intersect(T,block1); T1p = intersect(T1,positive); T1n = intersect(T1,negative);
T2 = intersect(T,block2); T2p = intersect(T2,positive); T2n = intersect(T2,negative);
T3 = intersect(T,block3); T3p = intersect(T3,positive); T3n = intersect(T3,negative);
%gameT_disp1 = numbers(T1-1,game_disp_ind); gameT_disp2 = numbers(T2-1,game_disp_ind); gameT_disp3 = numbers(T3-1,game_disp_ind);
gameT_fbp1 = numbers(T1p-1,game_fb_ind); gameT_fbp2 = numbers(T2p-1,game_fb_ind); gameT_fbp3 = numbers(T3p-1,game_fb_ind);
gameT_fbn1 = numbers(T1n-1,game_fb_ind); gameT_fbn2 = numbers(T2n-1,game_fb_ind); gameT_fbn3 = numbers(T3n-1,game_fb_ind);

%get timing of trigger pulses, subtract from onsets of interest and convert
%from ms to s
trigger_ind = find(ismember(strings(1,:),'time_Sequence_Loop'));
trigger1_delay = numbers(block1(1)-1,trigger_ind);
trigger2_delay = numbers(block2(1)-1,trigger_ind);
trigger3_delay = numbers(block3(1)-1,trigger_ind);

%block1
sel1 = (sel1 - trigger1_delay) / 1000; base1 = (base1 - trigger1_delay)/1000;
%gameP_disp1 = (gameP_disp1 - trigger1_delay)/1000; gameL_disp1 = (gameL_disp1 - trigger1_delay)/1000; gameT_disp1 = (gameT_disp1 - trigger1_delay)/1000;
gameP_fbp1 = (gameP_fbp1 - trigger1_delay)/1000; gameL_fbp1 = (gameL_fbp1 - trigger1_delay)/1000; gameT_fbp1 = (gameT_fbp1 - trigger1_delay)/1000;
gameP_fbn1 = (gameP_fbn1 - trigger1_delay)/1000; gameL_fbn1 = (gameL_fbn1 - trigger1_delay)/1000; gameT_fbn1 = (gameT_fbn1 - trigger1_delay)/1000;

%block2
sel2 = (sel2 - trigger2_delay) / 1000 ; base2 = (base2 - trigger2_delay)/1000;
%gameP_disp2 = (gameP_disp2 - trigger2_delay)/1000; gameL_disp2 = (gameL_disp2 - trigger2_delay)/1000; gameT_disp2 = (gameT_disp2 - trigger2_delay)/1000;
gameP_fbp2 = (gameP_fbp2 - trigger2_delay)/1000; gameL_fbp2 = (gameL_fbp2 - trigger2_delay)/1000; gameT_fbp2 = (gameT_fbp2 - trigger2_delay)/1000;
gameP_fbn2 = (gameP_fbn2 - trigger2_delay)/1000; gameL_fbn2 = (gameL_fbn2 - trigger2_delay)/1000; gameT_fbn2 = (gameT_fbn2 - trigger2_delay)/1000;

%block3
sel3 = (sel3 - trigger3_delay) / 1000 ; base3 = (base3 - trigger3_delay)/1000;
%gameP_disp3 = (gameP_disp3 - trigger3_delay)/1000; gameL_disp3 = (gameL_disp3 - trigger3_delay)/1000; gameT_disp3 = (gameT_disp3 - trigger3_delay)/1000;
gameP_fbp3 = (gameP_fbp3 - trigger3_delay)/1000; gameL_fbp3 = (gameL_fbp3 - trigger3_delay)/1000; gameT_fbp3 = (gameT_fbp3 - trigger3_delay)/1000;
gameP_fbn3 = (gameP_fbn3 - trigger3_delay)/1000; gameL_fbn3 = (gameL_fbn3 - trigger3_delay)/1000; gameT_fbn3 = (gameT_fbn3 - trigger3_delay)/1000;
disp('filling onset arrays')

%add trials without input -> fb too slow
game1 = intersect(game_row,block1); slow1 = intersect(slow,game1);
fb_slow1 = numbers(slow1-1,game_fb_ind);
fb_slow1 = (fb_slow1 - trigger1_delay) / 1000;

game2 = intersect(game_row,block2); slow2 = intersect(slow,game2);
fb_slow2 = numbers(slow2-1,game_fb_ind);
fb_slow2 = (fb_slow2 - trigger2_delay) / 1000;

game3 = intersect(game_row,block3); slow3 = intersect(slow,game3);
fb_slow3 = numbers(slow3-1,game_fb_ind);
fb_slow3 = (fb_slow3 - trigger3_delay) / 1000;

%%onsets for congruent incongruent game display
congruent_row = find(ismember(raw(:,condition_ind),'congruent'));
incongruent_row = find(ismember(raw(:,condition_ind),'incongruent'));

%intersect block
cb1 = intersect(block1,congruent_row);
cb2 = intersect(block2,congruent_row);
cb3 = intersect(block3,congruent_row);
icb1 = intersect(block1,incongruent_row);
icb2 = intersect(block2,incongruent_row);
icb3 = intersect(block3,incongruent_row);

%Onsets
congruent1_ons = (numbers(cb1-1,game_disp_ind)-trigger1_delay)/1000;
congruent2_ons = (numbers(cb2-1,game_disp_ind)-trigger2_delay)/1000;
congruent3_ons = (numbers(cb3-1,game_disp_ind)-trigger3_delay)/1000;
incongruent1_ons = (numbers(icb1-1,game_disp_ind)-trigger1_delay)/1000;
incongruent2_ons = (numbers(icb2-1,game_disp_ind)-trigger2_delay)/1000;
incongruent3_ons = (numbers(icb3-1,game_disp_ind)-trigger3_delay)/1000;

%Durations
congruent1_dur = (numbers(cb1-1,resp_ind)-100)/1000;
congruent2_dur = (numbers(cb2-1,resp_ind)-100)/1000;
congruent3_dur = (numbers(cb3-1,resp_ind)-100)/1000;
incongruent1_dur = (numbers(icb1-1,resp_ind)-100)/1000;
incongruent2_dur = (numbers(icb2-1,resp_ind)-100)/1000;
incongruent3_dur = (numbers(icb3-1,resp_ind)-100)/1000;

%%ONSETS of congruent v incongruent feedback (pos and neg)
%%events for congruent v incongruent POSITIVE Feedback
c_pos_b1 = intersect(cb1,positive); c_pos_b2 = intersect(cb2,positive); c_pos_b3 = intersect(cb3,positive);
ic_pos_b1 = intersect(icb1,positive); ic_pos_b2 = intersect(icb2,positive); ic_pos_b3 = intersect(icb3,positive);
%%events for congruent v incongruent NEGATIVE Feedback
c_neg_b1 = intersect(cb1,negative); c_neg_b2 = intersect(cb2,negative); c_neg_b3 = intersect(cb3,negative);
ic_neg_b1 = intersect(icb1,negative); ic_neg_b2 = intersect(icb2,negative); ic_neg_b3 = intersect(icb3,negative);

%Onsets for C v IC Positive Feedback
con_fbpos1_ons = (numbers(c_pos_b1-1,game_fb_ind)-trigger1_delay)/1000;
con_fbpos2_ons = (numbers(c_pos_b2-1,game_fb_ind)-trigger2_delay)/1000;
con_fbpos3_ons = (numbers(c_pos_b3-1,game_fb_ind)-trigger3_delay)/1000;
icon_fbpos1_ons = (numbers(ic_pos_b1-1,game_fb_ind)-trigger1_delay)/1000;
icon_fbpos2_ons = (numbers(ic_pos_b2-1,game_fb_ind)-trigger2_delay)/1000;
icon_fbpos3_ons = (numbers(ic_pos_b3-1,game_fb_ind)-trigger3_delay)/1000;

%Onsets for C v IC Negative Feedback
con_fbneg1_ons = (numbers(c_neg_b1-1,game_fb_ind)-trigger1_delay)/1000;
con_fbneg2_ons = (numbers(c_neg_b2-1,game_fb_ind)-trigger2_delay)/1000;
con_fbneg3_ons = (numbers(c_neg_b3-1,game_fb_ind)-trigger3_delay)/1000;
icon_fbneg1_ons = (numbers(ic_neg_b1-1,game_fb_ind)-trigger1_delay)/1000;
icon_fbneg2_ons = (numbers(ic_neg_b2-1,game_fb_ind)-trigger2_delay)/1000;
icon_fbneg3_ons = (numbers(ic_neg_b3-1,game_fb_ind)-trigger3_delay)/1000;

%Durations for C v IC Pos and Neg FB
con_fbpos1_dur = 0.7; con_fbneg1_dur = 0.7; 
con_fbpos2_dur = 0.7; con_fbneg2_dur = 0.7;
con_fbpos3_dur = 0.7; con_fbneg3_dur = 0.7;
icon_fbpos1_dur = 0.7; icon_fbneg1_dur = 0.7;
icon_fbpos2_dur = 0.7; icon_fbneg2_dur = 0.7;
icon_fbpos3_dur = 0.7; icon_fbneg3_dur = 0.7;

%% FILL DURATION ARRAYS
%durations for show stim in selection per block of 4 stim presentations
dur_sel1 = 12.8*ones(size(sel1));                               %dur_sel1 = (resp_sel1)/1000;
dur_sel2 = 12.8*ones(size(sel2));                               %dur_sel2 = (resp_sel2)/1000;
dur_sel3 = 12.8*ones(size(sel3));                               %dur_sel3 = (resp_sel3)/1000;
dur_base1 = 16.* ones(size(base1));
dur_base2 = 16.* ones(size(base2));
dur_base3 = 16.* ones(size(base3));

%durations for game_display --> RTs of individual trial, else 2000ms
%dur_gameP_disp1 = (numbers(P1-1,resp_ind)-100)/1000; dur_gameP_disp2 = (numbers(P2-1,resp_ind)-100)/1000; dur_gameP_disp3 = (numbers(P3-1,resp_ind)-100)/1000;
%dur_gameL_disp1 = (numbers(L1-1,resp_ind)-100)/1000; dur_gameL_disp2 = (numbers(L2-1,resp_ind)-100)/1000; dur_gameL_disp3 = (numbers(L3-1,resp_ind)-100)/1000;
%dur_gameT_disp1 = (numbers(T1-1,resp_ind)-100)/1000; dur_gameT_disp2 = (numbers(T2-1,resp_ind)-100)/1000; dur_gameT_disp3 = (numbers(T3-1,resp_ind)-100)/1000;
%durations for feedback screen (700ms)
dur_gameP_fbp1 = 0.7.* ones(size(gameP_fbp1)); dur_gameP_fbn1 = 0.7.* ones(size(gameP_fbn1)); dur_gameP_fbp2 = 0.7.* ones(size(gameP_fbp2)); dur_gameP_fbn2 = 0.7.* ones(size(gameP_fbn2)); 
dur_gameP_fbp3 = 0.7.* ones(size(gameP_fbp3)); dur_gameP_fbn3 = 0.7.* ones(size(gameP_fbn3)); dur_gameL_fbp1 = 0.7.* ones(size(gameL_fbp1)); dur_gameL_fbn1 = 0.7.* ones(size(gameL_fbn1));
dur_gameL_fbp2 = 0.7.* ones(size(gameL_fbp2)); dur_gameL_fbn2 = 0.7.* ones(size(gameL_fbn2)); dur_gameL_fbp3 = 0.7.* ones(size(gameL_fbp3)); dur_gameL_fbn3 = 0.7.* ones(size(gameL_fbn3));
dur_gameT_fbp1 = 0.7.* ones(size(gameT_fbp1)); dur_gameT_fbn1 = 0.7.* ones(size(gameT_fbn1)); dur_gameT_fbp2 = 0.7.* ones(size(gameT_fbp2)); dur_gameT_fbn2 = 0.7.* ones(size(gameT_fbn2));
dur_gameT_fbp3 = 0.7.* ones(size(gameT_fbp3)); dur_gameT_fbn3 = 0.7.* ones(size(gameT_fbn3));

dur_fb_slow1 = 0.7.* ones(size(fb_slow1));
dur_fb_slow2 = 0.7.* ones(size(fb_slow2));
dur_fb_slow3 = 0.7.* ones(size(fb_slow3));
disp('filling duration arrays')

%% feedback too slow
sizes = [size(fb_slow1,1),size(fb_slow2,1),size(fb_slow3,1)];
M = max(sizes);
diff = M - size(fb_slow1,1);
if size(fb_slow1,1) == 0
    fb_slow1(1:diff) = 0;
    dur_fb_slow1(1:diff) = 0;
elseif size(fb_slow1,1) < M & size(fb_slow1,1) > 0
    fb_slow1(end+diff) = 0;
    dur_fb_slow1(end+diff) = 0;
end
diff = M - size(fb_slow2,1);
if size(fb_slow2,1) == 0
    fb_slow2(1:diff) = 0;
    dur_fb_slow2(1:diff) = 0;
elseif size(fb_slow2,1) < M & size(fb_slow2,1) > 0
    fb_slow2(end+diff) = 0;
    dur_fb_slow2(end+diff) = 0;
end
diff = M - size(fb_slow3,1);
if size(fb_slow3,1) == 0
    fb_slow3(1:diff) = 0;
    dur_fb_slow3(1:diff) = 0;
elseif size(fb_slow3,1) < M & size(fb_slow3,1) > 0
    fb_slow3(end+diff) = 0;
    dur_fb_slow3(end+diff) = 0;
end

%% PMOD FOR CONGRUENT V INCONGRUENT GAMES

%find incongruent games 1 and 2 for each block
for k = 2:size(icb1);
    if icb1(k) - icb1(k-1) > 1;
    a = k -1;
    end
end

ic1b1 = icb1(1:a); ic2b1 = icb1(a+1:end);

for k = 2:size(icb2);
    if icb2(k) - icb2(k-1) > 1;
    a = k -1;
    end
end

ic1b2 = icb2(1:a); ic2b2 = icb2(a+1:end);

for k = 2:size(icb3);
    if icb3(k) - icb3(k-1) > 1;
    a = k -1;
    end
end

ic1b3 = icb3(1:a); ic2b3 = icb3(a+1:end);

%get acc values for created game arrays (con % icon)
cb1cor = numbers(cb1-1,acc_ind); cb2cor = numbers(cb2-1,acc_ind); cb3cor = numbers(cb3-1,acc_ind);

ic1b1cor = numbers(ic1b1-1,acc_ind); ic2b1cor = numbers(ic2b1-1,acc_ind);
ic1b2cor = numbers(ic1b2-1,acc_ind); ic2b2cor = numbers(ic2b2-1,acc_ind);
ic1b3cor = numbers(ic1b3-1,acc_ind); ic2b3cor = numbers(ic2b3-1,acc_ind);

b1pmod_cic = {cb1cor ic1b1cor ic2b1cor}; b2pmod_cic = {cb2cor ic1b2cor ic2b2cor}; b3pmod_cic = {cb3cor ic1b3cor ic2b3cor};

% pmod2 for conditions in block 1
for it = 1:3
    for game = b1pmod_cic{it}
        for tr = 1:size(game)
            if tr == 1
                pmod2_1{it}(tr) = game(tr);
            elseif tr > 1 & tr < size(game,1)
                pmod2_1{it}(tr) = (game(tr-1)+game(tr)+game(tr+1))/3;
            elseif tr == size(game,1)
                pmod2_1{it}(tr) = (game(tr-1)+game(tr))/2;
            end
        end
    end
end

% pmod2 for conditions in block 2
for it = 1:3
    for game = b2pmod_cic{it}
        for tr = 1:size(game)
            if tr == 1
                pmod2_2{it}(tr) = game(tr);
            elseif tr > 1 & tr < size(game,1)
                pmod2_2{it}(tr) = (game(tr-1)+game(tr)+game(tr+1))/3;
            elseif tr == size(game,1)
                pmod2_2{it}(tr) = (game(tr-1)+game(tr))/2;
            end
        end
    end
end

% pmod2 for conditions in block 3
for it = 1:3
    for game = b3pmod_cic{it}
        for tr = 1:size(game)
            if tr == 1
                pmod2_3{it}(tr) = game(tr);
            elseif tr > 1 & tr < size(game,1)
                pmod2_3{it}(tr) = (game(tr-1)+game(tr)+game(tr+1))/3;
            elseif tr == size(game,1)
                pmod2_3{it}(tr) = (game(tr-1)+game(tr))/2;
            end
        end
    end
end

%concat incongruent arrays (for game1 and game2 per block) into one per block
pmod2_1{2} = [pmod2_1{2} pmod2_1{3}]; pmod2_1(end) = [];
pmod2_2{2} = [pmod2_2{2} pmod2_2{3}]; pmod2_2(end) = [];
pmod2_3{2} = [pmod2_3{2} pmod2_3{3}]; pmod2_3(end) = [];

%pmod2 structure
%block1 structure
pmod2_b1 = struct('name',{},'param',{},'poly',{}); 
pmod2_b1(1).name{1} = 'CON%correct';     pmod2_b1(2).name{1} = 'ICON%correct';
pmod2_b1(1).param{1} = pmod2_1{1}'; pmod2_b1(2).param{1} = pmod2_1{2}';
pmod2_b1(1).poly{1} = ones(size(pmod2_b1(1).param{1})); pmod2_b1(2).poly{1} = ones(size(pmod2_b1(2).param{1})); 

%block2 structure
pmod2_b2 = struct('name',{},'param',{},'poly',{}); 
pmod2_b2(1).name{1} = 'CON%correct';     pmod2_b2(2).name{1} = 'ICON%correct';
pmod2_b2(1).param{1} = pmod2_2{1}'; pmod2_b2(2).param{1} = pmod2_2{2}';
pmod2_b2(1).poly{1} = ones(size(pmod2_b2(1).param{1})); pmod2_b2(2).poly{1} = ones(size(pmod2_b2(2).param{1})); 

%block3 structure
pmod2_b3 = struct('name',{},'param',{},'poly',{}); 
pmod2_b3(1).name{1} = 'CON%correct';     pmod2_b3(2).name{1} = 'ICON%correct';
pmod2_b3(1).param{1} = pmod2_3{1}'; pmod2_b3(2).param{1} = pmod2_3{2}';
pmod2_b3(1).poly{1} = ones(size(pmod2_b3(1).param{1})); pmod2_b3(2).poly{1} = ones(size(pmod2_b3(2).param{1}));

disp('calculating %correct pmod2')

%% TRASH REGRESSOR

%game instructions
a = [P1(1),L1(1),T1(1),P2(1),L2(1),T2(1),P3(1),L3(1),T3(1)];

for k = 1:size(a,2)
    game_start(k) = numbers(a(k)-1,instrG_ind);
end

for k = 1:9
    if k <= 3
        game_start(k) = (game_start(k)-trigger1_delay) /1000;
    elseif k <= 6
        game_start(k) = (game_start(k)-trigger2_delay) /1000;
    elseif k <= 9
        game_start(k) = (game_start(k)-trigger3_delay) /1000;
    end
end

trashgame1 = game_start(:,1:3); %contains onsets for game instructions for each block
trashgame2 = game_start(:,4:6);
trashgame3 = game_start(:,7:9);

%selection instructions
sel_begin = sel_row(1:4:end,1);

for k = 1:size(sel_begin,1)
    sel_start(k) = numbers(sel_begin(k)-1,instrS_ind);
end

for k = 1:size(sel_begin,1)
    if k <= 3
        sel_start(k) = (sel_start(k) - trigger1_delay) / 1000;
    elseif k <= 6
        sel_start(k) = (sel_start(k) - trigger2_delay) / 1000;
    elseif k <= 9
        sel_start(k) = (sel_start(k) - trigger3_delay) / 1000;
    end
end

trashsel1 = sel_start(:,1:3); %contains onset for selection instructions for each block
trashsel2 = sel_start(:,4:6);
trashsel3 = sel_start(:,7:9);

%feedback screen %MAYBE EXCLUDE?
%%(Erstes Mal am Ende des 1. Blocks)
fb_rows = [gi1(end,:)+1,gi2(end,:)+1];

fb1_time = ((numbers(fb_rows(1)-1,fb_ind)) - trigger1_delay) / 1000;
fb2_time = ((numbers(fb_rows(2)-1,fb_ind)) - trigger2_delay) / 1000;
fb3_time = ((numbers(fb_rows(2)-1,fb_ind)) - trigger2_delay) / 1000;

trashfb1 = fb1_time;
trashfb2 = fb2_time;
trashfb3 = fb3_time;

%Sum selection and game instructions per block into one array
trash1 = [trashsel1 trashgame1]; trash1 = sort(trash1);
trash2 = [trashsel2 trashgame2]; trash2 = sort(trash2);
trash3 = [trashsel3 trashgame3]; trash3 = sort(trash3);

%Create TRASH REG
trashnames = {'Instructions'}; %can add block fb ,'Block_FB'

dur_Instr = [4.2 7 7 7 7 7]';
dur_FB = 7.* ones(1);

trashmod1 = {trash1'}; %,trashfb1'
trashmod2 = {trash2'}; %,trashfb2'
trashmod3 = {trash3'}; %ADD WHEN FB AT END WORKS!!!

%block1
field1 = trashnames{1}; value1 = trashmod1{1};
%field2 = trashnames{2}; value2 = trashmod1{2};
trashreg1 = struct(field1,value1); %,field2,value2
%block2
field1 = trashnames{1}; value1 = trashmod2{1};
%field2 = trashnames{2}; value2 = trashmod2{2};
trashreg2 = struct(field1,value1); %,field2,value2)
%block3
field1 = trashnames{1}; value1 = trashmod3{1};
%field2 = trashnames{2}; value2 = trashmod3{2};
trashreg3 = struct(field1,value1);

disp('get trash regressor for instructions')
%% READ GameOrder

conditions = strings(game_row,condition_ind); %condition for each game trial
con = find(ismember(strings(:,condition_ind),'congruent'));
icon = find(ismember(strings(:,condition_ind),'incongruent'));

first_con = []; %collects rows of first trials of game by condition
first_icon = [];

for k = 1:size(con,1)-1
    if k == 1
        first_con(end+1) = con(k);
    elseif con(k+1) - con(k) ~= 1
        first_con(end+1) = con(k+1);
    end
end

for k = 1:size(icon,1)-1
    if k == 1
        first_icon(end+1) = icon(k);
    elseif icon(k+1) - icon(k) ~= 1
        first_icon(end+1) = icon(k+1);
    end
end

first_games = [first_con first_icon];
first_games = sort(first_games);

%contains order of conditions!
order = strings(first_games,condition_ind);
order_block1 = order(1:3,1);
order_block2 = order(4:6,1);
order_block3 = order(7:9,1);

if subnum < 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' num2str(subnum) '\onsets']);
elseif subnum > 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' num2str(subnum) '\onsets']);
end

if subnum < 10
    save(['sub00' int2str(subnum) '_game_order'],'order');
elseif subnum >= 10
    save(['sub0' int2str(subnum) '_game_order'],'order');
end

disp('retrieve order of congruent vs incongruent games')

%% Check if all regs have onsets
allonsarrays = {congruent1_ons,incongruent1_ons,con_fbpos1_ons,con_fbneg1_ons,icon_fbpos1_ons,icon_fbneg1_ons,fb_slow1,sel1,base1,trash1',congruent2_ons,incongruent2_ons,con_fbpos2_ons,con_fbneg2_ons,icon_fbpos2_ons,icon_fbneg2_ons,fb_slow2,sel2,base2,trash2',congruent3_ons,incongruent3_ons,con_fbpos3_ons,con_fbneg3_ons,icon_fbpos3_ons,icon_fbneg3_ons,fb_slow3,sel3,base3,trash3'};
for k = 1:size(allonsarrays,2)
    if isempty(allonsarrays{k})
        disp('at least one is empty');
    end
end

%% OUTPUT
if subnum <= 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' num2str(subnum) '\onsets']);
elseif subnum > 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' num2str(subnum) '\onsets']);
end

%create output matrices 
%run1
names = {'ConChoice','Icon_Choice','ConFBpos','ConFBneg','IconFBpos','IconFBneg','gameFBslow','sel','base_sel','Instructions'};
onsets = {congruent1_ons,incongruent1_ons,con_fbpos1_ons,con_fbneg1_ons,icon_fbpos1_ons,icon_fbneg1_ons,fb_slow1,sel1,base1,trash1'};
durations = {congruent1_dur,incongruent1_dur,con_fbpos1_dur,con_fbneg1_dur,icon_fbpos1_dur,icon_fbneg1_dur,dur_fb_slow1,dur_sel1,dur_base1,dur_Instr};
%pmod = pmod1;
pmod = pmod2_b1;

save(['GLM' int2str(GLM) '_run1'],'names','onsets','durations','pmod');


%run2
names = {'ConChoice','IconChoice','ConFBpos','ConFBneg','IconFBpos','IconFBneg','gameFBslow','sel','base_sel','Instructions'};
onsets = {congruent2_ons,incongruent2_ons,con_fbpos2_ons,con_fbneg2_ons,icon_fbpos2_ons,icon_fbneg2_ons,fb_slow2,sel2,base2,trash2'};
durations = {congruent2_dur,incongruent2_dur,con_fbpos2_dur,con_fbneg2_dur,icon_fbpos2_dur,icon_fbneg2_dur,dur_fb_slow2,dur_sel2,dur_base2,dur_Instr};
%pmod = pmod2;
pmod = pmod2_b2;

save(['GLM' int2str(GLM) '_run2'],'names','onsets','durations','pmod');

%run3
names = {'ConChoice','IconChoice','ConFBpos','ConFBneg','IconFBpos','IconFBneg','gameFBslow','sel','base_sel','Instructions'};
onsets = {congruent3_ons,incongruent3_ons,con_fbpos3_ons,con_fbneg3_ons,icon_fbpos3_ons,icon_fbneg3_ons,fb_slow3,sel3,base3,trash3'};
durations = {congruent3_dur,incongruent3_dur,con_fbpos3_dur,con_fbneg3_dur,icon_fbpos3_dur,icon_fbneg3_dur,dur_fb_slow3,dur_sel3,dur_base3,dur_Instr};
%pmod = pmod3;
pmod = pmod2_b3;

save(['GLM' int2str(GLM) '_run3'],'names','onsets','durations','pmod');

disp('COMPLETE')
