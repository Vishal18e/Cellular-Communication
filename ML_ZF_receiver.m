%% BER vs SNR(dB) for ZF/ML Receivers.

clc;
clear;

blockLength = 100;
nBlocks=10000;
r=2;
t=2;
EbdB = 1.0:2.0:19.0;
Eb = 10.^(EbdB/10);
No = 1;
SNR = 2*Eb/No;
SNRdB = 10*log10(SNR);
BER_ZF = zeros(1,length(EbdB));
BER_ML = zeros(1,length(EbdB));
S = [1,1,-1,-1;1,-1,1,-1];
MLout = zeros(t,blockLength);

for blk = 1:nBlocks
    H = 1/sqrt(2)*(randn(r,t) + 1j*randn(r,t));
    BitsI = randi([0,1],t,blockLength);
    Sym = (2*BitsI -1);
    noise = sqrt(No/2)*(randn(r,blockLength)+1j*randn(r,blockLength));
    for K=1:length(EbdB)
        TxSym = sqrt(Eb(K))*Sym;
        RxSym = H*TxSym + noise;
        ZFRx = pinv(H);
        ZFout = ZFRx*RxSym;
        DecBitsI_ZF = (real(ZFout)>0);
        BER_ZF(K) = BER_ZF(K) + sum(sum(DecBitsI_ZF~=BitsI));
        
        TxS = sqrt(Eb(K))*S;
        for vx =1:blockLength
            [decErr, decIdx] = min(sum(abs(repmat(RxSym(:,vx),1,4)-H*TxS).^2,1));
            MLout(:,vx) = TxS(:,decIdx);
        end
        DecBits_ML = (real(MLout)>0);
        BER_ML(K) = BER_ML(K) + sum(sum(DecBits_ML ~= BitsI));
    end  
end

BER_ZF = BER_ZF/blockLength/nBlocks/t;
BER_ML = BER_ML/blockLength/nBlocks/t;

semilogy(SNRdB,BER_ZF,'g - s','linewidth',3.0,'MarkerFaceColor','g','MarkerSize',9.0);
hold on;
semilogy(SNRdB,BER_ML,'r - o','linewidth',3.0,'MarkerFaceColor','r','MarkerSize',9.0);
axis tight;
grid on;
legend('ZF','ML')
xlabel('SNR (dB)');
ylabel('BER');
title('BER vs SNR(dB) for MIMO ZF/ML Receivers');



