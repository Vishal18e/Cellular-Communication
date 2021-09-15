function base_coordinates = basesations(num)
base_coordinates =zeros(num,2);
sqrtnum = (num^0.5);
vary=-floor(sqrtnum/2);
for i=0:int32(sqrtnum)-1
% the radius of the cell is 1.6km so the distances between consequtive base
% sation in a row should be 1.6*(root(3)/2) *2 i.e dist = 2.7712km =
% 2771.2m and 1600*3 vertically.
cx= 2771.2;cy=1600*1.5;
if mod(i,2)==0
   varx =-floor(sqrtnum/2);
   for j=1:int32(sqrtnum)
      base_coordinates(i*int32(sqrtnum)+j,1)=varx*cx ;
      base_coordinates(i*int32(sqrtnum)+j,2)=vary*cy;
      varx=varx+1;
   end
   vary=vary+1;
end

if mod(i,2)==1
   varx =-floor(sqrtnum/2)+0.5;
   for j=1:int32(sqrtnum)
      base_coordinates(i*int32(sqrtnum)+j,1)=varx*cx;
      base_coordinates(i*int32(sqrtnum)+j,2)=vary*cy;
      varx=varx+1;
   end
   vary=vary+1;
end

end
    
end