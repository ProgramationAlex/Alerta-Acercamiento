#include <iostream>
#include <octave/oct.h>
# define M_PIl          3.141592653589793238462643383279502884L /* pi */
# define wtierra        7.2921158553e-5    // velocidad ángular de la tierra  (rad/sec)

// Transformación de coordenadas cartesianas del sistema ECI al sistema ECF

DEFUN_DLD (ECI2ECF,args, ,
"ECI to ECF")
{	
ColumnVector ECF (6);
ColumnVector z (args(0).vector_value());

double xecf, yecf, zecf, vxecf_ecf, vyecf_ecf, vzecf_ecf; 

    xecf = z(0) * cos(z(6) * M_PI / 180) + z(2) * sin(z(6) * M_PI / 180);
    yecf = -z(0) * sin(z(6) * M_PI / 180) + z(2) * cos(z(6) * M_PI / 180);
    zecf = z(4);    
     
    vxecf_ecf = (z(1) + z(2) * wtierra) * cos(z(6) * M_PI / 180) + (z(3) - z(0) * wtierra) * sin(z(6) * M_PI / 180);
    vyecf_ecf = -(z(1) + z(2) * wtierra) * sin(z(6) * M_PI / 180) + (z(3) - z(0) * wtierra) * cos(z(6) * M_PI / 180);
    vzecf_ecf = z(5);
    
    ECF(0) = xecf;
    ECF(1) = vxecf_ecf;
    ECF(2) = yecf;
    ECF(3) = vyecf_ecf;
    ECF(4) = zecf;
    ECF(5) = vzecf_ecf;
    
    return octave_value (ECF);
}
