% Transformación de coordenadas cartesianas
% de ECI TEME of date to ECI True of Date
% Esta transformación de coordenadas es sólo válida para coordenadas
% cartesianas medidas en el sistema Earth Centered Inertial (ECI)
% z     : coordenadas cartesianas sistema ECI TEME of date
% ztrue : coordenadas cartesianas sistema ECI True of date
ztrue = zeros(6,length(t));
tic
for i = 1 : length(t)
  ztrue(:,i) = TEMEdate2Truedate([z(:,i);(tiempo(i) - 2451545)/36525]);
end
toc