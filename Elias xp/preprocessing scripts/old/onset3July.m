%%script reads onset times of xls converted OpenSesame log files
clear all;
%% open file
subnum = 1; %sub to analyze;
path = 'C:\Users\Elias\Desktop\fMRI\log_data\xls\CRLfmri_';
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
correct_ind = find(ismember(strings(1,:),'correct'));
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
gameP_disp1 = numbers(P1-1,game_disp_ind); gameP_disp2 = numbers(P2-1,game_disp_ind); gameP_disp3 = numbers(P3-1,game_disp_ind);
gameP_fbp1 = numbers(P1p-1,game_fb_ind); gameP_fbp2 = numbers(P2p-1,game_fb_ind); gameP_fbp3 = numbers(P3p-1,game_fb_ind);
gameP_fbn1 = numbers(P1n-1,game_fb_ind); gameP_fbn2 = numbers(P2n-1,game_fb_ind); gameP_fbn3 = numbers(P3n-1,game_fb_ind);

L1 = intersect(L,block1); L1p = intersect(L1,positive); L1n = intersect(L1,negative);
L2 = intersect(L,block2); L2p = intersect(L2,positive); L2n = intersect(L2,negative);
L3 = intersect(L,block3); L3p = intersect(L3,positive); L3n = intersect(L3,negative);
gameL_disp1 = numbers(L1-1,game_disp_ind); gameL_disp2 = numbers(L2-1,game_disp_ind); gameL_disp3 = numbers(L3-1,game_disp_ind);
gameL_fbp1 = numbers(L1p-1,game_fb_ind); gameL_fbp2 = numbers(L2p-1,game_fb_ind); gameL_fbp3 = numbers(L3p-1,game_fb_ind);
gameL_fbn1 = numbers(L1n-1,game_fb_ind); gameL_fbn2 = numbers(L2n-1,game_fb_ind); gameL_fbn3 = numbers(L3n-1,game_fb_ind);

T1 = intersect(T,block1); T1p = intersect(T1,positive); T1n = intersect(T1,negative);
T2 = intersect(T,block2); T2p = intersect(T2,positive); T2n = intersect(T2,negative);
T3 = intersect(T,block3); T3p = intersect(T3,positive); T3n = intersect(T3,negative);
gameT_disp1 = numbers(T1-1,game_disp_ind); gameT_disp2 = numbers(T2-1,game_disp_ind); gameT_disp3 = numbers(T3-1,game_disp_ind);
gameT_fbp1 = numbers(T1p-1,game_fb_ind); gameT_fbp2 = numbers(T2p-1,game_fb_ind); gameT_fbp3 = numbers(T3p-1,game_fb_ind);
gameT_fbn1 = numbers(T1n-1,game_fb_ind); gameT_fbn2 = numbers(T2n-1,game_fb_ind); gameT_fbn3 = numbers(T3n-1,game_fb_ind);

%get timing of trigger pulses, subtract from onsets of interest and convert
%from ms to s
trigger_ind = find(ismember(strings(1,:),'time_Sequence_Loop'));
trigger1_delay = numbers(block1(1)-1,trigger_ind);
trigger2_delay = numbers(block2(1)-1,trigger_ind);
trigger3_delay = numbers(block3(1)-1,trigger_ind);

%block1
sel1 = (sel1 - trigger1_delay) / 1000 ; base1 = (base1 - trigger1_delay)/1000;
gameP_disp1 = (gameP_disp1 - trigger1_delay)/1000; gameL_disp1 = (gameL_disp1 - trigger1_delay)/1000; gameT_disp1 = (gameT_disp1 - trigger1_delay)/1000;
gameP_fbp1 = (gameP_fbp1 - trigger1_delay)/1000; gameL_fbp1 = (gameL_fbp1 - trigger1_delay)/1000; gameT_fbp1 = (gameT_fbp1 - trigger1_delay)/1000;
gameP_fbn1 = (gameP_fbn1 - trigger1_delay)/1000; gameL_fbn1 = (gameL_fbn1 - trigger1_delay)/1000; gameT_fbn1 = (gameT_fbn1 - trigger1_delay)/1000;

