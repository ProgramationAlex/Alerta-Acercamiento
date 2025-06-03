#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */
# define mu        398600.4415           // constante gravitacional de la tierra  (km^3/seg^2)

// Programmed by Alejandro Hernández Flores
// Transformación de los elementos orbitales cartesianos en el sistema ECI a elementos keplerianos 

DEFUN_DLD (cart2kepler,args, ,
"elementos keplerianos")
{	
ColumnVector kepler (6);
ColumnVector z (args(0).vector_value());

double Z[6]={z(0),z(3),z(1),z(4),z(2),z(5)};


double momento[4];  // vector de momento (mx,my,mz,magnitud)

  momento[0] = Z[5] * Z[2] - Z[3] * Z[4];     // componente x
  momento[1] = Z[1] * Z[4] - Z[5] * Z[0];     // componente y
  momento[2] = Z[3] * Z[0] - Z[1] * Z[2];     // componente z
  momento[3] = pow(pow(momento[0],2) + pow(momento[1],2) + pow(momento[2],2),0.5);

// inclinacion
double incl = acos(momento[2]/momento[3]) * 180 / M_PI;   // inclinación
  
// RAAN
double RAAN;
double OMEGA = atan2(momento[0],- momento[1])* 180 / M_PI;   // Ascención recta del nodo ascendente
   if ( OMEGA < 0){
    RAAN = 360 + OMEGA;
   }
    else{
    RAAN = OMEGA;	
	}

// Excentricidad
double ecc[4];    
double rmag = pow(pow(Z[0],2) + pow(Z[2],2) + pow(Z[4],2),0.5); 
  ecc[0] = -(Z[0] / rmag) - (momento[1] * Z[5] - momento[2] * Z[3]) / mu;     // componente x de ecc
  ecc[1] = -(Z[2] / rmag) - (-momento[0] * Z[5] + momento[2] * Z[1]) / mu;    // componente y de ecc
  ecc[2] = -(Z[4] / rmag) - (momento[0] * Z[3] - momento[1] * Z[1]) / mu;     // componente z de ecc
  ecc[3] = pow(pow(ecc[0],2) + pow(ecc[1],2) + pow(ecc[2],2),0.5);            // magnitud de ecc

// Argumento del perigeo
double argper;
double omega = acos((-momento[1] * ecc[0] + momento[0] * ecc[1]) / (pow(pow(momento[0],2) + pow(momento[1],2),0.5) * ecc[3])) * 180 / M_PI;
  if (ecc[2] < 0){
    argper = 360 - omega;
  }
    else{
    argper=omega;    	
	}
    
// cálculo de la velocidad radial
double vr =(Z[0]* Z[1] + Z[2] * Z[3] + Z[4] * Z[5]) / rmag;    
    
// Anomalía verdadera
double truenu;
double nu = acos((ecc[0] * Z[0] + ecc[1] * Z[2] + ecc[2] * Z[4]) / (rmag * ecc[3])) * 180 / M_PI;
  if (vr < 0){
    truenu = 360 - nu;
  }
   else{
    truenu = nu;	
	}
    
  
// semi eje mayor
double a = pow(momento[3],2) / (mu * (1 - pow(ecc[3],2)));

 kepler(0) = a;              // Semi-eje mayor
 kepler(1) = ecc[3];         // Excentricidad
 kepler(2) = incl;           // Inclinación
 kepler(3) = RAAN;           // Ascención recta del nodo ascendente
 kepler(4) = argper;         // Argumento del perigeo
 kepler(5) = truenu;         // Anomalía verdadera


return octave_value (kepler);	
}
