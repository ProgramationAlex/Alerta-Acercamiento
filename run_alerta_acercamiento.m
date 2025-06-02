% Este script ejecutar� todos los scripts necesarios para alertar de un
% acercamiento a la caja de control

% Se abre el archivo tle.txt con los TLE del sat�lite
%open_tle_txt

global dur_dias_tle incre_tle

identificador_sat_sgp4

% Definici�n de algunas variables que pueden ayudar
type_propagator = 2; % tipo de propagador
t_cb_i = 1; % indice del punto que representa al sat�lite
longW = 114.8; % posici�n orbital de la caja de control
rt =  6378; % radio de la Tierra
rate_day =  24;
Dur = 30;  % duraci�n de propagaci�n de la �rbita
incre_tle = 60; % incremento de la propagaci�n en minutos

% Se usa el propagador SGP$
propagator_sgdp4_intreface

ECI2kepler
ECIcart2ECFcart
TEME2True

ECIcart2ECFcart_true
ECI2kepler_true
MEME2J2000
ECI2kepler_j2000
data_SK_drift_longitude
datos_efemerides
datos_graficas
coordenadas_geodeticas

% se detecta los cruces por la caja de control
detectar_cruces_caja_control_v2 % Este script a diferencia del anterior, tambi�n toma en cuenta la distancia
reporte_cruces_caja_control

grafica_control_box_acercamientos
