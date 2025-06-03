#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */

// Programmed by Alejandro Hernández Flores
// Transformación de coordenadas de Mean equator and equinox of date to Mean J2000
// Goddard Trajectory Determination System (GTDS) Revision 1, July 1989. 
// Astronomical Algorithms, J. Meeus
// Esta transformación solo considera la precesión del eje axial de la tierra (aprox. 26000 años) 

DEFUN_DLD (MeanJ20002MEMEdate,args, ,
"mean of J2000 to MEME of date")
{	
ColumnVector J2M (6);
ColumnVector z (args(0).vector_value());

double a11, a12, a13, a21, a22, a23, a31, a32, a33;
double z0, thp, zp, t;

t = z(6);

// Estas fórmulas fueron tomadas del Meeus (20.3) Método riguroso
// todos los valores están dados en radianes (Meeus da estos resultados en segundos de arco)
z0 = M_PI * (2306.2181 * t + 0.30188 * t * t + 0.017998 * t * t * t) / 3600 / 180;
zp = M_PI * (2306.2181 * t + 1.09468 * t * t + 0.018203 * t * t * t) / 3600 / 180;
thp = M_PI * (2004.3109 * t - 0.42665 * t * t - 0.041833 * t * t * t) / 3600 / 180;

// GoddardTrajectorySystem (3-10a : 3-10i)
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

  J2M(0) = z(0) * a11 + z(2) * a12 + z(4) * a13;
  J2M(1) = z(1) * a11 + z(3) * a12 + z(5) * a13;
  J2M(2) = z(0) * a21 + z(2) * a22 + z(4) * a23;
  J2M(3) = z(1) * a21 + z(3) * a22 + z(5) * a23;
  J2M(4) = z(0) * a31 + z(2) * a32 + z(4) * a33;
  J2M(5) = z(1) * a31 + z(3) * a32 + z(5) * a33;


return octave_value (J2M);	
}
