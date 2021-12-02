dir_base = 'D:\reward_selective_attention_elias\fMRI';
cd(dir_base)
subnum = 18

for k = subnum
    if subnum < 9;
        physio = [dir_base '\DATA\sub00' num2str(subnum) '\physio'];
        cd(physio)
        dir 
    elseif subnum > 9;
        physio = [dir_base '\DATA\sub0' num2str(subnum) '\physio'];
        cd(physio)
        dir
        
    end
end