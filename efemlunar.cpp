#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */

/////////////////////////////////////////////////////////////////////////////////////////////////////
//    rutinas necesarias para realizar algunas simplificaciones
//    función módulo 360
double rev(double phi){
	double ang;
	int entero;
	entero = floor(phi/360);
//	int entero = static_cast<int>(phi/360);
	ang = phi - entero * 360;
	return ang;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Posición de la luna
// Programmed by Alejandro Hernández Flores

DEFUN_DLD (efemlunar,args, ,
"Efemérides de la luna")
{	
ColumnVector moon (5);
ColumnVector z (args(0).vector_value());

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Bloque para el cálculo de la posición de la luna
// declaración de las matrices de coeficientes para el cálculo de las efemérides de la luna
    int j;
    double T;

    T = (z(0) - 2451545) / 36525;      // centuria juliana

int LONR[60][6] = {
{0 ,0 ,1 ,0 ,6288774 ,-20905355 },
{2 ,0 ,-1 ,0 ,1274027 ,-3699111 },
{2 ,0 ,0 ,0 ,658314 ,-2955968 },
{0 ,0 ,2 ,0 ,213618 ,-569925 },
{0 ,1 ,0 ,0 ,-185116 ,48888 },
{0 ,0 ,0 ,2 ,-114332 ,-3149 },
{2 ,0 ,-2 ,0 ,58793 ,246158 },
{2 ,-1 ,-1 ,0 ,57066 ,-152138 },
{2 ,0 ,1 ,0 ,53322 ,-170733 },
{2 ,-1 ,0 ,0 ,45758 ,-204586 },
{0 ,1 ,-1 ,0 ,-40923 ,-129620 },
{1 ,0 ,0 ,0 ,-34720 ,108743 },
{0 ,1 ,1 ,0 ,-30383 ,104755 },
{2 ,0 ,0 ,-2 ,15327 ,10321 },
{0 ,0 ,1 ,2 ,-12528 ,0 },
{0 ,0 ,1 ,-2 ,10980 ,79661 },
{4 ,0 ,-1 ,0 ,10675 ,-34782 },
{0 ,0 ,3 ,0 ,10034 ,-23210 },
{4 ,0 ,-2 ,0 ,8548 ,-21636 },
{2 ,1 ,-1 ,0 ,-7888 ,24208 },
{2 ,1 ,0 ,0 ,-6766 ,30824 },
{1 ,0 ,-1 ,0 ,-5163 ,-8379 },
{1 ,1 ,0 ,0 ,4987 ,-16675 },
{2 ,-1 ,1 ,0 ,4036 ,-12831 },
{2 ,0 ,2 ,0 ,3994 ,-10445 },
{4 ,0 ,0 ,0 ,3861 ,-11650 },
{2 ,0 ,-3 ,0 ,3665 ,14403 },
{0 ,1 ,-2 ,0 ,-2689 ,-7003 },
{2 ,0 ,-1 ,2 ,-2602 ,0 },
{2 ,-1 ,-2 ,0 ,2390 ,10056 },
{1 ,0 ,1 ,0 ,-2348 ,6322 },
{2 ,-2 ,0 ,0 ,2236 ,-9884 },
{0 ,1 ,2 ,0 ,-2120 ,5751 },
{0 ,2 ,0 ,0 ,-2069 ,0 },
{2 ,-2 ,-1 ,0 ,2048 ,-4950 },
{2 ,0 ,1 ,-2 ,-1773 ,4130 },
{2 ,0 ,0 ,2 ,-1595 ,0 },
{4 ,-1 ,-1 ,0 ,1215 ,-3958 },
{0 ,0 ,2 ,2 ,-1110 ,0 },
{3 ,0 ,-1 ,0 ,-892 ,3258 },
{2 ,1 ,1 ,0 ,-810 ,2616 },
{4 ,-1 ,-2 ,0 ,759 ,-1897 },
{0 ,2 ,-1 ,0 ,-713 ,-2117 },
{2 ,2 ,-1 ,0 ,-700 ,2354 },
{2 ,1 ,-2 ,0 ,691 ,0 },
{2 ,-1 ,0 ,-2 ,596 ,0 },
{4 ,0 ,1 ,0 ,549 ,-1423 },
{0 ,0 ,4 ,0 ,537 ,-1117 },
{4 ,-1 ,0 ,0 ,520 ,-1571 },
{1 ,0 ,-2 ,0 ,-487 ,-1739 },
{2 ,1 ,0 ,-2 ,-399 ,0 },
{0 ,0 ,2 ,-2 ,-381 ,-4421 },
{1 ,1 ,1 ,0 ,351 ,0 },
{3 ,0 ,-2 ,0 ,-340 ,0 },
{4 ,0 ,-3 ,0 ,330 ,0 },
{2 ,-1 ,2 ,0 ,327 ,0 },
{0 ,2 ,1 ,0 ,-323 ,1165 },
{1 ,1 ,-1 ,0 ,299 ,0 },
{2 ,0 ,3 ,0 ,294 ,0 },
{2 ,0 ,-1 ,-2 ,0 ,8752 },
};

int LAT[60][5] = {
{0 ,0 ,0 ,1 ,5128122 },
{0 ,0 ,1 ,1 ,280602 },
{0 ,0 ,1 ,-1 ,277693 },
{2 ,0 ,0 ,-1 ,173237 },
{2 ,0 ,-1 ,1 ,55413 },
{2 ,0 ,-1 ,-1 ,46271 },
{2 ,0 ,0 ,1 ,32573 },
{0 ,0 ,2 ,1 ,17198 },
{2 ,0 ,1 ,-1 ,9266 },
{0 ,0 ,2 ,-1 ,8822 },
{2 ,-1 ,0 ,-1 ,8216 },
{2 ,0 ,-2 ,-1 ,4324 },
{2 ,0 ,1 ,1 ,4200 },
{2 ,1 ,0 ,-1 ,-3359 },
{2 ,-1 ,-1 ,1 ,2463 },
{2 ,-1 ,0 ,1 ,2211 },
{2 ,-1 ,-1 ,-1 ,2065 },
{0 ,1 ,-1 ,-1 ,-1870 },
{4 ,0 ,-1 ,-1 ,1828 },
{0 ,1 ,0 ,1 ,-1794 },
{0 ,0 ,0 ,3 ,-1749 },
{0 ,1 ,-1 ,1 ,-1565 },
{1 ,0 ,0 ,1 ,-1491 },
{0 ,1 ,1 ,1 ,-1475 },
{0 ,1 ,1 ,-1 ,-1410 },
{0 ,1 ,0 ,-1 ,-1344 },
{1 ,0 ,0 ,-1 ,-1335 },
{0 ,0 ,3 ,1 ,1107 },
{4 ,0 ,0 ,-1 ,1021 },
{4 ,0 ,-1 ,1 ,833 },
{0 ,0 ,1 ,-3 ,777 },
{4 ,0 ,-2 ,1 ,671 },
{2 ,0 ,0 ,-3 ,607 },
{2 ,0 ,2 ,-1 ,596 },
{2 ,-1 ,1 ,-1 ,491 },
{2 ,0 ,-2 ,1 ,-451 },
{0 ,0 ,3 ,-1 ,439 },
{2 ,0 ,2 ,1 ,422 },
{2 ,0 ,-3 ,-1 ,421 },
{2 ,1 ,-1 ,1 ,-366 },
{2 ,1 ,0 ,1 ,-351 },
{4 ,0 ,0 ,1 ,331 },
{2 ,-1 ,1 ,1 ,315 },
{2 ,-2 ,0 ,-1 ,302 },
{0 ,0 ,1 ,3 ,-283 },
{2 ,1 ,1 ,-1 ,-229 },
{1 ,1 ,0 ,-1 ,223 },
{1 ,1 ,0 ,1 ,223 },
{0 ,1 ,-2 ,-1 ,-220 },
{2 ,1 ,-1 ,-1 ,-220 },
{1 ,0 ,1 ,1 ,-185 },
{2 ,-1 ,-2 ,-1 ,181 },
{0 ,1 ,2 ,1 ,-177 },
{4 ,0 ,-2 ,-1 ,176 },
{4 ,-1 ,-1 ,-1 ,166 },
{1 ,0 ,1 ,-1 ,-164 },
{4 ,0 ,1 ,-1 ,132 },
{1 ,0 ,-1 ,-1 ,-119 },
{4 ,-1 ,0 ,-1 ,115 },
{2 ,-2 ,0 ,1 ,107 },
};

// argumentos
double L, Dm, Ms, Mm, F, A1, A2, A3, E, E2;
L = rev(218.3164591 + 481267.88134236 * T - 0.0013268 * pow(T,2) + (pow(T,3) / 538841) - (pow(T,4) / 65194000));
Dm = rev(297.8502042 + 445267.1115168 * T - 0.00163 * pow(T,2) + (pow(T,3) / 545868) - (pow(T,4) / 113065000));
Ms = rev(357.5291092 + 35999.0502909 * T - 0.0001536 * pow(T,2) + (pow(T,3) / 24490000));
Mm = rev(134.9634114 + 477198.8676313 * T + 0.008997 * pow(T,2) + (pow(T,3) / 69699) - (pow(T,4) / 14712000));
F = rev(93.2720993 + 483202.0175273 * T - 0.0034029 * pow(T,2) - (pow(T,3) / 3526000) + (pow(T,4) / 863310000));
A1 = rev(119.75 + 131.849 * T);
A2 = rev(53.09 + 479264.290 * T);
A3 = rev(313.45 + 481266.484 * T);
E = 1-0.002516 * T - 0.0000074 * pow(T,2);
E2 = pow(E,2);

// se realiza la combinación lineal

double sumlonf=0, sumradf=0, sumlatf=0;
double sumlon1, sumrad1, sumlat1;
for (j = 1; j < 60; j++)
{
	if (abs(LONR[j-1][1]) == 1)
	{
		sumlon1 = E * LONR[j-1][4] * sin((Dm * LONR[j-1][0] + Ms * LONR[j-1][1] + Mm * LONR[j-1][2] + F * LONR[j-1][3]) * M_PI / 180);
        sumrad1 = E * LONR[j-1][5] * cos((Dm * LONR[j-1][0] + Ms * LONR[j-1][1] + Mm * LONR[j-1][2] + F * LONR[j-1][3]) * M_PI / 180);
        sumlat1 = E * LAT[j-1][4] * sin((Dm * LAT[j-1][0] + Ms * LAT[j-1][1] + Mm * LAT[j-1][2] + F * LAT[j-1][3]) * M_PI / 180);
	}
	else if (abs(LONR[j-1][1]) == 2)
	{
		sumlon1 = E2 * LONR[j-1][4] * sin((Dm * LONR[j-1][0] + Ms * LONR[j-1][1] + Mm * LONR[j-1][2] + F * LONR[j-1][3]) * M_PI / 180);
        sumrad1 = E2 * LONR[j-1][5] * cos((Dm * LONR[j-1][0] + Ms * LONR[j-1][1] + Mm * LONR[j-1][2] + F * LONR[j-1][3]) * M_PI / 180);
        sumlat1 = E2 * LAT[j-1][4] * sin((Dm * LAT[j-1][0] + Ms * LAT[j-1][1] + Mm * LAT[j-1][2] + F * LAT[j-1][3]) * M_PI / 180);
	}
	else
	{
		sumlon1 = LONR[j-1][4] * sin((Dm * LONR[j-1][0] + Ms * LONR[j-1][1] + Mm * LONR[j-1][2] + F * LONR[j-1][3]) * M_PI / 180);
        sumrad1 = LONR[j-1][5] * cos((Dm * LONR[j-1][0] + Ms * LONR[j-1][1] + Mm * LONR[j-1][2] + F * LONR[j-1][3]) * M_PI / 180);
        sumlat1 = LAT[j-1][4] * sin((Dm * LAT[j-1][0] + Ms * LAT[j-1][1] + Mm * LAT[j-1][2] + F * LAT[j-1][3]) * M_PI / 180);
	}
	sumlon1=sumlon1+sumlonf;
    sumlonf=sumlon1;
    sumrad1=sumrad1+sumradf;
    sumradf=sumrad1;
    sumlat1=sumlat1+sumlatf;
    sumlatf=sumlat1;
}

// suma de términos adicionales
double lonf, latf;
   lonf = sumlonf + 3958 * sin(A1 * M_PI / 180) + 1962 * sin((L-F) * M_PI / 180) + 318 * sin(A2 * M_PI / 180);
   latf = sumlatf - 2235 * sin(L * M_PI / 180) + 382 * sin(A3 * M_PI / 180) + 175 * sin((A1-F) * M_PI / 180) + 175 * sin((A1+F) * M_PI / 180) + 127 * sin((L-Mm) * M_PI / 180) - 115 * sin((L+Mm) * M_PI / 180);
   
// resultados
double lamda, beta, dist;   
   lamda = L + lonf / 1e6;  // este dato no contempla la nutación 
   beta = latf / 1e6;
   dist = 385000.56 + sumradf / 1000;
// low precision nutation corrections   
double eclipmoon, RAANmoon, lons, lonm, dphi, decc, trlamda, trbeta, treclip;  
   eclipmoon = (84381.448 - 46.815 * T - 0.00059 * pow(T,2) + 0.001813 * pow(T,3)) / 3600;
   RAANmoon = rev(125.04452 - 1934.136261 * T);
   lons = rev(280.4665 + 36000.7698 * T);
   lonm = rev(218.3165 + 481267.8813 * T);
   dphi = -17.2 * sin(RAANmoon * M_PI / 180) - 1.32 * sin(2 * lons *M_PI / 180) - 0.23 * sin(2 * lonm * M_PI / 180) + 0.21 * sin(2 * RAANmoon * M_PI / 180);
   decc = 9.2 * cos(RAANmoon * M_PI / 180) + 0.57 * cos(2 * lons * M_PI / 180) + 0.1 * cos(2 * lonm * M_PI / 180) - 0.09 * cos(2 * RAANmoon * M_PI / 180);

   trlamda =rev(lamda + dphi / 3600);
   trbeta = beta + decc / 3600;
   treclip = rev(eclipmoon + decc / 3600);
  
// conversión a coordenadas ecuatoriales geocéntricas
double a1, b1, alfamoon, a2, b2, deltamoon; 
   a1 = sin(trlamda * M_PI / 180) * cos(treclip * M_PI / 180) - tan(trbeta * M_PI / 180) * sin(treclip * M_PI / 180);
   b1 = cos(trlamda * M_PI / 180);
   alfamoon = rev(atan2(a1,b1) * 180 / M_PI);                     // grados
   a2 = sin(trbeta * M_PI / 180) * cos(treclip * M_PI / 180) + cos(trbeta * M_PI / 180) * sin(treclip * M_PI / 180) * sin(trlamda * M_PI / 180);
   b2 = cos(asin(a2));
   deltamoon = atan2(a2,b2);                    // radianes
  
// posición de la luna en coordenadas cartesianas
double xlun, ylun, zlun;
   xlun = dist * cos(deltamoon) * cos(alfamoon * M_PI / 180);
   ylun = dist * cos(deltamoon) * sin(alfamoon * M_PI / 180);
   zlun = dist * sin(deltamoon);
   
   moon(0) = xlun;
   moon(1) = ylun;
   moon(2) = zlun;
   moon(3) = alfamoon;
   moon(4) = deltamoon * 180 / M_PI;
   
    return octave_value (moon);	
}

