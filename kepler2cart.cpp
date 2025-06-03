#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */
# define mu        398600.4415           // constante gravitacional de la tierra  (km^3/seg^2)

// Programmed by Alejandro Hernández Flores
// Transformación de los elementos orbitales keplerianos a elementos cartesianos

DEFUN_DLD (kepler2cart,args, ,
"cartesian elements from keplerian elements")
{	
ColumnVector cartesian (6);
ColumnVector z (args(0).vector_value());

double Z[6]={z(0),z(1),z(2),z(3),z(4),z(5)};

double nu = Z[5] * M_PI / 180;  // nu en radianes

double r = (Z[0] * (1 - pow(Z[1],2))) / (1 + Z[1] * cos(nu)); // distancia radial

double x = r * cos(nu);   // posición x

double y = r * sin(nu);   // posición y

double posicion[3];  // vector de posición 

// vector de posición
  posicion[0] = y * (-cos(Z[3] * M_PI / 180) * sin(Z[4] * M_PI / 180) - cos(Z[2] * M_PI / 180) * cos(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180)) + x * (cos(Z[4] * M_PI / 180) * cos(Z[3] * M_PI / 180) - cos(Z[2] * M_PI / 180) * sin(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180));     // componente x
  posicion[1] = x * (cos(Z[2] * M_PI / 180) * cos(Z[3] * M_PI / 180) * sin(Z[4] * M_PI / 180) + cos(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180)) + y * (cos(Z[2] * M_PI / 180) * cos(Z[4] * M_PI / 180) * cos(Z[3] * M_PI / 180) - sin(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180));     	 // componente y
  posicion[2] = y * cos(Z[4] * M_PI / 180) * sin(Z[2] * M_PI / 180) + x * sin(Z[2] * M_PI / 180) * sin(Z[4] * M_PI / 180);    																				 // componente z

// nu y r punto
double nup = (1 / r) * pow(mu / (Z[0] * (1 - pow(Z[1],2))),0.5) * (1 + Z[1] * cos(nu));   // nu punto
double rp = pow(mu / (Z[0] * (1 - pow(Z[1],2))),0.5) * Z[1] * sin(nu);

// velocidad en el plano orbital
double vx = rp * cos(nu) - r * nup * sin(nu);

double vy = rp * sin(nu) + r * nup * cos(nu);

// vector de velocidad  
double velocidad[3];
  velocidad[0] = vy * (-cos(Z[3] * M_PI / 180) * sin(Z[4] * M_PI / 180) - cos(Z[2] * M_PI / 180) * cos(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180)) + vx * (cos(Z[4] * M_PI / 180) * cos(Z[3] * M_PI / 180) - cos(Z[2] * M_PI / 180) * sin(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180));     // componente x
  velocidad[1] = vx * (cos(Z[2] * M_PI / 180) * cos(Z[3] * M_PI / 180) * sin(Z[4] * M_PI / 180) + cos(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180)) + vy * (cos(Z[2] * M_PI / 180) * cos(Z[4] * M_PI / 180) * cos(Z[3] * M_PI / 180) - sin(Z[4] * M_PI / 180) * sin(Z[3] * M_PI / 180));     	 // componente y
  velocidad[2] = vy * cos(Z[4] * M_PI / 180) * sin(Z[2] * M_PI / 180) + vx * sin(Z[2] * M_PI / 180) * sin(Z[4] * M_PI / 180);    																				 // componente z

 cartesian(0) = posicion[0];              // posición x
 cartesian(1) = velocidad[0];             // velocidad x
 cartesian(2) = posicion[1];              // posición y
 cartesian(3) = velocidad[1];             // velocidad y
 cartesian(4) = posicion[2];              // posición z
 cartesian(5) = velocidad[2];             // velocidad z


return octave_value (cartesian);	
}
