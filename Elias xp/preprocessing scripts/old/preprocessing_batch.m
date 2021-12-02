function preprocessing_batch(first,last) % number of first and last subject in analysis
% Spatial Preprocessing for fMRI data
% Based on bits of Christian Kaul's, Christian Doeller's and Hanneke Den
% Ouden's code. V grateful to all!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script 

% a) extracts the brain from the structural image
% b) runs tsdiffana
% c) performs slice timing correction
% d) creates a field map
% e) realigns & unwarps using fieldmaps,
% f) Coregisters the mean epi and functionals to the EPI template and the structural and MT images to mean-epi
% g) Segments the coregistered structural using the new normalize:estimate procedure
% h) Normalize:writes all functional runs, the structural and MT images 
% i) performs smoothing
% j) converts the 4D smoothed images to 3D for use with ArtRepair
%
% Requires subject and session specific subdirs, plus
% fieldmap and structural subdirectories.
% See instructions or below in code for examples of how these are organised
%
% Requires spm12 to be in the path, works with 4D nifti files 
%
% Steve Fleming 2008
% with thanks to Steve, Bianca Wittmann 2011 and 2018
%
% After adjusting the script for spm12: version 1.0, 2018-06-23
% _________________________________________________________________________

%% Define subject parameters and directories
dir_epitmp = ['C:/Program Files/SPM/spm12/toolbox/OldNorm'];%directory of EPI template 
dir_tpm = ['C:/Program Files/SPM/spm12/tpm']; %directory of tissue probability map
fs              = filesep;
n_sess          = 4; %number of functional runs   
dir_struct      = 'Anat';
dir_MT          = 'MT';  
dir_MTohne      = 'MTohne'; 
dir_fm          = 'Fieldmap';
fm_phase        = '^0.*_16.*\.nii$';        %your fieldmap phase image (the single image) '^s\d.*-0016.*\.nii$'; 
fm_mag          = '^0.*_15_1.*\.nii$';    %your fieldmap magnitude image (the first of the two sequential images)'^s\d.*-0015.*.-01.*\.nii$';
sess_prfx       = 'run';
dummy_scans     = 0;
%% Define what processing we want
for s0 = first:last; 
            if s0 < 10
                dir_base        = ['D:\Projekte_Judith\MRI_preprocessing_batch\sub00' int2str(s0)];
            else
                dir_base        = ['D:\Projekte_Judith\MRI_preprocessing_batch\sub0' int2str(s0)];
            end
            name_subj = ['sub' num2str(s0)];           
         
            extract = 1;        %enter 1 for steps that you want to run, enter 0 for steps that you want to skip 
            tsdiffana = 1;
            slicetiming = 1;
            fieldmap = 1;                       
            realign = 1;                               
            coregister = 1;
            segment = 1;
            normalise = 1;            
            smoothing = 1;
            convert = 1;
            
%% MRI parameters: CHANGE ACCORDING TO YOUR MRI SEQUENCES!!
TR = 2.8; % TR in seconds
N_slices = 50; % number of slices
TA = TR-(TR/N_slices); % acquisition time for slice timing
RefSlice = 50;   %reference slice for slice timing; temporally middle slice
SliceOrder = [2:2:50 1:2:49]; %bottom-up interleaved, for even slice numbers use [2:2:x 1:2:y], for uneven slice numbers use [1:2:x 2:2:y] 
FWHM  = 6; % smoothing kernel
resolT1 = [1 1 1]; %resolution of structural (used during normalization) = resulting resolution after normalization, not the original resolution
resolEPI = [2 2 2]; %resolution of functional (used during normalization) = resulting resolution after normalization, not the original resolution
fm_te = [10.0 12.46]; %fieldmap echo times for short and long TE [in ms]
fm_epi = 0; %0 if fieldmap is gradient echo sequence, 1 if fieldmap is epi sequence
fm_ert = 21.056; %total readout time of one slice in the EPI sequence [in ms]
fm_blipdir = -1;%Enter the blip direction. This is the polarity of the phase-encode blips describing the direction in which k-space is traversed along the y-axis during EPI acquisition with respect to the coordinate system used in SPM. In this coordinate system, the phase encode direction corresponds with the y-direction and is defined as positive from the posterior to the anterior of the head.