%block2
sel2 = (sel2 - trigger2_delay) / 1000 ; base2 = (base2 - trigger2_delay)/1000;
gameP_disp2 = (gameP_disp2 - trigger2_delay)/1000; gameL_disp2 = (gameL_disp2 - trigger2_delay)/1000; gameT_disp2 = (gameT_disp2 - trigger2_delay)/1000;
gameP_fbp2 = (gameP_fbp2 - trigger2_delay)/1000; gameL_fbp2 = (gameL_fbp2 - trigger2_delay)/1000; gameT_fbp2 = (gameT_fbp2 - trigger2_delay)/1000;
gameP_fbn2 = (gameP_fbn2 - trigger2_delay)/1000; gameL_fbn2 = (gameL_fbn2 - trigger2_delay)/1000; gameT_fbn2 = (gameT_fbn2 - trigger2_delay)/1000;

%block3
sel3 = (sel3 - trigger3_delay) / 1000 ; base3 = (base3 - trigger3_delay)/1000;
gameP_disp3 = (gameP_disp3 - trigger3_delay)/1000; gameL_disp3 = (gameL_disp3 - trigger3_delay)/1000; gameT_disp3 = (gameT_disp3 - trigger3_delay)/1000;
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

%% FILL DURATION ARRAYS
%durations for show stim in selection per block of 4 stim presentations
dur_sel1 = 12.8*ones(size(sel1));                               %dur_sel1 = (resp_sel1)/1000;
dur_sel2 = 12.8*ones(size(sel2));                               %dur_sel2 = (resp_sel2)/1000;
dur_sel3 = 12.8*ones(size(sel3));                               %dur_sel3 = (resp_sel3)/1000;
dur_base1 = 16.* ones(size(base1));
dur_base2 = 16.* ones(size(base2));
dur_base3 = 16.* ones(size(base3));

%durations for game_display --> RTs of individual trial, else 2000ms
dur_gameP_disp1 = numbers(P1-1,resp_ind)/1000; dur_gameP_disp2 = numbers(P2-1,resp_ind)/1000; dur_gameP_disp3 = numbers(P3-1,resp_ind)/1000;
dur_gameL_disp1 = numbers(L1-1,resp_ind)/1000; dur_gameL_disp2 = numbers(L2-1,resp_ind)/1000; dur_gameL_disp3 = numbers(L3-1,resp_ind)/1000;
dur_gameT_disp1 = numbers(T1-1,resp_ind)/1000; dur_gameT_disp2 = numbers(T2-1,resp_ind)/1000; dur_gameT_disp3 = numbers(T3-1,resp_ind)/1000;
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

%% Check for equal matrix sizes
%onsets and durations
%block1
if size(gameP_disp1,1) < 20
    gameP_disp1(end:20) = 0;
    dur_gameP_disp1(end:20) = 0;
end
if size(gameL_disp1,1) < 20
    gameL_disp1(end:20) = 0;
    dur_gameL_disp1(end:20) = 0;
end
if size(gameT_disp1,1) < 20
    gameT_disp1(end:20) = 0;
    dur_gameT_disp1(end:20) = 0;
end

%block2
if size(gameP_disp2,1) < 20
    gameP_disp2(end:20) = 0;
    dur_gameP_disp2(end:20) = 0;
end
if size(gameL_disp2,1) < 20
    gameL_disp2(end:20) = 0;
    dur_gameL_disp2(end:20) = 0;
end
if size(gameT_disp2,1) < 20
    gameT_disp2(end:20) = 0;
    dur_gameT_disp2(end:20) = 0;
end

%block3
if size(gameP_disp3,1) < 20
    gameP_disp3(end:20) = 0;
    dur_gameP_disp3(end:20) = 0;
end
if size(gameL_disp3,1) < 20
    gameL_disp3(end:20) = 0;
    dur_gameL_disp3(end:20) = 0;
end
if size(gameT_disp3,1) < 20
    gameT_disp3(end:20) = 0;
    dur_gameT_disp3(end:20) = 0;
end

%feedback too slow
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

%% PMOD
% %correct of 3 trials
acc_ind = find(ismember(strings(1,:),'acc')); %% ACC Index --> Change with new data files!!!! (done)
P1cor = numbers(P1-1,correct_ind); P2cor = numbers(P2-1,correct_ind); P3cor = numbers(P3-1,correct_ind);
L1cor = numbers(L1-1,correct_ind); L2cor = numbers(L2-1,correct_ind); L3cor = numbers(L3-1,correct_ind);
T1cor = numbers(T1-1,correct_ind); T2cor = numbers(T2-1,correct_ind); T3cor = numbers(T3-1,correct_ind);

