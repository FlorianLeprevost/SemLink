function contrast_batch (first,last) % number of first and last subject in analysis
% First-level statistics for fMRI data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script 

% a) creates T contrasts (for F contrasts or other contrasts, the script
% would need to be adapted)
% b) prints first-level results with a pre-specified threshold
%
% Requires subject specific subdir and a statsX subdir, with
% X=number of GLM analysis. 
%
% Requires spm12 to be in the path
%
% Bianca Wittmann 2018 
%
% version 1.0, 2018-09-07
% _________________________________________________________________________

%% Define subject parameters, directories, MRI parameters (CHANGE ACCORDING TO YOUR SEQUENCE)
fs              = filesep;
GLM             = 2; %number of your GLM analysis (in case you run more than one, change this)
dir_stats       = ['stats' int2str(GLM)]; %name of the directory that the other script created
%% Define what processing we want
exclude = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 29];

for s0 = 22:32; 
    if ismember(s0,exclude); %continue with next iteration when sub is in exclude!
        continue
    end
    
    if s0 < 10
        dir_base        = ['D:\reward_selective_attention_elias\fMRI\DATA\sub00' int2str(s0)];
    else
        dir_base        = ['D:\reward_selective_attention_elias\fMRI\DATA\sub0' int2str(s0)];
    end
    name_subj = ['sub' num2str(s0)];  

        contrasts   = 1;
        print       = 1;
        
    spm('defaults','fmri');
    spm_jobman('initcfg');

%% Creating contrasts
if contrasts
    disp(['Contrast specification for Subject : ', name_subj]);
    cd(dir_base);
    
    matlabbatch{1}.spm.stats.con.spmmat = cellstr([dir_base fs dir_stats fs 'SPM.mat']);
    
    %% Funcloc Contrasts
    
    %Selection v. Baseline (rep)
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'P_v_Base';
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 -1];
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'L_v_Base';
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 -1];
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'T_v_Base';
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = [0 0 1 -1];
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'P_v_LT';
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = [2 -1 -1];
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'L_v_PT';
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [-1 2 -1];
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'T_v_PL';
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = [-1 -1 2];
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
    
    
    matlabbatch{1}.spm.stats.con.delete = 1;         %do you want to delete all existing contrasts?

end
    
%% Print first-level results
if print
    matlabbatch{2}.spm.stats.results.spmmat = cellstr([dir_base fs dir_stats fs 'SPM.mat']);
    
    matlabbatch{2}.spm.stats.results.conspec(1).titlestr = 'a';
    matlabbatch{2}.spm.stats.results.conspec(1).contrasts = Inf;    %writes all existing contrasts
    matlabbatch{2}.spm.stats.results.conspec(1).threshdesc = 'none';%no correction for multiple comparisons
    matlabbatch{2}.spm.stats.results.conspec(1).thresh = 0.005;     %choose the alpha threshold
    matlabbatch{2}.spm.stats.results.conspec(1).extent = 0;         %choose the cluster extent
    matlabbatch{2}.spm.stats.results.conspec(1).mask.none = 1;      %mask results? 1=no masking
        
    matlabbatch{2}.spm.stats.results.units = 1;     %default for fMRI data, should not be changed
    matlabbatch{2}.spm.stats.results.print = 'ps';  %results are written to a postscript file
    matlabbatch{2}.spm.stats.results.write.none = 1; %write no filtered images (see GUI if you want to write images)
end

% save and run job
    save contrasts.mat matlabbatch
    disp(['RUNNING Contrast specification for subject ' name_subj]);
    spm_jobman('run','contrasts.mat');
    clear matlabbatch;
    disp('Job completed');
end  % end of loop all subs
