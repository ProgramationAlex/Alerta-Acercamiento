# coordenadas geodeticas
Re = 6378.135;
Rp = 6356.751;
ecc2 =  1 - (Rp / Re).^2;

# latitud y altitud geodética true
tic
lat_geod = zeros(1,length(t));
altitud = zeros(1,length(t));
for i = 1 : length(t)
  phi_geod = deltatrue(i);
  do 
    phi1_geod = phi_geod;
    C = 1 / sqrt(1 - ecc2 * (sind(phi1_geod)).^2);
    phi_geod = atand((ECFtrue(5,i) + Re * C * ecc2 * sind(phi1_geod)) / norm([ECFtrue(1,i) ECFtrue(3,i)]));
  until (abs(phi_geod - phi1_geod) < 0.000000001)
  lat_geod(i) = phi_geod;
  altitud(i) = norm([ECFtrue(1,i) ECFtrue(3,i)]) / (cosd(lat_geod(i))) - Re * C; 
endfor
toc
  