close all;
clear;
clc;

nBlocks = 10000; 
r = 1; 
t = 8; 
L = 10;
SNRdB = 0:1:10; 
SNR = 10.^(SNRdB/10); 
No = 1; 
MSE_LS = zeros(1,length(SNRdB)); 
MSE_LMMSE = zeros(1,length(SNRdB)); 
MSE_LSt = zeros(1,length(SNRdB)); 
MSE_LMMSEt = zeros(1,length(SNRdB)); 
for blk = 1:nBlocks
    h = 1/sqrt(2)*(randn(t,1)+1j*randn(t,1));
    noise= sqrt(No/2)*(randn(L,1)+1j*randn(L,1));
    DFTmat = dftmtx(L);
    
    for K =1:length(SNRdB)
        Xp = sqrt(SNR(K))*DFTmat(:,1:t);
        Yp = Xp*h + noise;
        h_LS = pinv(Xp)*Yp;
        MSE_LS(K) = MSE_LS(K) + norm(h-h_LS)^2;
        MSE_LSt(K) = MSE_LSt(K) + abs(No*trace(inv(Xp'*Xp)));
        
        h_LMMSE = inv(Xp'*Xp + No*eye(t))*Xp'*Yp;
        MSE_LMMSE(K) = MSE_LMMSE(K) + norm(h-h_LMMSE)^2;
        MSE_LMMSEt(K) = MSE_LMMSEt(K) + abs(trace(inv(Xp'*Xp/No+eye(t))));
        
    end
end


MSE_LS = MSE_LS/nBlocks;
MSE_LMMSE = MSE_LMMSE/nBlocks;
MSE_LSt = MSE_LSt/nBlocks;
MSE_LMMSEt = MSE_LMMSEt/nBlocks;

semilogy(SNRdB,MSE_LS,'g - ','linewidth',3.0,'MarkerFaceColor','g','MarkerSize',9.0);
hold on
semilogy(SNRdB,MSE_LSt,'r o','linewidth',3.0,'MarkerFaceColor','r','MarkerSize',9.0);
semilogy(SNRdB,MSE_LMMSE,'b -.','linewidth',3.0,'MarkerFaceColor','b','MarkerSize',9.0);
semilogy(SNRdB,MSE_LMMSEt,'m s','linewidth',3.0,'MarkerFaceColor','m','MarkerSize',9.0);
axis tight;
grid on;
title('LS and LMMSE for Wireless Channel Estimation');
legend('LS','LS Theory','LMMSE','LMMSE Theory','Location','SouthWest');
xlabel('SNR (dB)')
ylabel('MSE') 

