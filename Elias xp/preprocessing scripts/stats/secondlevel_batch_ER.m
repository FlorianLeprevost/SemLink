% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
nrun = 20; % enter the number of runs here
jobfile = {'D:\reward_selective_attention_elias\fMRI\preprocessing scripts\stats\secondlevel_batch_ER_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Factorial design specification: Directory - cfg_files
    inputs{2, crun} = MATLAB_CODE_TO_FILL_INPUT; % Factorial design specification: Scans - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
