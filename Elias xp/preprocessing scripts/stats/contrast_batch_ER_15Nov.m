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
GLM             = 1; %number of your GLM analysis (in case you run more than one, change this)
dir_stats       = ['stats' int2str(GLM)]; %name of the directory that the other script created
%% Define what processing we want
exclude = [3 4 19 23 26 29 30 32];

for s0 = 1:32; 
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
        print       = 0;
        
    spm('defaults','fmri');
    spm_jobman('initcfg');

%% Load .mat files for non-rep contrasts
    if s0 < 10
        cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' int2str(s0) '\contrasts']);
    else
        cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' int2str(s0) '\contrasts']);
    end

    load NonRepContrasts.mat  
    
%% Creating contrasts
if contrasts
    disp(['Contrast specification for Subject : ', name_subj]);
    cd(dir_base);
    
    matlabbatch{1}.spm.stats.con.spmmat = cellstr([dir_base fs dir_stats fs 'SPM.mat']);
    
    %% Selection Contrasts
    
    %Selection v. Baseline (rep)
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'Sel_v_Base';
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = [0 0 0 0 0 0 0 0 0 1 -1];
    matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
    
    %copy and paste for as many contrasts as you need
    %alternatively, load the contrasts from a file with name and weights
    % -----example for not replicating across sessions --------%
    %Contrast Pselection v Baseline
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'Psel_v_Base';          %enter a name for the first contrast
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = Psel;            %enter the contrast weights for the first contrast
    matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';          %do you want to replicate the contrast across sessions?  yes,
                                                                            %enter the contrast weights only for one session;  no, enter the
                                                                            %full contrast weights across all sessions
    %Contrast Lselection v Baseline                                         %you can also choose other options here (eg. replicate&scale), see GUI
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'Lsel_v_Base';
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = Lsel;                                                                        
    matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';   
    
    %Contrast Tselection v Baseline
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'Tsel_v_Base';
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = Tsel;                                                                        
    matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
    
    %% Game Contrasts
    
    % -----example for replicating across sessions ----------%
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'Con_v_Icon_Choice'; %Contrast Congruent v Incongruent Choice
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = [1 0 -1];
    matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
     
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'Con_v_Icon_FB'; %Contrast Congruent v Incongruent Feedback
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 1 1 -1 -1];
    matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{7}.tcon.name = 'Con_v_Icon_posFB'; %Contrast Congruent v Incongruent POSITIVE Feedback
    matlabbatch{1}.spm.stats.con.consess{7}.tcon.weights = [0 0 0 0 1 0 -1];
    matlabbatch{1}.spm.stats.con.consess{7}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{8}.tcon.name = 'Con_v_Icon_negFB'; %Contrast Congruent v Incongruent NEGATIVE Feedback
    matlabbatch{1}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 1 0 -1];
    matlabbatch{1}.spm.stats.con.consess{8}.tcon.sessrep = 'repl';
    
    % specify PMOD Contrasts for subs that don't have all pmods uniquely
    %specified! This affects Contrast 9 for both Pmods and contrast 10 for
    %ConPmod
    
    if s0 == 1;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'ConIconPMOD'; %Both PMODS
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = sub1_allmods;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
    
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'ConPMOD'; %ConChoice PMOD
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = sub1_conmod;
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
    elseif s0 == 13;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'ConIconPMOD'; %Both PMODS
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = sub13_allmods;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
    
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'ConPMOD'; %ConChoice PMOD
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = sub13_conmod;
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
    elseif s0 == 16;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'ConIconPMOD'; %Both PMODS
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = sub16_allmods;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
    
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'ConPMOD'; %ConChoice PMOD
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = sub16_conmod;
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
    elseif s0 == 31;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'ConIconPMOD'; %Both PMODS
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = sub31_allmods;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
    
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'ConPMOD'; %ConChoice PMOD
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = sub31_conmod;
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
    else;
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.name = 'ConIconPMOD'; %Both PMODS
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.weights = [0 1 0 -1];
        matlabbatch{1}.spm.stats.con.consess{9}.tcon.sessrep = 'repl';
    
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.name = 'ConPMOD'; %ConChoice PMOD
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.weights = [0 1];
        matlabbatch{1}.spm.stats.con.consess{10}.tcon.sessrep = 'repl';
    end;    
    
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.name = 'IconPMOD'; %IconChoice PMOD
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.weights = [0 0 0 1];
    matlabbatch{1}.spm.stats.con.consess{11}.tcon.sessrep = 'repl';
    
    %Interaction effects -> Dimension-specific effect of con v icon CHOICE
    matlabbatch{1}.spm.stats.con.consess{12}.tcon.name = 'P_v_LT_choice'; %ConIcon P vs. ConIcon LT (CHOICE)
    matlabbatch{1}.spm.stats.con.consess{12}.tcon.weights = P_CHOICE;                                                                        
    matlabbatch{1}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{13}.tcon.name = 'L_v_PT_choice'; %ConIcon L vs. ConIcon PT (CHOICE)
    matlabbatch{1}.spm.stats.con.consess{13}.tcon.weights = L_CHOICE;                                                                        
    matlabbatch{1}.spm.stats.con.consess{13}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{14}.tcon.name = 'T_v_PL_choice'; %ConIcon T vs. ConIcon PL (CHOICE)
    matlabbatch{1}.spm.stats.con.consess{14}.tcon.weights = T_CHOICE;                                                                        
    matlabbatch{1}.spm.stats.con.consess{14}.tcon.sessrep = 'none';
    
    %Interaction effects -> Dimension-specific effect of con/icon POS FB
    matlabbatch{1}.spm.stats.con.consess{15}.tcon.name = 'P_v_LT_posFB'; %ConIcon P vs. ConIcon LT (FB)
    matlabbatch{1}.spm.stats.con.consess{15}.tcon.weights = P_FBpos;                                                                        
    matlabbatch{1}.spm.stats.con.consess{15}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{16}.tcon.name = 'L_v_PT_posFB'; %ConIcon L vs. ConIcon PT (FB)
    matlabbatch{1}.spm.stats.con.consess{16}.tcon.weights = L_FBpos;                                                                        
    matlabbatch{1}.spm.stats.con.consess{16}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{17}.tcon.name = 'T_v_PL_posFB'; %ConIcon T vs. ConIcon PL (FB)
    matlabbatch{1}.spm.stats.con.consess{17}.tcon.weights = T_FBpos;                                                                        
    matlabbatch{1}.spm.stats.con.consess{17}.tcon.sessrep = 'none';
    
    %Interaction effects -> Dimension-specific effect of con/icon NEG FB
    matlabbatch{1}.spm.stats.con.consess{18}.tcon.name = 'P_v_LT_negFB'; %ConIcon P vs. ConIcon LT (FB)
    matlabbatch{1}.spm.stats.con.consess{18}.tcon.weights = P_FBneg;                                                                        
    matlabbatch{1}.spm.stats.con.consess{18}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{19}.tcon.name = 'L_v_PT_negFB'; %ConIcon L vs. ConIcon PT (FB)
    matlabbatch{1}.spm.stats.con.consess{19}.tcon.weights = L_FBneg;                                                                        
    matlabbatch{1}.spm.stats.con.consess{19}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{20}.tcon.name = 'T_v_PL_negFB'; %ConIcon T vs. ConIcon PL (FB)
    matlabbatch{1}.spm.stats.con.consess{20}.tcon.weights = T_FBneg;                                                                        
    matlabbatch{1}.spm.stats.con.consess{20}.tcon.sessrep = 'none';
    
    matlabbatch{1}.spm.stats.con.consess{21}.tcon.name = 'posFB_v_negFB'; %Positive v Negative Feedback (Game)
    matlabbatch{1}.spm.stats.con.consess{21}.tcon.weights = [0 0 0 0 1 -1 1 -1];                                                                        
    matlabbatch{1}.spm.stats.con.consess{21}.tcon.sessrep = 'repl';
    
    matlabbatch{1}.spm.stats.con.consess{22}.tcon.name = 'Kongruenz x Feedback Valence'; %Positive v Negative Feedback (Game)
    matlabbatch{1}.spm.stats.con.consess{22}.tcon.weights = [0 0 0 0 1 -1 -1 1];                                                                        
    matlabbatch{1}.spm.stats.con.consess{22}.tcon.sessrep = 'repl';
    
    %matlabbatch{1}.spm.stats.con.consess{23}.tcon.name = 'Con+Icon_PMOD'; %Positive v Negative Feedback (Game)
    %matlabbatch{1}.spm.stats.con.consess{23}.tcon.weights = [0 1 0 1];                                                                        
    %matlabbatch{1}.spm.stats.con.consess{23}.tcon.sessrep = 'repl';
    
    %Contrast P v LT selection
    matlabbatch{1}.spm.stats.con.consess{23}.tcon.name = 'PvLTsel';
    matlabbatch{1}.spm.stats.con.consess{23}.tcon.weights = PvLTsel;                                                                        
    matlabbatch{1}.spm.stats.con.consess{23}.tcon.sessrep = 'none';
    
    %Contrast L v PT selection
    matlabbatch{1}.spm.stats.con.consess{24}.tcon.name = 'LvPTsel';
    matlabbatch{1}.spm.stats.con.consess{24}.tcon.weights = LvPTsel;                                                                        
    matlabbatch{1}.spm.stats.con.consess{24}.tcon.sessrep = 'none';
    
    %Contrast T v PL selection
    matlabbatch{1}.spm.stats.con.consess{25}.tcon.name = 'TvPLsel';
    matlabbatch{1}.spm.stats.con.consess{25}.tcon.weights = TvPLsel;                                                                        
    matlabbatch{1}.spm.stats.con.consess{25}.tcon.sessrep = 'none';
    
    %Contrast Con Choice+PMOD
    matlabbatch{1}.spm.stats.con.consess{26}.tcon.name = 'Con_Choice_PMOD';
    matlabbatch{1}.spm.stats.con.consess{26}.tcon.weights = [1 -1];                                                                        
    matlabbatch{1}.spm.stats.con.consess{26}.tcon.sessrep = 'repl';
    
    %Contrast Icon Choice+PMOD
    matlabbatch{1}.spm.stats.con.consess{27}.tcon.name = 'Icon_Choice_PMOD';
    matlabbatch{1}.spm.stats.con.consess{27}.tcon.weights = [0 0 1 -1];                                                                        
    matlabbatch{1}.spm.stats.con.consess{27}.tcon.sessrep = 'repl';
    
    
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
