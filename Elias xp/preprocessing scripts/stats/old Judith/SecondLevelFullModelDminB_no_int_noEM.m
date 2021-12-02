%for sub = [3:33]
    %if sub < 10
    %    subdir = ['C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub00' int2str(sub) '\stats'];
    %     cd(subdir);
    %     subRef = ['0' int2str(sub)];
    %else
    %     subdir = ['C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub0' int2str(sub) 'stats'];
    %     cd(subdir);
    %     subRef = [int2str(sub)];
    %end
    
    %choose which contrasts to run
        con1 = 1;
        con2 = 1;
        con3 = 1;
        con4 = 1;
        con5 = 1;
        con6 = 1;
        con7 = 1;
        con8 = 1;
        
    %%THESE SUBJECTS SCORED BELOW CHANCE IN THE LAST BLOCK: 9, 27, 28
    %%THIS SUBJECT SCORED BAD IN ALL LAST THREE BLOCKS: 9
    %%THESE SUBJECTS HAD UNUSUABLE EYE TRACKING DATA: 3,4,6
    %%EXCLUDE THESE
    
    if con1
        %%contrast 1
        mkdir('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast1_EVb_23'); %comparing nonsalient and salient stimuli on EV
        matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast1_EVb_23'};
        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub003\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub004\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub005\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub006\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub007\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub008\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub009\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub010\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub011\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub012\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub013\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub014\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub015\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub016\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub017\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub018\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub019\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub020\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub021\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub022\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub023\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub024\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub025\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub026\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub027\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub028\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub029\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub030\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub031\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub032\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub033\statsFULLModelDminB_no_int_noEM\con_0001.nii,1'
                                                                  };
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;         
        
         cd('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast1_EVb_23')
         save EVb_23.mat matlabbatch
         spm_jobman('run','EVb_23.mat');
    end
    
    if con2
        %%contrast 2
        mkdir('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast2_EVsal_23');
        matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast2_EVsal_23'};
        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub003\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub004\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub005\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub006\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub007\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub008\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub009\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub010\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub011\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub012\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub013\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub014\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub015\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub016\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub017\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub018\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub019\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub020\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub021\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub022\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub023\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub024\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub025\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub026\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub027\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub028\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub029\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub030\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub031\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub032\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub033\statsFULLModelDminB_no_int_noEM\con_0002.nii,1'
                                                                  };
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;  
        
        cd('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast2_EVsal_23')
        save EVsal_23.mat matlabbatch
        spm_jobman('run','EVsal_23.mat');
     end
    
    if con3
        %%contrast 3
        mkdir('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast3_SAL_23');
        matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast3_SAL_23'};
        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub003\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub004\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub005\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub006\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub007\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub008\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub009\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub010\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub011\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub012\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub013\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub014\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub015\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub016\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub017\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub018\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub019\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub020\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub021\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub022\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub023\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub024\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub025\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub026\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub027\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub028\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub029\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub030\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub031\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub032\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub033\statsFULLModelDminB_no_int_noEM\con_0003.nii,1'
                                                                  }
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
        
         cd('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast3_SAL_23')
         save SAL_23.mat matlabbatch
         spm_jobman('run','SAL_23.mat');
    end
    
    if con4
        %%contrast 4
        mkdir('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast4_PEb23');
        matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast4_PEb23'};
        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub003\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub004\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub005\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub006\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub007\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub008\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub009\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub010\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub011\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub012\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub013\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub014\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub015\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub016\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub017\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub018\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub019\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub020\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub021\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub022\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub023\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub024\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub025\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub026\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub027\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub028\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub029\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub030\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub031\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub032\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub033\statsFULLModelDminB_no_int_noEM\con_0004.nii,1'
                                                                  };
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;          
        
         cd('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast4_PEb23')
         save PEb23.mat matlabbatch
         spm_jobman('run','PEb23.mat');
    end
    
    if con5
        %%contrast 5
        mkdir('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast5_PEsal23');
        matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast5_PEsal23'};
        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub003\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub004\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub005\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub006\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub007\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub008\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub009\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub010\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub011\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub012\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub013\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub014\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub015\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub016\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub017\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub018\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub019\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub020\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub021\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub022\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub023\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub024\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub025\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub026\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub027\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub028\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub029\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub030\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub031\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub032\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub033\statsFULLModelDminB_no_int_noEM\con_0005.nii,1'
                                                                  };
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;          
       
        cd('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast5_PEsal23')
        save PEsal23.mat matlabbatch
        spm_jobman('run','PEsal23.mat');
    end
    
    if con6
        %%contrast 6
        mkdir('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast6_SALoutc23');
        matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast6_SALoutc23'};
        %%
        matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = {
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub003\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub004\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub005\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub006\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub007\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub008\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  %'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub009\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub010\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub011\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub012\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub013\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub014\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub015\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub016\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub017\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub018\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub019\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub020\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub021\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub022\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub023\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub024\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub025\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub026\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub027\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub028\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub029\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub030\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub031\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub032\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  'C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\sub033\statsFULLModelDminB_no_int_noEM\con_0006.nii,1'
                                                                  };
        %%
        matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
        matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
        matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
        matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
        matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;   
        
         cd('C:\Users\JSchomaker.JSchomaker-PC\Desktop\statsFMRI\StatsGeneral\2_3stim\ModelDminB_no_int_noEM\contrast6_SALoutc23')
         save SALoutc23.mat matlabbatch
         spm_jobman('run','SALoutc23.mat');
    end
         
     

     
