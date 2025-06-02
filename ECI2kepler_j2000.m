%transformación de cartesianas ECI a kepler en el MeanJ2000
tic
keplerj2000=zeros(6,length(t));
for i=1:length(t)
  %kepler(:,i)=cart_kepler(z(1,i),z(3,i),z(5,i),z(2,i),z(4,i),z(6,i)); % [6 x n]
  keplerj2000(:,i)=cart2kepler([zj2000(1,i);zj2000(3,i);zj2000(5,i);zj2000(2,i);zj2000(4,i);zj2000(6,i)]); % [6 x n]
  endfor
 toc