%%%%%%%%%%%%%%%%%%%%%%%
           %%You will usually not have to make any changes beyond this point %%
%%%%%%%%%%%%%%%%%%%%%%%


spm('defaults','fmri');
spm_jobman('initcfg');


%% Strip skull from structural image (currently necessary on Prisma)
if extract
    disp(['brain extraction job specification for Subject : ', name_subj]);
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    sourceDir = [dir_base fs dir_struct];
    f   = spm_select('List', sourceDir, '^0.*\.nii$');
    files = [sourceDir fs f];
    matlabbatch{1}.spm.tools.MRI.MRTool_preproc.MRTool_brain.t1w = {files};      f = []; files = [];
    matlabbatch{1}.spm.tools.MRI.MRTool_preproc.MRTool_brain.res_dir = {sourceDir};
    
    % save and run job
    save extract.mat matlabbatch
    disp(['RUNNING brain extraction job for subject ' name_subj])
    spm_jobman('run','extract.mat');
    disp('Job completed');
    clear matlabbatch;    
end

%% Quality control using tsdiffana
if tsdiffana
    disp(['tsdiffana job specification for Subject : ', name_subj]);
     clear matlabbatch;
     cd(dir_base);     % cd so that .mat file is written in subject dir
    % *********************************************************************
    %first calculate differences
    for sess = 1:n_sess
        scanDir = [dir_base fs sess_prfx num2str(sess)];
        % get epi scans
        f   = spm_select('ExtList', scanDir, '^0.*\.nii$');
        files  = cellstr([repmat([scanDir '/'],size(f,1),1) f]);
        matlabbatch{1}.spm.tools.tsdiffana_tools{1}.tsdiffana_timediff.imgs{sess}              = files;       f = []; files = [];
    end
    
    matlabbatch{1}.spm.tools.tsdiffana_tools{1}.tsdiffana_timediff.vf = true; 
   
    % save and run job
    save tsdiffana_calculate.mat matlabbatch
    disp(['RUNNING tsdiffana_1 job for subject ' name_subj])
    spm_jobman('run','tsdiffana_calculate.mat');
    disp('Job completed');
    clear matlabbatch;
    
    %then write out the results images    
    for sess = 1:n_sess
        scanDir = [dir_base fs sess_prfx num2str(sess)];
        % get timediff files
        f = spm_select('List', scanDir, 'timediff.mat');
        files  = cellstr([repmat([scanDir '/'],size(f,1),1) f]); 
        matlabbatch{1}.spm.tools.tsdiffana_tools{1}.tsdiffana_tsdiffplot.tdfn(sess,1) = files;        f = []; files = [];
    end
    matlabbatch{1}.spm.tools.tsdiffana_tools{1}.tsdiffana_tsdiffplot.doprint = true; 
    
    % save and run job
    save tsdiffana_plot.mat matlabbatch
    disp(['RUNNING tsdiffana_2 job for subject ' name_subj])
    spm_jobman('run','tsdiffana_plot.mat');
    disp('Job completed');
    clear matlabbatch;    
    movefile('spm*.ps','tsdiffana'); %moves the results image file into a subdirectory (which it creates) [use a postscript viewer to view the files (an easy one is "rampant logic postscript viewer")]
    % *********************************************************************
