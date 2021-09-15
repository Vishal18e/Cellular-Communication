function user = usersPlacement(base_stations)
num_users=5;
user = zeros(num_users,2,length(base_stations));
for i=1:length(base_stations)
   user(:,1,i)=(rand(num_users,1)-0.5)*1385.6*2 + base_stations(i,1); 
    
   for j=1:num_users
       
   if (user(j,1,i)-base_stations(i,1)>0)
       right=1;
   else
        right=0;
   end
   
       
   if right==1
       c = base_stations(i,2)+1600+0.57736*base_stations(i,1);
       m=-0.57736;
       YMax = m*user(j,1,i)+c;
       user(j,2,i)=base_stations(i,2)+2*(rand(1,1)-0.5)*(YMax-base_stations(i,2));
       % 100 mts condition check;
       dist = sqrt((user(j,1,i)-base_stations(i,1))^2 + (user(j,2,i)-base_stations(i,2))^2);
       while(dist<200)
           user(j,2,i)=base_stations(i,2)+2*(rand(1,1)-0.5)*(YMax-base_stations(i,2));
           dist = sqrt((user(j,1,i)-base_stations(i,1))^2 + (user(j,2,i)-base_stations(i,2))^2);
       end
        
   else
       c = base_stations(i,2)+1600-0.57736*base_stations(i,1);
       m=0.57736;
       YMax = m*user(j,1,i)+c;
       user(j,2,i)=base_stations(i,2)+2*(rand(1,1)-0.5)*(YMax-base_stations(i,2));
       % 100 mts condition check;
       dist = sqrt((user(j,1,i)-base_stations(i,1))^2 + (user(j,2,i)-base_stations(i,2))^2);
       while(dist<200)
           user(j,2,i)=base_stations(i,2)+2*(rand(1,1)-0.5)*(YMax-base_stations(i,2));
           dist = sqrt((user(j,1,i)-base_stations(i,1))^2 + (user(j,2,i)-base_stations(i,2))^2);
       end
       
       
   end
   
   end
   
end



end