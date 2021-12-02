function StatsJS(first,last) % number of first and last subject in analysis
% Stats for fMRI data
% Based on bits of Christian Kaul's, Christian Doeller's and Hanneke Den
% Ouden's code. V grateful to all!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script creates first-level statistics and contrasts.
%
% Requires subject and session specific subdirs.
% See below in code for examples of how these are organised
%
% Requires SPM8 to be in the path
%
% Steve Fleming 2008
% with thanks to Steve, Bianca Wittmann 2011
%_________________________________________________________________________
%% Define subject parameters and directories
%clear classes;
fs          = filesep;
n_sess      = 4; %nr of runs 
dir_base    = 'C:\Users\Elias\Desktop\fMRI\DATA\';

TR = 2.80;

%% Define what processing we want
%werkt niet voor 3,4,7
for s = [99];%3:33;5,6,8:33s=3,4,7; 5,8:33 
    if s < 10
        subdir     = [dir_base 'sub00' int2str(s)];
        ppnBase    = ['ppn00' int2str(s)];
        subMap     = ['sub00' int2str(s)];
    else
        subdir     = [dir_base 'sub0' int2str(s)];
        ppnBase    = ['ppn0' int2str(s)];
        subMap     = ['sub0' int2str(s)];
    end
    
    dir_onsets  = ['C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\' subMap '\Onsets'];
    mkdir(['C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\' subMap '\statsFULLmodelDminB_no_int_noEM']);
    dir_stats   = ['C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\' subMap '\statsFULLmodelDminB_no_int_noEM'];
           
    clearOldStats = 0; %deletes everything in the stats folders
    stats = 0;
    estimate = 0;
    contrast = 1; %now just contrast 1; also deletes previous stats
    contrastALL = 1;

    spm fmri
    spm_defaults
    global defaults
  
if clearOldStats
     delete([dir_stats '/*']);
end
    
if stats
    % Create stats if stats
    disp(['Model specification ']);
    disp(['Stats job specification for subject : ', s]);
    
    % cd to functional dir so that the .mat and .ps file is written there for future
    % review
    cd([subdir]);
    
    matlabbatch{1}.spm.stats.fmri_spec.dir      = {dir_stats};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.8;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    
    % loop to define new session in job
    for sess = 1:n_sess %sess=1
        sessname = ['-',num2str(sess)];                                                            
        % define epi files in the session
        scanDir = [subdir '\run' num2str(sess)];
        % select scans and assign to job
        f   = spm_select('List', scanDir, '^swuf.*\.img$');
        files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).scans = files;
        f = []; files = [];
        % select multiple conditions onsets file and assign to job
        scanDir = [dir_onsets];
        %NOTE, change!
        onsetsfilefilter = strcat('SPMonsetsFULLModel_D-B_no_int_noEM', int2str(s), sessname);   
        f   = spm_select('List', scanDir, onsetsfilefilter);
        files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi = files;
        f = []; files = [];
        %select movement regressors file and assign to job
        %select onsets
        scanDir = [subdir '\run' num2str(sess)];
        f   = spm_select('List', scanDir, '^rp.*\.txt$');
        files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
        allNuisRegs = [subdir '\run' int2str(sess) '\allRegressors.txt']; %both movement and physio regressors
        %%%%%%Movement and physio regressors have been concatenated before
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi_reg = {allNuisRegs};
        f = []; files = [];
        matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});    
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).hpf = 128;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).regress = struct('name', {}, 'val', {});
    
    end
         
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save and run job
    cd([dir_stats])
    save model_spec.mat matlabbatch
    disp(['RUNNING model specification for subject ' s]);
    spm_jobman('run','model_spec.mat');
    disp('Job completed');
    clear matlabbatch
end

%% Estimation
if estimate
    disp(['Model specification ']);
    disp(['Estimation job specification for subject : ', s]);
      
    % define stats directory
    scanDir = [dir_stats];
    % select SPM.mat file
    f   = spm_select('List', scanDir, '^S.*\.mat$')
    files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
    matlabbatch{1}.spm.stats.fmri_est.spmmat = files
    f = []; files = [];
    
    matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save and run job
    save model_est.mat matlabbatch
    %disp(['RUNNING model estimation for subject ' s]);
    % spm_jobman('interactive','realignunwarp.mat');        Use to review
    spm_jobman('run','model_est.mat');
    %disp('Job completed');
    clear matlabbatch
