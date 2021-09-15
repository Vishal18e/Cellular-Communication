function [recived_bits] = downlink_transmission(h,h_estimated,trans_power,bitstream)
% h = zeros(5,i);
h
h_estimated
length_bitstream = length(bitstream);
num_frame = length_bitstream/56;
recived_bits = zeros(length_bitstream,5);
sec =1;
for i = 1:num_frame
    bit_frame = bitstream(sec:sec+55);
    
%% BPSK Modulation
bpsk = comm.BPSKModulator();
data_bpsk_mod = bpsk(bit_frame);
data_bpsk_mod=data_bpsk_mod*(trans_power^0.5);

BW =1000;
No = -124 + 10*log10(BW);   %in dB
no = db2pow(No);

%% Channel
% h = zeros(5,i); where i the cell number
Channel_output = zeros(5,56);
    for user =1:5
        nsy = no*randn(1,1);
        Channel_output(user,:) = data_bpsk_mod*h(user)+nsy;
    end
% end

demod_rxsig = zeros(5,56);
demodulator=comm.BPSKDemodulator();
for user=1:5
    h_estimated(user);
    temp=Channel_output(user,:)./h_estimated(user);
%     size(temp')
%     demodulator(temp')
%     demod_rxsig(user,:) 
    demod_rxsig(user,:) = (demodulator(temp'))';
end

recived_bits(sec:sec+55,:) = demod_rxsig';
sec =sec+56;
end




% 
% %%
% pilot_data = [data_bpsk_mod(1:4)',data_bpsk_mod',data_bpsk_mod(1:4)'];
% 
% %% IFFT
% Ifft_data = ifft(pilot_data,64);
% 
% %% Cyclic Prefix
% 
% Cp_pilot_data =zeros(1,80);
% Cp_pilot_data(1,1:16) = Ifft_data(1,49:64);
% Cp_pilot_data(1,17:80) = Ifft_data(1,:);
% 
% %% Channel
% % h = zeros(5,16,i);
% Channel_output = zeros(80,5);
% % for User_basestation=1:16
%     for user =1:5
% %         Channel_output(:,user,User_basestation) = Cp_pilot_data*h(user,User_basestation);
%         Channel_output(:,user) = Cp_pilot_data*h(user);
%     end
% % end
% 
% %% removing CP and fft and sync.
% rx_sig = zeros(56,5);
% 
% 
% % for User_basestation=1:16
%     for user =1:5
%         nsy = no*randn(1,1);
%         temp = fft(Channel_output(17:80,user));
%         rx_sig(:,user) = temp(5:60)+nsy;
%     end
% % end
% fprintf("user_coord_interferences loop %d\n",i);
% %% demodulation
% demod_rxsig = zeros(56,5);
% demodulator=comm.BPSKDemodulator();
% % for User_basestation=1:16
%     for user =1:5
%         demod_rxsig(:,user) = demodulator(rx_sig(:,user));
%     end
% % end
% recived_bits(sec:sec+55,:) = demod_rxsig;
% sec =sec+56;
% end