% For Cellular representation
% clear
% close all
% clc
bases =basesations(16);
users = usersPlacement(bases);
num_base_stations=16;
for i=1:num_base_stations
x_1 = users(:,1,1);
y_1= users(:,2,1);
scatter(x_1,y_1,'r','filled');
hold on
% end

x_1 = users(:,1,2);
y_1= users(:,2,2);
scatter(x_1,y_1,'b','filled');
hold on

x_1 = users(:,1,3);
y_1= users(:,2,3);
scatter(x_1,y_1,'g','filled');
hold on

x_1 = users(:,1,4);
y_1= users(:,2,4);
scatter(x_1,y_1,'c','filled');
hold on



%%%%%%%%%%%%%%%%%22222222

% for i=1:num_base_stations
x_1 = users(:,1,5);
y_1= users(:,2,5);
scatter(x_1,y_1,'c','filled');
hold on
% end

x_1 = users(:,1,6);
y_1= users(:,2,6);
scatter(x_1,y_1,'y','filled');
hold on

x_1 = users(:,1,7);
y_1= users(:,2,7);
scatter(x_1,y_1,'m','filled');
hold on

x_1 = users(:,1,8);
y_1= users(:,2,8);
scatter(x_1,y_1,'r','filled');
hold on


%%%%%%%%%%%%%%%%%%%%%3333

% for i=1:num_base_stations
x_1 = users(:,1,9);
y_1= users(:,2,9);
scatter(x_1,y_1,'y','filled');
hold on
% end

x_1 = users(:,1,10);
y_1= users(:,2,10);
scatter(x_1,y_1,'m','filled');
hold on

x_1 = users(:,1,11);
y_1= users(:,2,11);
scatter(x_1,y_1,'r','filled');
hold on

x_1 = users(:,1,12);
y_1= users(:,2,12);
scatter(x_1,y_1,'b','filled');
hold on


%%%%%%%%%%%%%%%%%%%%%44444
% for i=1:num_base_stations
x_1 = users(:,1,13);
y_1= users(:,2,13);
scatter(x_1,y_1,'g','filled');
hold on
% end

x_1 = users(:,1,14);
y_1= users(:,2,14);
scatter(x_1,y_1,'c','filled');
hold on

x_1 = users(:,1,15);
y_1= users(:,2,15);
scatter(x_1,y_1,'y','filled');
hold on

x_1 = users(:,1,16);
y_1= users(:,2,16);
scatter(x_1,y_1,'m','filled');
hold on
%%


end