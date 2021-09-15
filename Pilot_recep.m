clc;
close all;
clear;

pilot_pow =-30:5:100;

basestation= basesations(16);
users = usersPlacement(basestation);

range=-50:5:100;
fc =2.4e9;
lambda =3e8/fc;
user_itr =10;
Num_users_ap=zeros(length(pilot_pow),user_itr*length(range));
Num_users_sp=zeros(length(pilot_pow),user_itr*length(range));
%% plotting 
figure();
scatter(basestation(:,1),basestation(:,2),'filled','k');
hold on
for i=1:16
x_1 = users(:,1,i);
y_1= users(:,2,i);
scatter(x_1,y_1);
hold on
end
num_users_ap = zeros(length(pilot_pow),length(range));
num_users_sp = zeros(length(pilot_pow),length(range));
US_AP=1;
for itr =1:user_itr


SNR_AP=zeros(length(pilot_pow),5,16);
SNR_SP=zeros(length(pilot_pow),5,16);
index=1;
%%   %% figure out (\row)**0.5*(\beta)**0.5

   user_bases_long_short_coff = zeros(5,16,16);% 5 users for ith base of ith cell and 15*5 from (16-1)cell 
%    and i will go from 1 to 16;
% user_bases_long_coff(k,j,i) ---> ith basestation, k th user of j th cell.
%    user_bases_long_short_coff = zeros(5,16,16);
   for bases =1:16
       for cells=1:16
           for us = 1:5
               dist = sqrt((basestation(bases,1)-users(us,1,cells))^2 +  (basestation(bases,2)-users(us,2,cells))^2);
               
               eta =-4;
               gaussian_dist = 8*randn(1);
               d0 = 100;%100mts
               pathloss = fspl(d0,lambda);
               ploss = -pathloss+ 10*eta*log10(dist/d0) + gaussian_dist;
               h = (randn(1,1) + 1i*randn(1,1))/sqrt(2);
               etaf = 10^(ploss/10);
               user_bases_long_short_coff(us,cells,bases) = sqrt(dist^(eta))*h;
               
               
           end
       end
   end



%%

for pilot_power= pilot_pow
% Basestation_performance = zeros(length(basestation_power),16,2);
% BER = zeros(length(basestation_power),2);
sec=1;
sec1=1;
sec2=1;
sec3=1;
 
   interference_power = pilot_power;
   mod_pilots = zeros(5,5,length(basestation));   
   pilotPow = 10^(pilot_power/10);

%%
   


   for bases=1:length(basestation)
        [mod_pilots(:,:,bases)]=PILOTS(pilotPow);
   end
     
%% Real_channel 
real_channel =zeros(5,1,16);
for i =1:16
    real_channel(:,:,i)=user_bases_long_short_coff(:,i,i);
end


%%    Received_bitstream = zeros(5,length(bitstream),length(basestation));
    
estimated_output = zeros(5,16*5,16); 
   for bases =1:16
      for us =1:5
          sec=1;
          for base_user=1:16
              temp =user_bases_long_short_coff(us,base_user,bases);
              pilot_m = mod_pilots(us,:,base_user);
              estimated_output(us,sec:sec+4,bases) = temp*pilot_m;  
              sec=sec+5;
          end
      end
   end
 %% Non-Noisy received outputs  of pilots at the basestation
   Output_non_noisy = zeros(5,5,16);
   
   for i=1:16
       for us=1:5
           sec=1;val=0;
           for bases=1:16
               val = val+estimated_output(us,sec:sec+4,i);
               sec=sec+5;
           end
           Output_non_noisy(us,:,i)= val;
       end
   end
   
%% Noisy received outputs of pilots at the basestation of Aligned pilots
      Output_noisy = zeros(5,5,16);
      BW =1000;
   No = -124 + 10*log10(BW);   %in dB
    no = db2pow(No); % noise power
%     Noise = zeros(5,16);
   for i=1:16
       for us=1:5
           sec=1;val=0;
           for bases=1:16
               val = val+estimated_output(us,sec:sec+4,i);
               sec=sec+5;
           end
           nsy = no*randn(1,1);
           Output_noisy(us,:,i)= val + nsy;
