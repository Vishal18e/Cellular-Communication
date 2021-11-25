
# Simulations
There are simulations related to channel estimation, OFDM-MIMO
receiver and also beamformers.

## LS-LMMSE Channel Estimation
The two channel estimators are compared and we clearly see that at lower SNR LMMSE estimators overperforms LS channel estimator.
This validates the theoratical results as well.<br>
![LS](https://user-images.githubusercontent.com/69033172/143394308-ed2e7559-14cd-454f-ab23-47a64bdcb9e0.jpg)


## ML ZF receiver
In this simulation the two type of the receivers are compared and we can easily see that the Maximum likelihood receiver outperforms the Zero Forcing receiver.<br>
![ML](https://user-images.githubusercontent.com/69033172/143394717-e7c4bb88-d10f-4acf-a833-2647dafbe40b.jpg)

## ZF MMSE Receiver
ZF receiver does not take noise into the account and hence at lower SNR we can clearly see that LMMSE receiver outperforms the ZF receiver which is more or less not the case at higher SNR. We can see that simulated results clearly validates the theoratical results.<br>
![ZFMMSE](https://user-images.githubusercontent.com/69033172/143395662-32046c81-e151-40c8-84aa-0b61a5f4818b.jpg)


## Beamformers
We know that the intensity of the signal decreases as it travels to different distances. In case of the cellular communication we can see that the spectral efficiency is maximum near the basestations and its decreases exponentially as we move towards the cell edeges.
![fig8](https://user-images.githubusercontent.com/69033172/143398203-d3c12c5b-fc33-4b71-ad70-04c973daf927.png)<br><br>
Even if we increase the basesation density, then problem related to cell edge is not solved. <br><br>
![fig9](https://user-images.githubusercontent.com/69033172/143398106-c8c5b0d8-a10a-4e66-a6c1-831e0bd32026.png)<br>
<br>
In order to increase the spectral efficiency we can direct the beams of signal towards the users and ultimately increase the spectral efficiency.<br>
![fig20](https://user-images.githubusercontent.com/69033172/143398691-fc6c89fe-3b40-447b-ab34-8297ac03386e.png)

### BER comparision for Theoratical MRC and Simulated MRC
MRC stands for maximal ratio combiner and it is used as a beamformer and used to suppress the interference and increase the spectral efficiency for the users.<br><br>
![MRC_BER](https://user-images.githubusercontent.com/69033172/143399503-32d15954-c74b-4dd3-b81e-98b7fada39be.jpg)


### BER comparision for MRC, AS and EGC
MRC is basically a weighed average of the fading coeeficients associated between different set of receiving and transmitting antenna. AS takes the best pair of Tx and Rx
whereas EGC normalizes all the fading coefficients.<br><br>

![BER_AS_EGS_MRC1](https://user-images.githubusercontent.com/69033172/143400124-637e3259-5fe9-46d8-9e60-10dfd38bd53b.jpg)


## A MIMO-OFDM Model
Given below a simualtion of the MIMO OFDM model.<br><br>
![MIMO](https://user-images.githubusercontent.com/69033172/143400300-0a0af2f6-5452-4fee-bff8-e723a10fc448.jpg)



