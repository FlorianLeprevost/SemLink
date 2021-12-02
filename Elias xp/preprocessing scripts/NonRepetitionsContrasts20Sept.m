%% Compute Contrast Matrices for Counterbalanced Groups

exclude = [3 4 19 23 26 29 30 32];

for subnum = 1:32;
    if ismember(subnum,exclude); %continue with next iteration when sub is in exclude!
        continue
    end
    
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    %% Selection v. Baseline per Dimension

    SelReg = 10; %Index of Selection Regressor
    SelBaseReg = 11; %Index of Selection Baseline Regressor

    %% P-Selection v. Baseline
    if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
        run1(SelReg) = 1; run1(SelBaseReg) = -1; run2(SelReg) = 
        Psel = [run1 run2 run3];
    elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run2(SelReg) = 1; run2(SelBaseReg) = -1;
        Psel = [run1 run2 run3];
    elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run3(SelReg) = 1; run3(SelBaseReg) = -1;
        Psel = [run1 run2 run3];
    end

    %% reset regs

    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    %% L-Selection v. Baseline
    if mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(SelReg) = 1; run1(SelBaseReg) = -1;
        Lsel = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run2(SelReg) = 1; run2(SelBaseReg) = -1;
        Lsel = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run3(SelReg) = 1; run3(SelBaseReg) = -1;
        Lsel = [run1 run2 run3];
    end

    %% reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    %% T-Selection v. Baseline
    if mod(subnum,12) == 8 || mod(subnum,12) == 9 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(SelReg) = 1; run1(SelBaseReg) = -1;
        Tsel = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run2(SelReg) = 1; run2(SelBaseReg) = -1;
        Tsel = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
        run3(SelReg) = 1; run3(SelBaseReg) = -1;
        Tsel = [run1 run2 run3];
    end

    %% Save .mat files in subs directory '\contrasts

    if subnum <= 9;
        cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' num2str(subnum) '\contrasts']);
    elseif subnum > 9;
        cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' num2str(subnum) '\contrasts']);
    end

    %% reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    %% Congruent v Incongruent Games per Dimension (CHOICE)

    ConChoiceReg = 1; %Index of Congruent Game Regressor
    IconChoiceReg = 3; %Index of Incongruent Game Regressor

    % P-Con v Icon
    if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
        run1(ConChoiceReg) = 2; run1(IconChoiceReg) = -2;
        run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
        run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
        P_CHOICE = [run1 run2 run3];
    elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
        run2(ConChoiceReg) = 2; run2(IconChoiceReg) = -2;
        run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
        P_CHOICE = [run1 run2 run3];
    elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
        run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
        run3(ConChoiceReg) = 2; run3(IconChoiceReg) = -2;
        P_CHOICE = [run1 run2 run3];
    end

    % reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    % L-Con v Icon
    if mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(ConChoiceReg) = 2; run1(IconChoiceReg) = -2;
        run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
        run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
        L_CHOICE = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
        run2(ConChoiceReg) = 2; run2(IconChoiceReg) = -2;
        run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
        L_CHOICE = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
        run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
        run3(ConChoiceReg) = 2; run3(IconChoiceReg) = -2;
        L_CHOICE = [run1 run2 run3];
    end

    % reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    % T-Con v Icon
    if mod(subnum,12) == 8 || mod(subnum,12) == 9 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConChoiceReg) = 2; run1(IconChoiceReg) = -2;
        run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
        run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
        T_CHOICE = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
        run2(ConChoiceReg) = 2; run2(IconChoiceReg) = -2;
        run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
        T_CHOICE = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
        run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
        run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
        run3(ConChoiceReg) = 2; run3(IconChoiceReg) = -2;
        T_CHOICE = [run1 run2 run3];
    end  

    %% Congruent v Incongruent Games per Dimension (POSITIVE FEEDBACK)

    ConFBposReg = 5; %Index of Congruent Game Regressor
    IconFBposReg = 7; %Index of Incongruent Game Regressor

    % P-Con v Icon FBpos
    if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
        run1(ConFBposReg) = 2; run1(IconFBposReg) = -2;
        run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
        run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
        P_FBpos = [run1 run2 run3];
    elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
        run2(ConFBposReg) = 2; run2(IconFBposReg) = -2;
        run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
        P_FBpos = [run1 run2 run3];
    elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
        run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
        run3(ConFBposReg) = 2; run3(IconFBposReg) = -2;
        P_FBpos = [run1 run2 run3];
    end

    % reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    % L-Con v Icon FBpos
    if mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(ConFBposReg) = 2; run1(IconFBposReg) = -2;
        run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
        run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
        L_FBpos = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
        run2(ConFBposReg) = 2; run2(IconFBposReg) = -2;
        run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
        L_FBpos = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
        run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
        run3(ConFBposReg) = 2; run3(IconFBposReg) = -2;
        L_FBpos = [run1 run2 run3];
    end

    % reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    % T-Con v Icon FBpos
    if mod(subnum,12) == 8 || mod(subnum,12) == 9 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConFBposReg) = 2; run1(IconFBposReg) = -2;
        run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
        run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
        T_FBpos = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
        run2(ConFBposReg) = 2; run2(IconFBposReg) = -2;
        run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
        T_FBpos = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
        run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
        run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
        run3(ConFBposReg) = 2; run3(IconFBposReg) = -2;
        T_FBpos = [run1 run2 run3];
    end  

    %% Congruent v Incongruent Games per Dimension (POSITIVE FEEDBACK)

    ConFBnegReg = 6; %Index of Congruent Game Regressor
    IconFBnegReg = 8; %Index of Incongruent Game Regressor

    % P-Con v Icon FBneg
    if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
        run1(ConFBnegReg) = 2; run1(IconFBnegReg) = -2;
        run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
        run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
        P_FBneg = [run1 run2 run3];
    elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
        run2(ConFBnegReg) = 2; run2(IconFBnegReg) = -2;
        run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
        P_FBneg = [run1 run2 run3];
    elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
        run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
        run3(ConFBnegReg) = 2; run3(IconFBnegReg) = -2;
        P_FBneg = [run1 run2 run3];
    end

    % reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    % L-Con v Icon FBneg
    if mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(ConFBnegReg) = 2; run1(IconFBnegReg) = -2;
        run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
        run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
        L_FBneg = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
        run2(ConFBnegReg) = 2; run2(IconFBnegReg) = -2;
        run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
        L_FBneg = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
        run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
        run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
        run3(ConFBnegReg) = 2; run3(IconFBnegReg) = -2;
        L_FBneg = [run1 run2 run3];
    end

    % reset regs
    run1 = zeros(38,1)';
    run2 = zeros(38,1)';
    run3 = zeros(38,1)';

    % T-Con v Icon FBneg
    if mod(subnum,12) == 8 || mod(subnum,12) == 9 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
        run1(ConFBnegReg) = 2; run1(IconFBnegReg) = -2;
        run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
        run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
        T_FBneg = [run1 run2 run3];
    elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
        run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
        run2(ConFBnegReg) = 2; run2(IconFBnegReg) = -2;
        run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
        T_FBneg = [run1 run2 run3];
    elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
        run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
        run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
        run3(ConFBnegReg) = 2; run3(IconFBnegReg) = -2;
        T_FBneg = [run1 run2 run3];
    end  
    
    %% Individual NonRepContrasts for subs where one pmod is not uniquely specified (1,13,16,31)
    
    if subnum == 1;
        % sub1 (run2 and run3)
        %both pmods
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; run1(4) = -1;
        sub1_allmods = [run1 run2 run3];

        %conmod
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1;
        sub1_conmod = [run1 run2 run3];
    elseif subnum == 13;    
        %sub 13 run2
        %both pmods
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; run1(4) = -1;
        run3(2) = 1; run3(4) = -1;
        sub13_allmods = [run1 run2 run3];
    
        %conmod
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; run3(2) = 1;
        sub13_conmod = [run1 run2 run3];
    elseif subnum == 16;    
        %sub16 run3
        %both pmods
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; run1(4) = -1;
        run2(2) = 1; run2(4) = -1;
        sub16_allmods = [run1 run2 run3];

        %conmod
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; 
        run2(2) = 1; 
        sub16_conmod = [run1 run2 run3];
    elseif subnum == 31;
        %sub31 run2
        %both pmods
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; run1(4) = -1;
        run3(2) = 1; run3(4) = -1;
        sub31_allmods = [run1 run2 run3];

        %conmod
        run1 = zeros(38,1)';    run2 = zeros(38,1)';    run3 = zeros(38,1)';
        run1(2) = 1; run3(2) = 1;
        sub31_conmod = [run1 run2 run3];
    end
    
    
    
    %% Save .mat files in subs directory '\contrasts

    if subnum <= 9;
        cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' num2str(subnum) '\contrasts']);
    else;
        cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' num2str(subnum) '\contrasts']);
    end
    
    if subnum == 1;
        save('NonRepContrasts.mat','Psel','Lsel','Tsel','P_CHOICE','L_CHOICE','T_CHOICE','P_FBpos','P_FBneg','L_FBpos','L_FBneg','T_FBpos','T_FBneg','sub1_allmods','sub1_conmod')
    elseif subnum == 13;
        save('NonRepContrasts.mat','Psel','Lsel','Tsel','P_CHOICE','L_CHOICE','T_CHOICE','P_FBpos','P_FBneg','L_FBpos','L_FBneg','T_FBpos','T_FBneg','sub13_allmods','sub13_conmod')
    elseif subnum == 16;
        save('NonRepContrasts.mat','Psel','Lsel','Tsel','P_CHOICE','L_CHOICE','T_CHOICE','P_FBpos','P_FBneg','L_FBpos','L_FBneg','T_FBpos','T_FBneg','sub16_allmods','sub16_conmod')
    elseif subnum == 31;
        save('NonRepContrasts.mat','Psel','Lsel','Tsel','P_CHOICE','L_CHOICE','T_CHOICE','P_FBpos','P_FBneg','L_FBpos','L_FBneg','T_FBpos','T_FBneg','sub31_allmods','sub31_conmod')
    else;
        save('NonRepContrasts.mat','Psel','Lsel','Tsel','P_CHOICE','L_CHOICE','T_CHOICE','P_FBpos','P_FBneg','L_FBpos','L_FBneg','T_FBpos','T_FBneg')
    end
    
    disp(['Store NonRepContrasts.mat for sub' num2str(subnum)])
end

    
    
    