end
%% Slicetiming
if slicetiming
    disp(['Slicetiming job specification for Subject : ', name_subj]);
    clear matlabbatch;
    cd(dir_base);     % cd so that .mat file is written in subject dir
    % *********************************************************************
    for sess = 1:n_sess
        scanDir = [dir_base fs sess_prfx num2str(sess)];
        % get epi scans
        f   = spm_select('ExtList', scanDir, '^0.*\.nii$');
        files  = cellstr([repmat([scanDir '/'],size(f,1),1) f]);
        matlabbatch{1}.spm.temporal.st.scans{sess}              = files;       f = []; files = [];
    end
    matlabbatch{1}.spm.temporal.st.nslices                      = N_slices;
    matlabbatch{1}.spm.temporal.st.tr                           = TR;
    matlabbatch{1}.spm.temporal.st.ta                           = TA;
    matlabbatch{1}.spm.temporal.st.so                           = SliceOrder;
    matlabbatch{1}.spm.temporal.st.refslice                     = RefSlice;
    matlabbatch{1}.spm.temporal.st.prefix                       = 'a';
    
    % save and run job
    save slicetiming.mat matlabbatch
    disp(['RUNNING slicetiming job for subject ' name_subj])
    spm_jobman('run','slicetiming.mat');
    disp('Job completed');
    clear matlabbatch;
    % *********************************************************************
end

%% Create Fieldmap for each run
if fieldmap %%%THIS NEEDS 3 IMAGES
    disp(['Creating fieldmap job specification for Subject : ', name_subj]);
    clear matlabbatch;
    cd(dir_base);     % cd so that .mat file is written in subject dir    
    fm_dir = [dir_base fs dir_fm]; 
    
    % Load phase and magnitude image
    f   = spm_select('List', fm_dir, fm_phase); 
    files  = cellstr([repmat([fm_dir '/'],size(f,1),1) f]);
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase           =  files;  f = []; files = [];
    
    f   = spm_select('List', fm_dir, fm_mag);
    files  = cellstr([repmat([fm_dir '/'],size(f,1),1) f]);
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude       =  files;  f = []; files = [];
    
    % Fieldmap_preprocess parameters (see help fieldmap_preprocess for more
    % details) 
    %==========================================================================
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.et             = fm_te;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.epifm          = fm_epi;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.tert           = fm_ert;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.blipdir        = fm_blipdir;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.maskbrain      = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.ajm            = 0; %0=no jacobian modulation
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchvdm                            = 1; %1= matches vdm to epis
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.sessname                            = 'run';
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.writeunwarped                       = 1; %if set to 1 it saves an unwarped epi for visual quality control
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.anat                                = []; %you can enter an anatomical image for visual quality control
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchanat                           = 0; %if set to 1 it matches the unwarped epi to the anatomical image for visual quality control
    
    % loop through all subjects and sessions
    %===========================================================================
        for sess = 1:n_sess
            epidir = [dir_base fs sess_prfx num2str(sess)];
            f   = spm_select('ExtList', epidir, '^a0.*\.nii$', 1);
            files  = cellstr([repmat([epidir '/'],size(f,1),1) f]);
            matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.session(sess).epi = files;      f = []; files = [];            
        end
                   
                
        % save and run job
        save fieldmap.mat matlabbatch
        disp(['RUNNING fieldmap job for subject ' name_subj])
        spm_jobman('run','fieldmap.mat');
        disp('Job completed');
        clear matlabbatch;
end

 %% Realignment and unwarping
