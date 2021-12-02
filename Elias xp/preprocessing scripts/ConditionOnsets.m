 
%get onsets for congruent incongruent
condition_ind = find(ismember(strings(1,:),'condition'));
 

congruent_row = find(ismember(raw(:,condition_ind),'congruent'));
incongruent_row = find(ismember(raw(:,condition_ind),'incongruent'));

%intersect block
cb1 = intersect(block1,congruent_row);
cb2 = intersect(block2,congruent_row);
cb3 = intersect(block3,congruent_row);
icb1 = intersect(block1,incongruent_row);
icb2 = intersect(block2,incongruent_row);
icb3 = intersect(block3,incongruent_row);

%Onsets
congruent1_ons = (numbers(cb1-1,game_disp_ind)-trigger1_delay)/1000;
congruent2_ons = (numbers(cb2-1,game_disp_ind)-trigger2_delay)/1000;
congruent3_ons = (numbers(cb3-1,game_disp_ind)-trigger3_delay)/1000;
incongruent1_ons = (numbers(icb1-1,game_disp_ind)-trigger1_delay)/1000;
incongruent2_ons = (numbers(icb2-1,game_disp_ind)-trigger2_delay)/1000;
incongruent3_ons = (numbers(icb3-1,game_disp_ind)-trigger3_delay)/1000;
                                
%Durations
congruent1_dur = (numbers(cb1-1,resp_ind)-100)/1000;
congruent2_dur = (numbers(cb2-1,resp_ind)-100)/1000;
congruent3_dur = (numbers(cb3-1,resp_ind)-100)/1000;
incongruent1_dur = (numbers(icb1-1,resp_ind)-100)/1000;
incongruent2_dur = (numbers(icb2-1,resp_ind)-100)/1000;
incongruent3_dur = (numbers(icb3-1,resp_ind)-100)/1000;



                                                
                                                