%          Noise(us,i)= nsy;
       end
   end
   
%% Estimated channel coefficient theoratically for aligned pilots

Non_nsy_Ap_h = zeros(5,5,16);

for i = 1:16
    y=Output_non_noisy(:,:,i);
    x= mod_pilots(:,:,i);
    Non_nsy_Ap_h(:,:,i) = y*x'*(inv(x*x'));
end


nsy_Ap_h = zeros(5,5,16);

for i = 1:16
    y=Output_noisy(:,:,i);
    x= mod_pilots(:,:,i);
    nsy_Ap_h(:,:,i) = y*x'*(inv(x*x'));
end

received_snr =zeros(5,16);
received_signal_energy=zeros(5,16);
received_interference_noise=zeros(5,16);

for k =1:16 %% cells
    sec=1;
    for bases=1:16 %% %%basestation
        if bases ==k
                v1=abs(estimated_output(:,sec:sec+4,k)).^2;
                Sig_pow = sum(v1,2)/5;
                received_signal_energy(:,k)=Sig_pow;
               
        end
        sec=sec+5;
    end
        
            v11 = abs(estimated_output(:,1:sec-6,k)).^2;
            lenV11 = length(v11);
            v21 = sum(v11,2);
            
            v12 = abs(estimated_output(:,sec+5:16*5,k)).^2;
            lenV12 = length(v12);
            v22 = sum(v12,2);
            
            N = lenV12 +lenV11;
            Total_sum =(v21+v22)/N;
            intr_power = Total_sum/N;
            
            received_interference_noise(:,k)=intr_power;
            
end
        
%     end
%     nsy = sum(abs(Noise(:,bases)).^2);
    received_snr =received_signal_energy./(received_interference_noise+no);


%% Noisy received outputs of pilots at the basestation of shifted pilots
      Output_noisy_Sp = zeros(5,5,16);
      BW =1000;
   No = -124 + 10*log10(BW);   %in dB
    no = db2pow(No); % noise power
%     Noise = zeros(5,16);
sec=1;
   for i=1:16
       for us=1:5
           Output_noisy_Sp(us,:,i)=estimated_output(us,sec:sec+4,i)
           nsy = no*randn(1,1);
           Output_noisy_Sp(us,:,i)= Output_noisy_Sp(us,:,i) + nsy;
%          Noise(us,i)= nsy;
       end
       sec=sec+5;
   end



%% for the case of shifted pilots

nsy_Sp_h = zeros(5,5,16);

for i = 1:16
    y=Output_noisy_Sp(:,:,i);
    x= mod_pilots(:,:,i);
    nsy_Sp_h(:,:,i) = y*x'*(inv(x*x'));
end



received_SP_snr =zeros(5,16);
received_signal_SP_energy=zeros(5,16);
for k =1:16 %% cells
    sec=1;
    for bases=1:16 %% %%basestation
        if bases ==k
                v1=abs(estimated_output(:,sec:sec+4,bases)).^2;
                lenV1=length(v1);
                Sig_pow = sum(v1,2)/lenV1;
                received_signal_SP_energy(:,k)=Sig_pow;
        end
        sec=sec+5;
    end
    received_SP_snr =received_signal_SP_energy./no;
end


%% extracting the final channel coefficients
channel_matrix_AP = zeros(5,16);
channel_matrix_SP =zeros(5,16);
for base = 1:16
    channel_matrix_SP(:,base)=sum(nsy_Sp_h(:,:,base),2);
    channel_matrix_AP(:,base)=sum(nsy_Ap_h(:,:,base),2);
end



SNR_AP(index,:,:)= received_snr;
SNR_SP(index,:,:)= received_SP_snr;
index=index+1;
end

%% Plot num_user vs power


for sirt=1:length(pilot_pow);
    r=1;
    for threshold=range
        num_users_ap(sirt,r)=num_users_ap(sirt,r)+sum(sum(10*log10(SNR_AP(sirt,:,:))>threshold))./80;
        num_users_sp(sirt,r)=num_users_sp(sirt,r)+sum(sum(10*log10(SNR_SP(sirt,:,:))>threshold))./80;
        r=r+1;
    end
end

