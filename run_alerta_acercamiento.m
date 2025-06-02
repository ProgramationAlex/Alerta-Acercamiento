% Este script ejecutará todos los scripts necesarios para alertar de un
% acercamiento a la caja de control

% Se abre el archivo tle.txt con los TLE del satélite
%open_tle_txt

global dur_dias_tle incre_tle

identificador_sat_sgp4

% Definición de algunas variables que pueden ayudar
type_propagator = 2; % tipo de propagador
t_cb_i = 1; % indice del punto que representa al satélite
longW = 114.8; % posición orbital de la caja de control
rt =  6378; % radio de la Tierra
rate_day =  24;
Dur = 30;  % duración de propagación de la órbita
incre_tle = 60; % incremento de la propagación en minutos

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
detectar_cruces_caja_control_v2 % Este script a diferencia del anterior, también toma en cuenta la distancia
reporte_cruces_caja_control

grafica_control_box_acercamientos
