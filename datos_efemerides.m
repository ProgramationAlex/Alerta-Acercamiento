# Datos para gráficas y otros
tic
t_i = 1;
GD = zeros(length(t),3);
%hora = zeros(length(t),4);    
%tiempo=linspace(JD,JD+Dur,muestras+1);
tiempo = JD + (t / 86400);     # vector de tiempo de días julianos
estado = zeros(length(t),7);
for i = 1 : length(t)
  GD(i,:) = calendar_day(tiempo(i));
  hr = (GD(i,3) - floor(GD(i,3))) * 24;
  hora = fracc_hora(hr + 1e-7);            % 1e-7 redondea las milesimas de segundo
  estado(i,1:7) = [GD(i,1) GD(i,2) floor(GD(i,3)) hora];
 end
 
 % vector de tiempo (millenians julianas), posible uso:
 % cálculo de la posición del sol sunposmodif1.cpp
 
 TJM = (tiempo - 2451545) / 365250;
 
 % vector de tiempo (centurias julianas), para el cálculo de la posición
 % de la luna por ejemplo.
 
 TJC = (tiempo - 2451545) / 36525;
 
 % cálculo de la velocidad del satélite en la órbita
 vel_orb = zeros(1,length(t));
 for i = 1 : length(t)
   vel_orb(i) = sqrt(ztrue(2,i).^2 + ztrue(4,i).^2 + ztrue(6,i).^2);
 endfor
 
 % posición del sol (coordenadas cartesianas y longitud y latitud)
 sunpos = zeros(5,length(t));
 for i = 1 : length(t)
   sunpos(:,i) = sunposmodif1((tiempo(i) - 2451545) / 365250);
 endfor
 
 # posición de la luna
 efeme_lunar = zeros(5,length(t));
 for i = 1 : length(t)
   efem_lunar(:,i) = efemlunar(tiempo(i));
 endfor
 
 # Magnitud del vector de posición
 R_mag = zeros(1,length(t));
 for i = 1 : length(t)
   R_mag(i) = sqrt(z(1,i).^2 + z(3,i).^2 + z(5,i).^2);
 endfor
 
 # rate of change of true anomaly
 nu_dot = zeros(1,length(t));
 for i = 1 : length(t)
   nu_dot(i) = wtierra * kepler(1,i).^2 * sqrt(1 - kepler(2,i).^2) / R_mag(i).^2;
 endfor
 
 # Radial velocity
 R_dot = zeros(1,length(t));
 for i = 1 : length(t)
   R_dot(i) = R_mag(i) * nu_dot(i) * kepler(2,i) * sind(kepler(6,i)) / (1 + kepler(2,i) * cosd(kepler(6,i)));
 endfor
 
 
% # Aceleraciones del campo gravitacional
% acel_grav = zeros(1,length(t));
% for i = 1 : length(t)
%   acel_grav(i) = potencialgravitacional(ztrue(1,i),ztrue(3,i),ztrue(5,i),JD,tiempo(i),grav);
% endfor

if (type_propagator == 1) 
 # Aceleración total
 acel_total = zeros(6,length(t));
 for i = 1 : length(t)
   acel_total(:,i) = dinamicasatelite([ztrue(1,i);ztrue(2,i);ztrue(3,i);ztrue(4,i);ztrue(5,i);ztrue(6,i);JD;grav;ARS;t(i)]);
 endfor
 acel_xyz_eci = [acel_total(2,:);acel_total(4,:);acel_total(6,:)];
 clear acel_total
endif

# periodo
Periodo = zeros(1,length(t));
for i = 1 : length(t)
  Periodo(i) = 2 * pi * sqrt(keplertrue(1,i).^3 / mu);
endfor

# flight path angle
FPA = zeros(1,length(t));
for i = 1 : length(t)
  FPA(i) = atand(keplertrue(2,i) * sind(keplertrue(6,i)) / (1 + keplertrue(2,i) * sind(keplertrue(6,i))));
endfor
 
 toc