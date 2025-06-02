%transformación de cartesianas ECI a kepler (MEME of date)
tic
kepler=zeros(6,length(t));
for i=1:length(t)
  %kepler(:,i)=cart_kepler(z(1,i),z(3,i),z(5,i),z(2,i),z(4,i),z(6,i)); % [6 x n]
  kepler(:,i)=cart2kepler([z(1,i);z(3,i);z(5,i);z(2,i);z(4,i);z(6,i)]); % [6 x n]
  endfor
 toc