b1cor = {P1cor L1cor T1cor}; b2cor = {P2cor L2cor T2cor}; b3cor = {P3cor L3cor T3cor};

% pmod for block 1
for it = 1:3
    for game = b1cor{it}
        for tr = 1:size(game)
            if tr == 1
                pmod1{it}(tr) = game(tr);
            elseif tr > 1 & tr < size(game,1)
                pmod1{it}(tr) = (game(tr-1)+game(tr)+game(tr+1))/3;
            elseif tr == size(game,1)
                pmod1{it}(tr) = (game(tr-1)+game(tr))/2;
            end
        end
    end
end

%pmod for block 2
for it = 1:3
    for game = b2cor{it}
        for tr = 1:size(game)
            if tr == 1
                pmod2{it}(tr) = game(tr);
            elseif tr > 1 & tr < size(game,1)
                pmod2{it}(tr) = (game(tr-1)+game(tr)+game(tr+1))/3;
            elseif tr == size(game,1)
                pmod2{it}(tr) = (game(tr-1)+game(tr))/2;
            end
        end
    end
end

%pmod for block 3
for it = 1:3
    for game = b3cor{it}
        for tr = 1:size(game)
            if tr == 1
                pmod3{it}(tr) = game(tr);
            elseif tr > 1 & tr < size(game,1)
                pmod3{it}(tr) = (game(tr-1)+game(tr)+game(tr+1))/3;
            elseif tr == size(game,1)
                pmod3{it}(tr) = (game(tr-1)+game(tr))/2;
            end
        end
    end
end

%pmod structure
%define arrays for pmod per condition per block
pmodP1 = pmod1{1}'; pmodL1 = pmod1{2}'; pmodT1 = pmod1{3}';
pmodP2 = pmod2{1}'; pmodL2 = pmod2{2}'; pmodT2 = pmod2{3}';
pmodP3 = pmod3{1}'; pmodL3 = pmod3{2}'; pmodT3 = pmod3{3}';

pmods1 = {pmodP1,pmodL1,pmodT1};
pmods2 = {pmodP2,pmodL2,pmodT2};
pmods3 = {pmodP3,pmodL3,pmodT3};

%block1 structure
pmod1 = struct('name',{},'param',{},'poly',{}); 
pmod1(1).name{1} = 'correctP';
pmod1(1).param{1} = pmods1{1};
pmod1(1).poly{1,1} = ones(size(pmod1(1).param{1}));
pmod1(1).name{2} = 'correctL';
pmod1(1).param{2} = pmods1{2};
pmod1(1).poly{1,2} = ones(size(pmod1(1).param{2}));
pmod1(1).name{3} = 'correctT';
pmod1(1).param{3} = pmods1{3};
pmod1(1).poly{1,3} = ones(size(pmod1(1).param{3}));

%block2 structure
pmod2 = struct('name',{},'param',{},'poly',{}); 
pmod2(1).name{1} = 'correctP';
pmod2(1).param{1} = pmods2{1};
pmod2(1).poly{1,1} = ones(size(pmod2(1).param{1}));
pmod2(1).name{2} = 'correctL';
pmod2(1).param{2} = pmods2{2};
pmod2(1).poly{1,2} = ones(size(pmod2(1).param{2}));
pmod2(1).name{3} = 'correctT';
pmod2(1).param{3} = pmods2{3};
pmod2(1).poly{1,3} = ones(size(pmod2(1).param{3}));

%block3 structure
pmod3 = struct('name',{},'param',{},'poly',{}); 
pmod3(1).name{1} = 'correctP';
pmod3(1).param{1} = pmods3{1};
pmod3(1).poly{1,1} = ones(size(pmod3(1).param{1}));
pmod3(1).name{2} = 'correctL';
pmod3(1).param{2} = pmods3{2};
pmod3(1).poly{1,2} = ones(size(pmod3(1).param{2}));
pmod3(1).name{3} = 'correctT';
pmod3(1).param{3} = pmods3{3};
pmod3(1).poly{1,3} = ones(size(pmod3(1).param{3}));
disp('calculating %correct pmod')

%create pmods of equal matrix sizes
for k = 1:3
    if size(pmod1.param{k},1) < 20
        s = size(pmod1.param{k},1);
        diff = 20 - s;
        pmod1.param{k}(end+diff) = 0;
        pmod1.poly{k}(end+diff) = 0;
    end
