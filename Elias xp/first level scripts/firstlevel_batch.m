function firstlevel_batch(first,last) % number of first and last subject in analysis
% First-level statistics for fMRI data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script 
% a) creates a stats folder for each subject and each numbered GLM analysis
% b) specifies a first-level design matrix, checking for each run whether
% there is a vswua* file (ArtRepair output) or not - if not, it takes swua*
% instead
% c) estimates the GLM% 
%
% Requires subject and session specific subdirs. Onset files should be
% in a subject-specific folder named Onsets. The files should be named
% GLMx_runy with x=number of your GLM analysis and y=number of functional
% run. Alternatively, it may make sense to have all onsets in one folder, 
% with files named subxx_GLMy_runz (xx=sub number etc). In that case, 
% you need to change the dir_onsets and uncomment/comment the respective 
% lines in the script.
% Movement (and physio) regressors need to be in a single text file per
% run.
%
% Requires spm12 to be in the path, uses the 3D nifti files created as last
% step of preprocessing batch script.
%
% Bianca Wittmann 2018 
%
% version 1.0, 2018-09-07
% _________________________________________________________________________

%% Define subject parameters, directories, MRI parameters (CHANGE ACCORDING TO YOUR SEQUENCE)
GLM             = 1; %number of your GLM analysis (in case you run more than one, change this)fs              = filesep;
dir_onsets      = 'Onsets'; %directory that contains your onset files, either
                            %a subfolder for each subject (as in this
                            %example) or the full path to one folder for all
                            %subs with filenames as described above
start_sess      = 1; %first run that should be analysed
n_sess          = 6; %number of functional runs   
dir_stats       = ['stats' int2str(GLM)]; %name of the directory that is created
sess_prfx       = 'run';
TR              = 2.7; %your TR
nslices         = 48;  %number of slices
RefSlice        = 24;  %reference slice used during slice timing; temporally middle slice
unit            = 'secs'; %units of your design (=onsets), either scans or seconds
name_move       = 'allRegressors.txt';  %name of the file that contains movement (and physio, if applicable) regressors
%% Define what processing we want
for s0 = first:last; 
    if s0 < 10
        dir_base        = ['D:\Projekte_Judith\MRI_preprocessing_batch\salesman\sub00' int2str(s0)];
    else
        dir_base        = ['D:\Projekte_Judith\MRI_preprocessing_batch\salesman\sub0' int2str(s0)];
    end
    name_subj = ['sub' num2str(s0)];    
    
    if ~exist([dir_base fs dir_stats],'dir')
    mkdir(dir_base, dir_stats);
    end 
    
    estimate = 1; %if you want to set up your design to check it without estimating it, enter 0
    
spm('defaults','fmri');
spm_jobman('initcfg');

%% Model specification and estimation
    disp(['Model specification for Subject : ', name_subj]);
    cd(dir_base);
    
    matlabbatch{1}.spm.stats.fmri_spec.dir = {[dir_base fs dir_stats]}; % stats will be written in this dir
    
    % timing  parameters
    matlabbatch{1}.spm.stats.fmri_spec.timing.units     = unit;        
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT        = TR;             
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t    = nslices;   % microtime  resolution , if # of  slices> 16 use # of  slices
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0   = RefSlice; % microtime  onset  should  be set to the middle  slice if you performed slice timing
    
    for sess = start_sess:((start_sess+n_sess)-1)
        
        scanDir = [dir_base fs sess_prfx num2str(sess)];        
        test = spm_select('List', scanDir, '^vswua0.*_00.*.nii$');
        if isempty(test)
            f   = spm_select('List', scanDir, '^swua0.*_00.*.nii$');
            files = cellstr([repmat([scanDir fs],size(f,1),1) f]);
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).scans = files;       f = []; files = [];
        else
            f   = spm_select('List', scanDir, '^vswua0.*_00.*.nii$');
            files = cellstr([repmat([scanDir fs],size(f,1),1) f]);
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).scans = files;       f = []; files = [];          
        end
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
        
        %two versions, comment/uncomment the one you don't need/need
        %version for one onset folder for all subjects:
        %onsetDir = [dir_onsets];
        %f   = spm_select('List', onsetDir, ['sub' name_subj '_GLM' int2str(GLM) '_run' int2str(sess)]);
       
        %version for one onset folder per subject:
        onsetDir = [dir_base fs dir_onsets];
        f   = spm_select('List', onsetDir, ['GLM' int2str(GLM) '_run' int2str(sess)]);
        files = [onsetDir fs f];
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi = {files};        f = []; files = []; 
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).regress = struct('name', {}, 'val', {});
        
        f = spm_select('List', scanDir, name_move);
        files = [scanDir fs f];
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi_reg = {files};        f = []; files = []; 
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).hpf = 128; %leave default value    
    end
    
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0]; % do you want to model the derivatives?
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1; %leave default value
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None'; %leave default value
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8; %leave default value
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''}; %leave default value
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)'; %leave default value
    
    if estimate
        matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cellstr([dir_base fs dir_stats fs 'spm.mat']);
        matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
        matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    end
    
    % save and run job
    save analyse.mat matlabbatch
    disp(['RUNNING Model specification and estimation for subject ' name_subj]);
    spm_jobman('run','analyse.mat');
    clear matlabbatch;
    disp('Job completed');    

end  % end of loop all subs