end

%% Contrast manager
   if contrast
            disp(['Model specification ']);
            disp(['Contrast job specification for subject : ', s]);

                % define stats directory
                scanDir = [dir_stats]
                % select SPM.mat file
                f   = spm_select('List', scanDir, '^SPM.*\.mat$')
                files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
                matlabbatch{1}.spm.stats.con.spmmat = files;
                f = []; files = [];

                %%%contrast 1
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.name = 'EVb23';      
                                                                    
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.convec = [0,0,0,0, 0,0,1,0,  0,0,1,0,      0,0,0,0, 0,0,0,0, 0,0,0,0]; %run1, movemement parameters excluded here; 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.sessrep = 'replsc'; 
                matlabbatch{1}.spm.stats.con.delete = 1;

                % save and run job
                cd(dir_stats)
                save EVb23.mat matlabbatch
                %disp(['RUNNING contrasts specification for subject ' s]);
                spm_jobman('run','EVb23.mat');
                
            if contrastALL      
                clear matlabbatch
                % define stats directory
                scanDir = [dir_stats]
                % select SPM.mat file
                f   = spm_select('List', scanDir, '^SPM.*\.mat$')
                files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
                matlabbatch{1}.spm.stats.con.spmmat = files;
                f = []; files = [];

               %%%contrast 2
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.name = 'EVsal23';      
                                                                    
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.convec = [0,0,0,0, 0,0,0,1,  0,0,0,1,      0,0,0,0, 0,0,0,0, 0,0,0,0]; %run1, movemement parameters excluded here; 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.sessrep = 'replsc';  

                %save and run job
                cd(dir_stats)
                save EVsal23.mat matlabbatch
                %disp(['RUNNING contrasts specification for subject ' s]);
                spm_jobman('run','EVsal23.mat');
                %clear matlabbatch
                               
                %%%contrast 3
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.name = 'SAL23';      
                                                                    
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.convec = [0,0,0,0, 0,1,0,0,  0,1,0,0,      0,0,0,0, 0,0,0,0, 0,0,0,0]; %run1, movemement parameters excluded here; 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.sessrep = 'replsc';  

                % save and run job
                cd(dir_stats)
                save SAL23.mat matlabbatch
                disp(['RUNNING contrasts specification for subject ' s]);
                spm_jobman('run','SAL23.mat');
                %clear matlabbatch
                
                %%%contrast 4
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.name = 'PEb23';      
                                                                    
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.convec = [0,0,0,0, 0,0,0,0,  0,0,0,0,      0,0,0,0, 0,0,1,0, 0,0,1,0]; %run1, movemement parameters excluded here; 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.sessrep = 'replsc';  

                %matlabbatch{1}.spm.stats.con.delete = 1;
                % save and run job
                cd(dir_stats)
                save PEb23.mat matlabbatch
                disp(['RUNNING contrasts specification for subject ' s]);
                spm_jobman('run','PEb23.mat');
                %clear matlabbatch
                
                %%%contrast 5
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.name = 'PEsal23';      
                                                                    
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.convec = [0,0,0,0, 0,0,0,0,  0,0,0,0,      0,0,0,0, 0,0,0,1, 0,0,0,1]; %run1, movemement parameters excluded here; 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.sessrep = 'replsc';  
                
                % save and run job
                cd(dir_stats)
                save PEsal23.mat matlabbatch
                disp(['RUNNING contrasts specification for subject ' s]);
                spm_jobman('run','PEsal23.mat');
                %clear matlabbatch
                           
                %%%contrast 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.name = 'SALoutc23';      
                                                                    
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.convec = [0,0,0,0, 0,0,0,0,  0,0,0,0,      0,0,0,0, 0,1,0,0, 0,1,0,0]; %run1, movemement parameters excluded here; 6
                matlabbatch{1}.spm.stats.con.consess{1,1}.tcon.sessrep = 'replsc';  

                % save and run job
                cd(dir_stats)
                save SALoutc23.mat matlabbatch
                disp(['RUNNING contrasts specification for subject ' s]);
                spm_jobman('run','SALoutc23.mat');
                %clear matlabbatch
                

                    
            end   
   end
end

