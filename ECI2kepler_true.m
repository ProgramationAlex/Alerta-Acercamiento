%transformación de cartesianas ECI a kepler en el True of date
tic
keplertrue=zeros(6,length(t));
for i=1:length(t)
  %kepler(:,i)=cart_kepler(z(1,i),z(3,i),z(5,i),z(2,i),z(4,i),z(6,i)); % [6 x n]
  keplertrue(:,i)=cart2kepler([ztrue(1,i);ztrue(3,i);ztrue(5,i);ztrue(2,i);ztrue(4,i);ztrue(6,i)]); % [6 x n]
  endfor
 toc