end
%% PLOTS
figure();
for i =1:length(pilot_pow)
plot(range,num_users_sp(i,:)/10);

hold on;

end
xlabel('SINR');
ylabel('Fraction of Users above SINR(dB)');
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%% AP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basestation_num=1;

figure();
for i =1:5% SNR response of users at basestation 1
    y = SNR_AP(:,i,basestation_num);
    plot(pilot_pow,10*log10(y));
    hold on
end
xlabel('Transmitted SNR');
ylabel('Received SNR');
title('Transmitted SNR vs Received SNR (Aligned Pilots)');
grid on

BER_AP = 0.5*(1- abs((SNR_AP./(2+SNR_AP)).^0.5));

figure();
for i =1:5
    y = BER_AP(:,i,basestation_num);
    X = SNR_AP(:,i,basestation_num);
    plot(10*log10(X),y);
    hold on
end
xlabel('Received SNR');
ylabel('BER');
title('BER vs Received SNR (Aligned Pilots)');
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%% SP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure();
for i =1:5
    y = SNR_SP(:,i,basestation_num);
    plot(pilot_pow,10*log10(y));
    hold on
end
xlabel('Transmitted SNR');
ylabel('Received SNR');
title('Transmitted SNR vs Received SNR(Shifted Pilots)');
grid on

BER_SP = 0.5*(1- abs((SNR_SP./(2+SNR_SP)).^0.5));

figure();
for i =1:5
    y = BER_SP(:,i,basestation_num);
    X = SNR_SP(:,i,basestation_num);
    plot(10*log10(X),y);
    hold on
end
xlabel('Received SNR');
ylabel('BER');
title('BER vs Received SNR(Shifted Pilots)');
grid on


%%%%%%%%%%%%%%%%%%%%%AP vs SP%%%%%%%%%%%%%%%%%%%%%
figure();
    y = BER_SP(:,1,basestation_num);
    X = 1:length(y);
    plot(pilot_pow,y);
    hold on
    yA = BER_AP(:,1,basestation_num);
    plot(pilot_pow,yA,'^');
    legend('Shifted Pilots','Aligned Pilots')

xlabel('Received SNR');
ylabel('BER');
title('BER Comparision of Aligned Pilots and Shifted Pilots against Received SNR');
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure();
% for i =1:5% SNR response of users at basestation 1
    y = SNR_AP(:,i,basestation_num);
    plot(pilot_pow,10*log10(y));
    hold on
% end
% for i =1:5
    y = SNR_SP(:,i,basestation_num);
    plot(pilot_pow,10*log10(y));
%     hold on
% end
legend('Aligned Pilots','Shifted Pilots')
xlabel('Transmitted SNR');
ylabel('Received SNR');
title('Transmitted SNR vs Received SNR(Shifted Pilots & Aligned pilots)');

grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Downlink transmission
% let the length of each bitstream be 336, so 
% lets say each basestation transfers bits to its users the same bits 
% so for 16 base-sattion we need 16x336 bits.
len_bits=56;
bitstream_16 = randi([0,1],len_bits,16);
received_bits_AP =zeros(len_bits,5,16);
received_bits_SP =zeros(len_bits,5,16);
db_trans_power=-30:10:10;
AP_corr =zeros(5,16,length(db_trans_power));
SP_corr =zeros(5,16,length(db_trans_power));
index=1;
for tp = db_trans_power
trans_power=10^(tp/10);
for basestation = 1:16
received_bits_AP(:,:,basestation) = downlink_transmission(user_bases_long_short_coff(:,basestation,basestation),channel_matrix_AP(:,basestation),trans_power,bitstream_16(:,basestation));
received_bits_SP(:,:,basestation) = downlink_transmission(user_bases_long_short_coff(:,basestation,basestation),channel_matrix_SP(:,basestation),trans_power,bitstream_16(:,basestation));
for us =1:5
AP_corr(us,basestation,index) = AP_corr(us,basestation,index)+ sum(received_bits_AP(:,us,basestation)==bitstream_16(:,basestation));
SP_corr(us,basestation,index) = SP_corr(us,basestation,index)+ sum(received_bits_SP(:,us,basestation)==bitstream_16(:,basestation));
end
end
index=index+1;
end