if realign
    disp(['Realign & unwarping job specification for Subject : ', name_subj]);
    clear matlabbatch;
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    % loop to define new session in job
    for sess = 1:n_sess
        sessname = ['run',num2str(sess)];
        % define epi files in the session
        scanDir = [dir_base fs sess_prfx num2str(sess)];
        % select slicetimed EPI scans and assign to job
        f   = spm_select('ExtList', scanDir, '^a0.*\.nii$');
        files  = cellstr([repmat([scanDir '\'],size(f,1),1) f]);
        matlabbatch{1}.spm.spatial.realignunwarp.data(sess).scans = files;      f = []; files = [];                
     % if you do not have a fieldmap do not run the next five lines  
        dir_fmap = fullfile(dir_base, dir_fm);      
        vdmfilefilter = sprintf('%s.*\.nii$',sessname);
        vdmfilename = spm_select('List', dir_fmap, vdmfilefilter);
        files  = cellstr([repmat([dir_fmap '\'],size(vdmfilename,1),1) vdmfilename]);
        matlabbatch{1}.spm.spatial.realignunwarp.data(sess).pmscan = files;         f = []; files = [];     
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % specify Estimation Options
    % all default values taken from SPM5 batch unless specified

    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.sep     = 2.0;    % default 4
    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.fwhm    = 5.0;    
    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.rtm     = 0;
    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.einterp = 2;
    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.ewrap    = [0 1 0];    % default none, changed to wrap Y
    matlabbatch{1}.spm.spatial.realignunwarp.eoptions.weight  = {};

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.basfcn   = [12 12];
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.regorder = 1.0;
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.lambda   = 1e+005;
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.jm       = 0;
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.fot      = [4 5];
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.sot      = [];
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.uwfwhm   = 4;
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.rem      = 1;
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.noi      = 5;
    matlabbatch{1}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % specify Reslice Options
    matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.uwwhich   = [2 1]; % mean and all
    matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.rinterp  = 4;
    matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.wrap    = [0 1 0];  % default none, changed to wrap Y
    matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.mask    = 1.0;
    matlabbatch{1}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % save and run job
    save realignunwarp.mat matlabbatch
    disp(['RUNNING Realignment & Unwarping for subject ' name_subj]);
    % spm_jobman('interactive','realignunwarp.mat');        Use to review
    spm_jobman('run','realignunwarp.mat');
    disp('Job completed');
    clear matlabbatch;    
    movefile('spm*.ps','realign_figure');%moves the visual display file of the movement parameters into a subdirectory (which it creates)
end
 
%% Coregistration of structural onto mean functional, of MT onto structural
 if coregister == 1    
    % 1) structural to mean functional 
    disp(['Structurals Coregistration job specification for Subject : ', name_subj]);
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    clear matlabbatch; 
    refDir = [dir_base fs sess_prfx '1'];
    f   = spm_select('List',refDir, '^meanu.*\.nii$'); 
    files = [refDir fs f];
    matlabbatch{1}.spm.spatial.coreg.estimate.ref = {files};          f = []; files = [];
    
    sourceDir = [dir_base fs dir_struct];
    f   = spm_select('List', sourceDir, '^0.*masked.nii$');
    files = [sourceDir fs f];
    matlabbatch{1}.spm.spatial.coreg.estimate.source = {files};       f = []; files = [];          
         
    matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};            
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
 
    save coreg_structural.mat matlabbatch
    disp(['RUNNING Structurals Coregistration for subject ' name_subj]);
    spm_jobman('run','coreg_structural.mat');
    clear matlabbatch;         
    
    % 2) MT to structural
    disp(['MT Coregistration job specification for Subject : ', name_subj]);
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    clear matlabbatch; 
    refDir = [dir_base fs dir_struct];
    f   = spm_select('List',refDir, '^0.*masked.nii$'); 
    files = [refDir fs f];
    matlabbatch{1}.spm.spatial.coreg.estimate.ref = {files};          f = []; files = [];
    
    sourceDir = [dir_base fs dir_MT];
    f   = spm_select('List', sourceDir, '^0.*\.nii$');
    files = [sourceDir fs f];
    matlabbatch{1}.spm.spatial.coreg.estimate.source = {files};       f = []; files = [];          
         
    matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};            
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
 
    save coreg_MT.mat matlabbatch
    disp(['RUNNING MT Coregistration for subject ' name_subj]);
    spm_jobman('run','coreg_MT.mat');
    clear matlabbatch;     
    
    % 3) MT-ohne to structural
    disp(['MT-ohne Coregistration job specification for Subject : ', name_subj]);
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    clear matlabbatch; 
    refDir = [dir_base fs dir_struct];
    f   = spm_select('List',refDir, '^0.*masked.nii$'); 
    files = [refDir fs f];
    matlabbatch{1}.spm.spatial.coreg.estimate.ref = {files};          f = []; files = [];
    
    sourceDir = [dir_base fs dir_MTohne];
    f   = spm_select('List', sourceDir, '^0.*\.nii$');
    files = [sourceDir fs f];
    matlabbatch{1}.spm.spatial.coreg.estimate.source = {files};       f = []; files = [];          
         
    matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};            
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
 
    save coreg_MTohne.mat matlabbatch
    disp(['RUNNING MT-ohne Coregistration for subject ' name_subj]);
    spm_jobman('run','coreg_MTohne.mat');
    clear matlabbatch;     
 end

%% Segmentation (using the new Normalise:Estimate procedure)
if segment
    clear matlabbatch;
    disp(['Segmentation-Normalization job specification for Subject : ', name_subj]);
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
   
    stDir = [dir_base fs dir_struct];
    f   = spm_select('List', stDir, '^0.*masked.*\.nii$');   % if coreg=1: notice coreg only changed header, so same address
    stFile = [stDir fs f];
    matlabbatch{1}.spm.spatial.normalise.est.subj.vol = {stFile};     f = [];
    
    f   = spm_select('List', dir_tpm, 'TPM.nii$');   
    tpmFile = [dir_tpm fs f];
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.tpm           = {tpmFile};
    
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.biasreg       = 0.0001;
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.biasfwhm      = 60;
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.affreg        = 'mni';
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.reg           = [0 1.000000000000000e-03 0.500000000000000 0.050000000000000 0.200000000000000];
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.fwhm          = 0; 
    matlabbatch{1}.spm.spatial.normalise.est.eoptions.samp          = 3;    
    
    % save batch
    save segment.mat matlabbatch
    disp(['RUNNING Segmentation-Normalization for subject ' name_subj]);
    cd(dir_base);
    spm_jobman('run','segment.mat');
    clear matlabbatch;
    disp('Job completed');
end

%% Normalise:write structurals and realigned and slice-time corrected EPIs including mean EPI
if normalise
    %1) Normalize structural
    disp(['Normalization:Write structural job specification for Subject : ', name_subj]);
    clear matlabbatch;
    cd(dir_base);% cd so that files are written in subject dir
    stDir = [dir_base fs dir_struct];
    f   = spm_select('List', stDir, '^y.*\.nii$');      %nii file with the distortion field
    files  = {[stDir fs f]};
    matlabbatch{1}.spm.spatial.normalise.write.subj.def = files;        f = []; files = []; 
       
    % select images to write: structural 
    f   = spm_select('List', stDir, '^0.*masked.nii$');          %select structural
    files  = {[stDir fs f]};  
    
    matlabbatch{1}.spm.spatial.normalise.write.subj.resample = files;       f = []; files = []; 
    matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = resolT1;
    matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 7;

    % save and run job
    save normwrite_struct.mat matlabbatch
    disp(['RUNNING Normalization:Write structural for subject ' name_subj]);
    spm_jobman('run','normwrite_struct.mat');
    clear matlabbatch
    disp('Job completed'); 
    
    %2) Normalize MT
    disp(['Normalization:Write MT job specification for Subject : ', name_subj]);
    clear matlabbatch;
    cd(dir_base);% cd so that files are written in subject dir
    stDir = [dir_base fs dir_struct];
    f   = spm_select('List', stDir, '^y.*\.nii$');      %nii file with the distortion field
    files  = {[stDir fs f]};
    matlabbatch{1}.spm.spatial.normalise.write.subj.def = files; f = []; files = []; 
    
    conCat_files = [];
    % select images to write: MTs          
    stDir = [dir_base fs dir_MT];
    f   = spm_select('List', stDir, '^0.*\.nii$');          %select MT
    files  = {[stDir fs f]};
    conCat_files = [conCat_files; files];                   f = []; files = []; stDir = [];
    
    stDir = [dir_base fs dir_MTohne];                       %select MTohne
    f   = spm_select('List', stDir, '^0.*\.nii$');
    files  = {[stDir fs f]};
    conCat_files = [conCat_files; files];                   f = []; files = []; stDir = [];
    
    matlabbatch{1}.spm.spatial.normalise.write.subj.resample = conCat_files;        conCat_files = [];
        matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = resolT1;
    matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 7;

    % save and run job
    save normwrite_MT.mat matlabbatch
    disp(['RUNNING Normalization:Write MT for subject ' name_subj]);
    spm_jobman('run','normwrite_MT.mat');
    clear matlabbatch
    disp('Job completed'); 
    
    %3) Normalize functionals
    disp(['Normalization:Write functionals job specification for Subject : ', name_subj]);
    clear matlabbatch;
    cd(dir_base);% cd so that files are written in subject dir
    stDir = [dir_base fs dir_struct];
    f   = spm_select('List', stDir, '^y.*\.nii$');      %nii file with the distortion field
    files  = {[stDir fs f]};
    matlabbatch{1}.spm.spatial.normalise.write.subj.def = files; f = []; files = []; 
     
    conCat_files = [];
    % select images to write: all functionals and mean EPI
    first_run = [dir_base fs sess_prfx '1'];   %select mean EPI
    f   = spm_select('List',first_run, '^meanu.*\.nii$'); 
    files  = {[first_run fs f]};
    conCat_files = [conCat_files; files];                   f = []; files = []; 
    
    for sess = 1:n_sess
        scanDir = [dir_base fs sess_prfx num2str(sess)];        %select realigned functionals        
        f   = spm_select('ExtList', scanDir, '^ua0.*\.nii$');
        files  = cellstr([repmat([scanDir fs],size(f,1),1) f]);
        conCat_files = [conCat_files; files];               f = []; files = [];
    end
            
    matlabbatch{1}.spm.spatial.normalise.write.subj.resample = conCat_files;   conCat_files = [];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 86]; %the bounding box must be a multiple of your voxel size (ie. you can divide all values by the relevant voxel size)
    matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = resolEPI;
    matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 7;

    % save and run job
    save normwrite.mat matlabbatch
    disp(['RUNNING Normalization:Write functionals for subject ' name_subj]);
    spm_jobman('run','normwrite.mat');
    clear matlabbatch;
    disp('Job completed');
