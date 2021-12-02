%%IMPLEMENT 100ms delay for Monitor!

%%script reads onset times of xls converted OpenSesame log files
% open file
subnum = 23;        
path = 'D:\reward_selective_attention_elias\fMRI\log_data\xls\funcloc-';
file = [path int2str(subnum) '.xls'];
[numbers, strings, raw] = xlsread(file); 

%find indices of "condition" and "baseline" (live_row == 0 --> %time_baseline)
ind_condition = find(ismember(strings(1,:),'condition'));
ind_time_stim = find(ismember(strings(1,:),'time_show_stim'))-6;
ind_time_base = find(ismember(strings(1,:),'time_baseline'))-6;
ind_trigger = find(ismember(strings(1,:),'time_baseline_1'))-6;

%grab rows per condition + baseline
person_row = find(ismember(strings(2:end,ind_condition),'P')); %single trials
location_row = find(ismember(strings(2:end,ind_condition),'L')); %single trials
tool_row = find(ismember(strings(2:end,ind_condition),'T')); %single trials

%onset of blocks per conditions (4)
person_start = person_row(1:13:end);
location_start = location_row(1:13:end);
tool_start = tool_row(1:13:end);

base_col = numbers(:,ind_time_base);
base_col = unique(base_col);
base_col = base_col(1:11,:);

%fill arrays for onsets per condition
ons_person = numbers(person_start,ind_time_stim);
ons_location = numbers(location_start,ind_time_stim);
ons_tool = numbers(tool_start,ind_time_stim);
ons_baseline = base_col;

%fill arrays for duration per condition
dur_person = 30.* ones(size(ons_person));
dur_location = 30.*ones(size(ons_location));
dur_tool = 30.*ones(size(ons_tool));
dur_baseline = 10.*ones(size(ons_baseline));

%subtract trigger delay from onsets
trigger_delay = numbers(1,ind_trigger);

ons_person = (ons_person - trigger_delay) / 1000;
ons_location = (ons_location - trigger_delay) / 1000;
ons_tool = (ons_tool - trigger_delay) / 1000;
ons_baseline = (ons_baseline - trigger_delay) / 1000;

names = {'person','location','tool','baseline'}
durations = {dur_person,dur_location,dur_tool,dur_baseline}
onsets = {ons_person,ons_location,ons_tool,ons_baseline}


if subnum <= 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' num2str(subnum) '\onsets']);
elseif subnum > 10;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' num2str(subnum) '\onsets']);
end

if subnum > 9
    save(['GLM2_run4'],'names','onsets','durations')
elseif subnum <10
    save(['GLM2_run4'],'names','onsets','durations')
end




