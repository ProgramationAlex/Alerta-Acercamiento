#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */

// Programmed by Alejandro Hernández Flores
// Transformación de coordenadas de Mean equator and equinox of date to True of date
// Involucra correciones de los efectos de nutación
// Goddard Trajectory Determination System (GTDS) Revision 1, July 1989. 
// Esta transformación considera la oscilación del eje axial de la tierra alrededor de la posición "promedio"
// debida principalmente por la acción de la Luna

DEFUN_DLD (TEMEdate2Truedate,args, ,
"MEME of date to True of date")
{	
ColumnVector M2T (6);
ColumnVector z (args(0).vector_value());

double n11, n12, n13, n21, n22, n23, n31, n32, n33;
double D, M, Mm, F, W, T;
double arg, dpsi, deps, epsm, epst;
int i;

T = z(6);
 // Resultados dados en grados y decimales (Meeus, Chapter 21: Nutation and obliquity)
 // Mean elongantion of the moon the sun
 D = 297.85036 + 445267.11148 * T - 0.0019142 * T * T + T * T * T / 189474;
 // Mean anomaly of the sun (earth)
 M = 357.52772 + 35999.05034 * T - 0.0001603 * T * T - T * T * T / 300000;
 // Mean anomaly of the moon
 Mm = 134.96298 + 477198.867398 * T + 0.0086972 * T * T + T * T * T / 56250;
 // Moon's argument of latitude
 F = 93.27191 + 483202.017538 * T - 0.0036825 * T * T + T * T * T / 327270; 
 // Longitude of ascending node  of the Moon´s mean orbit on the ecliptic, measured from the mean equinox of the date
 W = 125.04452 - 1934.136261 * T + 0.0020708 * T * T + T * T * T / 450000;

        //D, M, M', F, O, sin 0, sin 1, cos 0, cos 1
double TABLA[63][9] = {
        {0, 0, 0, 0, 1, -171996, -174.2, 92025, 8.9},
        {-2, 0, 0, 2, 2, -13187, -1.6, 5736, -3.1},
        {0, 0, 0, 2, 2, -2274, -0.2, 977, -0.5},
        {0, 0, 0, 0, 2, 2062, 0.2, -895, 0.5},
        {0, 1, 0, 0, 0, 1426, -3.4, 54, -0.1},
        {0, 0, 1, 0, 0, 712, 0.1, -7, 0},
        {-2, 1, 0, 2, 2, -517, 1.2, 224, -0.6},
        {0, 0, 0, 2, 1, -386, -0.4, 200, 0},
        {0, 0, 1, 2, 2, -301, 0, 129, -0.1},
        {-2, -1, 0, 2, 2, 217, -0.5, -95, 0.3},
        {-2, 0, 1, 0, 0, -158, 0, 0, 0},
        {-2, 0, 0, 2, 1, 129, 0.1, -70, 0},
        {0, 0, -1, 2, 2, 123, 0, -53, 0},
        {2, 0, 0, 0, 0, 63, 0, 0, 0},
        {0, 0, 1, 0, 1, 63, 0.1, -33, 0},
        {2, 0, -1, 2, 2, -59, 0, 26, 0},
        {0, 0, -1, 0, 1, -58, -0.1, 32, 0},
        {0, 0, 1, 2, 1, -51, 0, 27, 0},
        {-2, 0, 2, 0, 0, 48, 0, 0, 0},
        {0, 0, -2, 2, 1, 46, 0, -24, 0},
        {2, 0, 0, 2, 2, -38, 0, 16, 0},
        {0, 0, 2, 2, 2, -31, 0, 13, 0},
        {0, 0, 2, 0, 0, 29, 0, 0, 0},
        {-2, 0, 1, 2, 2, 29, 0, -12, 0},
        {0, 0, 0, 2, 0, 26, 0, 0, 0},
        {-2, 0, 0, 2, 0, -22, 0, 0, 0},
        {0, 0, -1, 2, 1, 21, 0, -10, 0},
        {0, 2, 0, 0, 0, 17, -0.1, 0, 0},
        {2, 0, -1, 0, 1, 16, 0, -8, 0},
        {-2, 2, 0, 2, 2, -16, 0.1, 7, 0},
        {0, 1, 0, 0, 1, -15, 0, 9, 0},
        {-2, 0, 1, 0, 1, -13, 0, 7, 0},
        {0, -1, 0, 0, 1, -12, 0, 6, 0},
        {0, 0, 2, -2, 0, 11, 0, 0, 0},
        {2, 0, -1, 2, 1, -10, 0, 5, 0},
        {2, 0, 1, 2, 2, -8, 0, 3, 0},
        {0, 1, 0, 2, 2, 7, 0, -3, 0},
        {-2, 1, 1, 0, 0, -7, 0, 0, 0},
        {0, -1, 0, 2, 2, -7, 0, 3, 0},
        {2, 0, 0, 2, 1, -7, 0, 3, 0},
        {2, 0, 1, 0, 0, 6, 0, 0, 0},
        {-2, 0, 2, 2, 2, 6, 0, -3, 0},
        {-2, 0, 1, 2, 1, 6, 0, -3, 0},
        {2, 0, -2, 0, 1, -6, 0, 3, 0},
        {2, 0, 0, 0, 1, -6, 0, 3, 0},
        {0, -1, 1, 0, 0, 5, 0, 0, 0},
        {-2, -1, 0, 2, 1, -5, 0, 3, 0},
        {-2, 0, 0, 0, 1, -5, 0, 3, 0},
        {0, 0, 2, 2, 1, -5, 0, 3, 0},
        {-2, 0, 2, 0, 1, 4, 0, 0, 0},
        {-2, 1, 0, 2, 1, 4, 0, 0, 0},
        {0, 0, 1, -2, 0, 4, 0, 0, 0},
        {-1, 0, 1, 0, 0, -4, 0, 0, 0},
        {-2, 1, 0, 0, 0, -4, 0, 0, 0},
        {1, 0, 0, 0, 0, -4, 0, 0, 0},
        {0, 0, 1, 2, 0, 3, 0, 0, 0},
        {0, 0, -2, 2, 2, -3, 0, 0, 0},
        {-1, -1, 1, 0, 0, -3, 0, 0, 0},
        {0, 1, 1, 0, 0, -3, 0, 0, 0},
        {0, -1, 1, 2, 2, -3, 0, 0, 0},
        {2, -1, -1, 2, 2, -3, 0, 0, 0},
        {0, 0, 3, 2, 2, -3, 0, 0, 0},
        {2, -1, 0, 2, 2, -3, 0, 0, 0},
    };

// el resultado se obtendra en segundos de arco
dpsi = 0;
deps = 0;
for (i = 0; i <= 62; i++){
	arg = (TABLA[i][0] * D + TABLA[i][1] * M + TABLA[i][2] * Mm + TABLA[i][3] * F + TABLA[i][4] * W) * M_PI / 180;
	dpsi = dpsi + (TABLA[i][5] + TABLA[i][6] * T) * sin(arg) * 0.0001;     // segundos de arco ´´
	deps = deps + (TABLA[i][7] + TABLA[i][8] * T) * cos(arg) * 0.0001;     // segundos de arco ´´
}

// cálculo de las componentes de la matriz de trasnformación de coordenadas (Goddard, Chapter 3.3.1.3: Mean of Date to True of Date)
// Oblicuidad de la ecliptica media
 epsm = (23.43929111 - 0.0130047 * T - 0.0000001639 * T * T + 0.000000503 * T * T * T) * M_PI / 180; 
 epst = epsm + (deps / 3600) * M_PI / 180;
 dpsi = (dpsi / 3600) * M_PI / 180;
 
 // componentes de la matriz de transformación
 n11 = cos(dpsi);
 n12 = -sin(dpsi) * cos(epsm);
 n13 = 0;
 n21 = sin(dpsi) * cos(epst);
 n22 = cos(dpsi) * cos(epst) * cos(epsm) + sin(epst) * sin(epsm);
 n23 = 0;
 n31 = 0;     // esta ecuación fue corregida del Goddard (3-25g)     
 n32 = 0;
 n33 = 1;
 
 
  M2T(0) = z(0) * n11 + z(2) * n12 + z(4) * n13;
  M2T(1) = z(1) * n11 + z(3) * n12 + z(5) * n13;
  M2T(2) = z(0) * n21 + z(2) * n22 + z(4) * n23;
  M2T(3) = z(1) * n21 + z(3) * n22 + z(5) * n23;
  M2T(4) = z(0) * n31 + z(2) * n32 + z(4) * n33;
  M2T(5) = z(1) * n31 + z(3) * n32 + z(5) * n33;

return octave_value (M2T);	
}