end

for k = 1:3
    if size(pmod2.param{k},1) < 20
        s = size(pmod2.param{k},1);
        diff = 20 - s;
        pmod2.param{k}(end+diff) = 0;
        pmod2.poly{k}(end+diff) = 0;
    end
end

for k = 1:3
    if size(pmod3.param{k},1) < 20
        s = size(pmod3.param{k},1);
        diff = 20 - s;
        pmod3.param{k}(end+diff) = 0;
        pmod3.poly{k}(end+diff) = 0;
    end
end

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

%Create TRASH PMOD
trashnames = {'Instructions'}; %can add block fb ,'Block_FB'

dur_Instr = [7 7 7 7 7 7]';
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

save([int2str(subnum) '_game_order'],'order');

disp('retrieve order of congruent vs incongruent games')
%% OUTPUT
cd 'C:\Users\Elias\Desktop\fMRI\log_data\onsets'

%create output matrices 
%block1
names = {'Pchoice','Lchoice','Tchoice','Pfbpos','Pfbneg','Lfbpos','Lfbneg','Tfbpos','Tfbneg','gameFBslow','sel','base_sel','Instructions'};
onsets = {gameP_disp1,gameL_disp1,gameT_disp1,gameP_fbp1,gameP_fbn1,gameL_fbp1,gameL_fbn1,gameT_fbp1,gameT_fbn1,fb_slow1,sel1,base1,trash1'};
durations = {dur_gameP_disp1,dur_gameL_disp1,dur_gameT_disp1,dur_gameP_fbp1,dur_gameP_fbn1,dur_gameL_fbp1,dur_gameL_fbn1,dur_gameT_fbp1,dur_gameT_fbn1,dur_fb_slow1,dur_sel1,dur_base1,dur_Instr};
pmod = pmod1;
if subnum < 10
    save(['00' int2str(subnum) '_block1'],'names','onsets','durations','pmod')
elseif subnum > 10
    save(['0' int2str(subnum) '_block1'],'names','onsets','durations','pmod')
end

%block2
names = {'Pchoice','Lchoice','Tchoice','Pfbpos','Pfbneg','Lfbpos','Lfbneg','Tfbpos','Tfbneg','gameFBslow','sel','base_sel','Instructions'};
onsets = {gameP_disp2,gameL_disp2,gameT_disp2,gameP_fbp2,gameP_fbn2,gameL_fbp2,gameL_fbn2,gameT_fbp2,gameT_fbn2,fb_slow2,sel2,base2,trash2'};
durations = {dur_gameP_disp2,dur_gameL_disp2,dur_gameT_disp2,dur_gameP_fbp2,dur_gameP_fbn2,dur_gameL_fbp2,dur_gameL_fbn2,dur_gameT_fbp2,dur_gameT_fbn2,dur_fb_slow2,dur_sel2,dur_base2,dur_Instr};
pmod = pmod2;
if subnum < 10
    save(['00' int2str(subnum) '_block2'],'names','onsets','durations','pmod')
elseif subnum > 10
    save(['0' int2str(subnum) '_block2'],'names','onsets','durations','pmod')
end

%block3
names = {'Pchoice','Lchoice','Tchoice','Pfbpos','Pfbneg','Lfbpos','Lfbneg','Tfbpos','Tfbneg','gameFBslow','sel','base_sel','Instructions'};
onsets = {gameP_disp3,gameL_disp3,gameT_disp3,gameP_fbp3,gameP_fbn3,gameL_fbp3,gameL_fbn3,gameT_fbp3,gameT_fbn3,fb_slow3,sel3,base3,trash3'};
durations = {dur_gameP_disp3,dur_gameL_disp3,dur_gameT_disp3,dur_gameP_fbp3,dur_gameP_fbn3,dur_gameL_fbp3,dur_gameL_fbn3,dur_gameT_fbp3,dur_gameT_fbn3,dur_fb_slow3,dur_sel3,dur_base3,dur_Instr};
pmod = pmod3;
if subnum < 10
    save(['00' int2str(subnum) '_block3'],'names','onsets','durations','pmod')
elseif subnum > 10
    save(['0' int2str(subnum) '_block3'],'names','onsets','durations','pmod')
end

disp('COMPLETE')