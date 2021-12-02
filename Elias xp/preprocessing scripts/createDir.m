%create directories for subject data

for subnum = [1:32];
    datapath = ['D:\reward_selective_attention_elias\fMRI\DATA'];
    run = 0; % initialize
    if subnum < 10
        subjPath = strcat([datapath '\sub00' int2str(subnum)]);
    else
        subjPath = strcat([datapath '\sub0' int2str(subnum)]);
    end
        
    mkdir([subjPath '\MT']);
    mkdir([subjPath '\MTohne']);
    mkdir([subjPath '\Fieldmap']);
    mkdir([subjPath '\run1']);
    mkdir([subjPath '\run2']);
    mkdir([subjPath '\run3']);
    mkdir([subjPath '\run4']);
    mkdir([subjPath '\Anat']);
    mkdir([subjPath '\functional_movies']);
    mkdir([subjPath '\stats']);
    mkdir([subjPath '\zipped']);
    mkdir([subjPath '\log']);
    mkdir([subjPath '\raw']);
    mkdir([subjPath '\physio']);
    mkdir([subjPath '\onsets']);
    mkdir([subjPath '\contrasts']);
end

disp('Created subdirectories')
