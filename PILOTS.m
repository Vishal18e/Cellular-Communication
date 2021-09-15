%% PILOT MODULATION
function [pilots_bpsk_mod] = PILOTS(pilot_pow)


%% PILOTS FORMATION
% number of users in ase of downlink 
% num_users =4;
user1 = [1,0,0,0,0];
user2 = [0,1,0,0,0];
user3 = [0,0,1,0,0];
user4 = [0,0,0,1,0];
user5 = [0,0,0,0,1];
pilots =[user1;user2;user3;user4;user5];
pilot_amp = pilot_pow^0.5;


%% BPSK Modulation
bpsk = comm.BPSKModulator();
pilots_bpsk_mod =zeros(5,5);
for pilot=1:length(pilots)
   pilots_bpsk_mod(pilot,:)=(bpsk(pilots(pilot,:)')')*pilot_amp; 
end
