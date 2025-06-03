#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */

// Programmed by Alejandro Hernández Flores
// Transformación de coordenadas de Mean equator and equinox of date to Mean J2000
// Goddard Trajectory Determination System (GTDS) Revision 1, July 1989. 
// Astronomical Algorithms, J. Meeus

DEFUN_DLD (MEMEdate2MeanJ2000,args, ,
"MEME of date to mean of J2000")
{	
ColumnVector M2J (6);
ColumnVector z (args(0).vector_value());

double a11, a12, a13, a21, a22, a23, a31, a32, a33;
double z0, thp, zp, t;

t = z(6);

// Estas fórmulas fueron tomadas del Meeus
// todos los valores están dados en radianes (Meeus da estos resultados en segundos de arco)
z0 = M_PI * (2306.2181 * t + 0.30188 * t * t + 0.017998 * t * t * t) / 3600 / 180;
zp = M_PI * (2306.2181 * t + 1.09468 * t * t + 0.018203 * t * t * t) / 3600 / 180;
thp = M_PI * (2004.3109 * t - 0.42665 * t * t - 0.041833 * t * t * t) / 3600 / 180;

a11 = -sin(z0) * sin(zp) + cos(z0) * cos(zp) * cos(thp);
a12 = -cos(z0) * sin(zp) - sin(z0) * cos(zp) * cos(thp);
a13 = -cos(zp) * sin(thp),
a21 = sin(z0) * cos(zp) + cos(z0) * sin(zp) * cos(thp);
a22 = cos(z0) * cos(zp) - sin(z0) * sin(zp) * cos(thp);
a23 = -sin(zp) * sin(thp);
a31 = cos(z0) * sin(thp);
a32 = -sin(z0) * sin(thp);
a33 = cos(thp);

/* matriz de transfomación de coordenadas
  Goddard describe la matriz de transformación de coordenadas para transformar de Mean of J2000 a Mean of date
  sin embargo esta transformación irá en el sentido inverso, por lo tanto construiremos  
  la matriz transpuesta de transformación 
*/

  M2J(0) = z(0) * a11 + z(2) * a21 + z(4) * a31;
  M2J(1) = z(1) * a11 + z(3) * a21 + z(5) * a31;
  M2J(2) = z(0) * a12 + z(2) * a22 + z(4) * a32;
  M2J(3) = z(1) * a12 + z(3) * a22 + z(5) * a32;
  M2J(4) = z(0) * a13 + z(2) * a23 + z(4) * a33;
  M2J(5) = z(1) * a13 + z(3) * a23 + z(5) * a33;


return octave_value (M2J);	
}
