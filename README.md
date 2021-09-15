# Cellular-Communication
The Objectine of the Internisp was to gain the indepth knowledge of Cellular Concept discussed in the paper Inter-Cell Interference in Noncooperative TDD Large Scale Antenna Systems and simulate the result so obtained in the paper along with some intermediate results so obtained.

In order to avoid the Pilot contamination we can have shifted pilot transmission because of which the interference between the non orthogonal pilots reduces to large extent and could significantly improve the process the channel estimation.

## Pilot_recep module
It is the main module here, which uses all the other functional modules. For instance in this simulation we have considered a total of 16 hexagonal cells and each cell has 5 users and a basestation at the center of each cell. There is a channel coeffient associated between every basestation and user. Since there are 5 user in every cell so we have to have a pilot in one hot encoding in order to detect the corresponding channel coefficient.

## PILOT module
Take in the pilot power and then modulate it and then send those one hot encoded modulated pilot signals back to the Pilot_recep module.

## user_repr
This module help in detection of the outline of the hexagonal cells. The hexagonal cells used in the simulation have a radius of 1.6km.
![Cell_representation](https://user-images.githubusercontent.com/69033172/133429796-08268d12-c10a-491d-a8e8-a91b86815c2b.jpg)

## usersPlacement
This module radomly places the users in the cells of 1.6km. This module takes in the co-ordinates of the basestation and defines hexagonal cells with basestation at the center of cell and returns the co-ordinates of the 80 users in one go across 16 cells , 5 users each cell.
![users_plac](https://user-images.githubusercontent.com/69033172/133425103-9f6a57ff-82a2-4de5-8e77-14f5206bb151.jpg)

## basesations
It takes num as the input which is 16 in this case and gives us the uniformly spaced locations of the basestation.

## downlink_transmission
This module transmits bits to users and examine the received bit.

## Results
#### Transmitted SNR vs Received SNR for Aligned and Shifted Pilot Transmission for all 5 users in any cell.
![Ap_tsnr_vs_rsnr](https://user-images.githubusercontent.com/69033172/133425192-87cab0a6-996f-4ce1-9c61-0fb3afcdd017.jpg)
![Sp_tsnr_vs_rsnr](https://user-images.githubusercontent.com/69033172/133425443-4fce74cc-df43-4fa8-a7f3-f271ec1d19e9.jpg)
![Tsnr_vs_Rsnr](https://user-images.githubusercontent.com/69033172/133425489-393cfcd0-dbeb-473c-a773-03337d0f5d8d.jpg)

## BER Analysis for AP and SP transmission for all 5 users in any cell.
![BER_AP](https://user-images.githubusercontent.com/69033172/133425246-2850aef2-0f70-4e33-9dc8-cc59deb66d5c.jpg)
![SP_BER_vsrsnr](https://user-images.githubusercontent.com/69033172/133425357-77b2fb00-e38f-4906-b854-437368d3dafa.jpg)
It is worth noting that BER have slight changes for the above simulated cases because of small scale simulation.

## fraction of users with SINR vs SINRs(db)
This plot has been plotted for different pilot powers, starting curve has the least pilot power and the last curve has the maximum pilot power.
The result validates the figure 3 of the paper Inter-Cell Interference in Noncooperative TDD Large Scale Antenna Systems.
![frac_users](https://user-images.githubusercontent.com/69033172/133425302-84f6ded1-00e7-4e85-a38f-7448da2c7f4b.jpg)





