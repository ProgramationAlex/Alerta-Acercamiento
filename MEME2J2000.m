% Transformación de coordenadas cartesianas
% de ECI MEME of date to ECI J2000
% Esta transformación de coordenadas es sólo válida para coordenadas
% cartesianas medidas en el sistema Earth Centered Inertial (ECI)
% En la literatura no se encontro para coordendasd cartesianas en el ECF
zj2000 = zeros(6,length(t));
tic
for i = 1 : length(t)
  zj2000(:,i) = MEMEdate2MeanJ2000([z(:,i);(tiempo(i) - 2451545)/36525]);
end
toc