end

%% Smoothing
if smoothing
    disp(['Smoothing job specification for Subject : ', name_subj]);
    clear matlabbatch;
    % smoothing
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    % get normalized images
    conCat_files = [];   
    for sess = 1:n_sess
        scanDir = [dir_base fs sess_prfx num2str(sess)];        
        f   = spm_select('ExtList', scanDir, '^wua0.*\.nii$');
        files  = cellstr([repmat([scanDir fs],size(f,1),1) f]);
        conCat_files = [conCat_files; files];                    f = []; files = [];        
    end
    matlabbatch{1}.spm.spatial.smooth.data      = conCat_files;     conCat_files = [];
    matlabbatch{1}.spm.spatial.smooth.fwhm      = [FWHM FWHM FWHM];  % smoothing kernel
    matlabbatch{1}.spm.spatial.smooth.dtype     = 0;        % same data type for input and output image
    matlabbatch{1}.spm.spatial.smooth.im        = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix    = 's';
    % save and run job
    save smoothing.mat matlabbatch
    disp(['RUNNING smoothing job for subject ' name_subj])
    spm_jobman('run','smoothing.mat');
    clear matlabbatch;
    disp('Job completed');
    % *********************************************************************
end

%% Conversion of 4D to 3D for use with ArtRepair
if convert
    disp(['Conversion job specification for Subject : ', name_subj]);
    clear matlabbatch;
    % cd so that .mat and .ps files are written in subject dir
    cd(dir_base);
    % get smoothed images
    for sess = 1:n_sess
        scanDir = [dir_base fs sess_prfx num2str(sess)];        
        f   = spm_select('List', scanDir, '^swua0.*\.nii$');
        files  = cellstr([repmat([scanDir fs],size(f,1),1) f]);      
        matlabbatch{sess}.spm.util.split.vol = files;
        matlabbatch{sess}.spm.util.split.outdir = {scanDir}; f = []; files = [];   
    end
    % save and run job
    save convert.mat matlabbatch
    disp(['RUNNING conversion job for subject ' name_subj])
    spm_jobman('run','convert.mat');
    clear matlabbatch;
    disp('Job completed');
    % *********************************************************************
end


end % end of loop for s0 = first:last
