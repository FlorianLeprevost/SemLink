%% Compute Contrast Matrices for Counterbalanced Groups

subnum = 32;

run1 = zeros(38,1)';
run2 = zeros(38,1)';
run3 = zeros(38,1)';

%% Selection v. Baseline per Dimension

SelReg = 10; %Index of Selection Regressor
SelBaseReg = 11; %Index of Selection Baseline Regressor

%% P-Selection v. Baseline
if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
    run1(SelReg) = 1; run1(SelBaseReg) = -1;
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

save PSel.mat,Psel;
save Lsel.mat,Lsel; 
save Tsel.mat,Tsel; 

%% reset regs
run1 = zeros(38,1)';
run2 = zeros(38,1)';
run3 = zeros(38,1)';

%% Congruent v Incongruent Games per Dimension (CHOICE)

ConChoiceReg = 1; %Index of Congruent Game Regressor
IconChoiceReg = 3; %Index of Incongruent Game Regressor

%% P-Con v Icon
if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
    run1(ConChoiceReg) = 2; run1(IconChoiceReg) = -2;
    run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
    run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
    Pcon = [run1 run2 run3];
elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
    run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
    run2(ConChoiceReg) = 2; run2(IconChoiceReg) = -2;
    run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
    Pcon = [run1 run2 run3];
elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
    run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
    run3(ConChoiceReg) = 2; run3(IconChoiceReg) = -2;
    Pcon = [run1 run2 run3];
end

%% reset regs
run1 = zeros(38,1)';
run2 = zeros(38,1)';
run3 = zeros(38,1)';

%% L-Con v Icon
if mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
    run1(ConChoiceReg) = 2; run1(IconChoiceReg) = -2;
    run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
    run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
    Lcon = [run1 run2 run3];
elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
    run2(ConChoiceReg) = 2; run2(IconChoiceReg) = -2;
    run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
    Lcon = [run1 run2 run3];
elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
    run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
    run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
    run3(ConChoiceReg) = 2; run3(IconChoiceReg) = -2;
    Lcon = [run1 run2 run3];
end

%% reset regs
run1 = zeros(38,1)';
run2 = zeros(38,1)';
run3 = zeros(38,1)';

%% T-Con v Icon
if mod(subnum,12) == 8 || mod(subnum,12) == 9 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConChoiceReg) = 2; run1(IconChoiceReg) = -2;
    run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
    run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
    Tcon = [run1 run2 run3];
elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
    run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
    run2(ConChoiceReg) = 2; run2(IconChoiceReg) = -2;
    run3(ConChoiceReg) = -1; run3(IconChoiceReg) = 1;
    Tcon = [run1 run2 run3];
elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
    run1(ConChoiceReg) = -1; run1(IconChoiceReg) = 1;
    run2(ConChoiceReg) = -1; run2(IconChoiceReg) = 1;
    run3(ConChoiceReg) = 2; run3(IconChoiceReg) = -2;
    Tcon = [run1 run2 run3];
end  

%% Congruent v Incongruent Games per Dimension (POSITIVE FEEDBACK)

ConFBposReg = 5; %Index of Congruent Game Regressor
IconFBposReg = 7; %Index of Incongruent Game Regressor

% P-Con v Icon FBpos
if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
    run1(ConFBposReg) = 2; run1(IconFBposReg) = -2;
    run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
    run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
    PconFBpos = [run1 run2 run3];
elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
    run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
    run2(ConFBposReg) = 2; run2(IconFBposReg) = -2;
    run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
    PconFBpos = [run1 run2 run3];
elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
    run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
    run3(ConFBposReg) = 2; run3(IconFBposReg) = -2;
    PconFBpos = [run1 run2 run3];
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
    LconFBpos = [run1 run2 run3];
elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
    run2(ConFBposReg) = 2; run2(IconFBposReg) = -2;
    run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
    LconFBpos = [run1 run2 run3];
elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
    run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
    run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
    run3(ConFBposReg) = 2; run3(IconFBposReg) = -2;
    LconFBpos = [run1 run2 run3];
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
    TconFBpos = [run1 run2 run3];
elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
    run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
    run2(ConFBposReg) = 2; run2(IconFBposReg) = -2;
    run3(ConFBposReg) = -1; run3(IconFBposReg) = 1;
    TconFBpos = [run1 run2 run3];
elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
    run1(ConFBposReg) = -1; run1(IconFBposReg) = 1;
    run2(ConFBposReg) = -1; run2(IconFBposReg) = 1;
    run3(ConFBposReg) = 2; run3(IconFBposReg) = -2;
    TconFBpos = [run1 run2 run3];
end  

%% Congruent v Incongruent Games per Dimension (POSITIVE FEEDBACK)

ConFBnegReg = 6; %Index of Congruent Game Regressor
IconFBnegReg = 8; %Index of Incongruent Game Regressor

% P-Con v Icon FBneg
if mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 2 || mod(subnum,12) == 3;
    run1(ConFBnegReg) = 2; run1(IconFBnegReg) = -2;
    run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
    run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
    PconFBneg = [run1 run2 run3];
elseif mod(subnum,12) == 4 || mod(subnum,12) == 5 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
    run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
    run2(ConFBnegReg) = 2; run2(IconFBnegReg) = -2;
    run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
    PconFBneg = [run1 run2 run3];
elseif mod(subnum,12) == 6 || mod(subnum,12) == 7 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
    run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
    run3(ConFBnegReg) = 2; run3(IconFBnegReg) = -2;
    PconFBneg = [run1 run2 run3];
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
    LconFBneg = [run1 run2 run3];
elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 10 || mod(subnum,12) == 11;
    run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
    run2(ConFBnegReg) = 2; run2(IconFBnegReg) = -2;
    run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
    LconFBneg = [run1 run2 run3];
elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 8 || mod(subnum,12) == 9;
    run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
    run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
    run3(ConFBnegReg) = 2; run3(IconFBnegReg) = -2;
    LconFBneg = [run1 run2 run3];
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
    TconFBneg = [run1 run2 run3];
elseif mod(subnum,12) == 2 || mod(subnum,12) == 3 || mod(subnum,12) == 6 || mod(subnum,12) == 7;
    run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
    run2(ConFBnegReg) = 2; run2(IconFBnegReg) = -2;
    run3(ConFBnegReg) = -1; run3(IconFBnegReg) = 1;
    TconFBneg = [run1 run2 run3];
elseif mod(subnum,12) == 0 || mod(subnum,12) == 1 || mod(subnum,12) == 4 || mod(subnum,12) == 5;
    run1(ConFBnegReg) = -1; run1(IconFBnegReg) = 1;
    run2(ConFBnegReg) = -1; run2(IconFBnegReg) = 1;
    run3(ConFBnegReg) = 2; run3(IconFBnegReg) = -2;
    TconFBneg = [run1 run2 run3];
end  
%% Save .mat files in subs directory '\contrasts

if subnum <= 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub00' num2str(subnum) '\contrasts']);
elseif subnum > 9;
    cd(['D:\reward_selective_attention_elias\fMRI\DATA\sub0' num2str(subnum) '\contrasts']);
end

save Pcon.mat,Pcon;
save Lcon.mat,Lcon; 
save Tcon.mat,Tcon; 
    
    
    


