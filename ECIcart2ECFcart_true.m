% transformación de coordenadas cartesianas
% de ECI true of date a ECF true of date
% Esta transformación de coordenadas es SÓLO VÁLIDA para coordendas
% cartesianas que cumplan estas dos condiciones:
% - Que estén medidas en el ECI
% - Que estén escritas en el True of Date
% si estuviesen en otro sistema, por ejemplo, MEME of epoch (J2000) o
% MEME of Date, el resultado de la transfomación será incorrecta
% Para esta transformación es necesario usar el Greenwich Aparent Sidereal Time
% GAST = GMST + correction

global ECF
tic
tiempo=JD+(t/86400);
  T_ecf=((tiempo-2451545)./36525);  % sideral time at the meridian Greenwich
  th1_ecf=280.46061837+360.98564736629*(tiempo-2451545)+0.000387933*T_ecf.^2-(T_ecf.^3/38710000);
  GMST=rev(th1_ecf);
  
  % correción para el Greenwich Apparent Siderela Time Meeus p.132
  GAST = zeros(1,length(t));
  for i = 1 : length(t)
    corr = correctionobliq(T_ecf(i));
    GAST(i) = GMST(i) + corr(3) * cosd(corr(2));
  endfor
  
%  for i = 1 : length(t)
%Om = 125.04452 - 1934.136261 * T_ecf(i);
%L = 280.4665 + 36000.7698 * T_ecf(i);
%L1 = 218.3165 + 481267.8813 * T_ecf(i);
%e = 23.439 - 0.0000004 * T_ecf(i);
%
%Om=mod(Om,360);
%L=mod(L,360);
%L1=mod(L1,360);
%e=mod(e,360);
%
%dp = -17.1996*sind(Om) -1.3187*sind(2*L) -0.2274*sind(2*L1) +0.2062*sind(2*Om);  % Meeus p.133 Tbl 21.A
%de =   9.2025*cosd(Om) +0.5736*cosd(2*L) + 0.977*cosd(2*L1) -0.0895 *cosd(2*Om);
%e =  eps + de;
%
%%correction = dp * cos(e) / 15;     % correción al GMST en segundos
%correction = dp * cosd(e) / 3600;   % corrección en grados
%
%GAST(i) = GMST(i) + correction;
%endfor
    
  % transformación de las coordenadas x, y & z
  % !! Tener cuidado a quien se esta transformando ¡¡¡
  ECFtrue = zeros(6,length(t));
  for i = 1:length(t)
    ECFtrue(:,i) = ECI2ECF([ztrue(1,i);ztrue(2,i);ztrue(3,i);ztrue(4,i);ztrue(5,i);ztrue(6,i);GAST(i)]);
  endfor
  toc