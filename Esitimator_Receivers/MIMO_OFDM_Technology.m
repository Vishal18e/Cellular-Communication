%% MIMO OFDM Technology

clc;
close all; 
clear all;

Nsub = 256;
Ncp = round(Nsub/4);
nBlocks = 100;
L=2;
r=2;
t=2;
EbdB = [1:4:45];
Eb=10.^(EbdB/10);
No=1;
SNR=2*Eb/No;
SNRdB=10*log10(SNR);
BER = zeros(size(SNRdB));
BERt = zeros(size(SNRdB));

for bx = 1:nBlocks
    ChNoise = sqrt(No/2)*(randn(r,L+Nsub +Ncp-1)+1j*(randn(r,L+Nsub+Ncp-1)));
    H = 1/sqrt(2)*(randn(r,L,t)+1j*(randn(r,L,t)));
    BitsI = randi([0,1],[t,Nsub]);
    BitsQ = randi([0,1],[t,Nsub]);
    Sym = (2*BitsI -1)+1j*(2*BitsQ-1);
    Hfft = zeros(r,Nsub,t);
    for tx =1:t
        Hfft(:,:,tx) = fft([H(:,:,tx),zeros(r,Nsub-L)],[],2);
    end
    
    for K =1:length(SNRdB)
        LoadedSym = sqrt(Eb(K))*Sym;
        TxSamples = ifft(LoadedSym,[],2);
        TxSamCp = [TxSamples(:,Nsub-Ncp+1:Nsub),TxSamples];
        RxSamCp =zeros(r,L+Nsub+Ncp -1);
        
        for rx =1:r
            for tx =1:t
                RxSamCp(rx,:) = RxSamCp(rx,:) + conv(H(rx,:,tx),TxSamCp(tx,:));
            end
        end
        
        RxSamCp = RxSamCp + ChNoise;
        RxSamples = RxSamCp(:,Ncp+1:Ncp+Nsub);
        RxSym = fft(RxSamples,[],2);
        
        for nx =1:Nsub
            Hsub = squeeze(Hfft(:,nx,:));
            ZFout = pinv(Hsub)*RxSym(:,nx);
            DecBitsI_ZF = (real(ZFout)>0);
            DecBitsQ_ZF = (imag(ZFout)>0);
            BER(K) = BER(K) + sum(sum(DecBitsI_ZF~=BitsI(:,nx)))+sum(sum(DecBitsQ_ZF~=BitsQ(:,nx)));
        end
    end
end


BER = BER/nBlocks/Nsub/t/2;
SNReff = SNR*L/Nsub;
L = r-t+1;
BERt = nchoosek(2*L-1, L)/2^L./SNReff.^L;

semilogy(SNRdB,BER,'r -. ','linewidth',3.0,'MarkerFaceColor','r','MarkerSize',9.0);
hold on;
semilogy(SNRdB,BERt,'b  s','linewidth',3.0,'MarkerFaceColor','b','MarkerSize',9.0);
axis tight;
grid on;
legend('BER','BER Theory')
xlabel('SNR (dB)');
ylabel('BER');
title('BER vs SNR(dB) for MIMO-OFDM');

