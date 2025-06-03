% calcula la fecha gregoriana a partir de un día Juliano 

function dia=calendar_day(Z)
  Z=Z+0.5;
  F=(Z)-floor(Z);
  Z=Z-F;
  if (Z<2299161)
    A=Z;
    else
    alfa=floor((Z-1867216.25)/36424.25);
    A=Z+1+alfa-floor(alfa/4);
    endif
    
    B=A+1524;
    C=floor((B-122.1)/365.25);
    D=floor(365.25*C);
    E=floor((B-D)/30.6001);
    
    % día del mes con decimales es:
    dia=B-D-floor(30.6001*E)+F;
    
    % el número de mes es:
    if (E<14)
      mes=E-1;
    elseif (or(E==14 , E==15))
      mes=E-13;
    endif
    
    % el año es:
    if (mes>2)
      Y=C-4716;
    elseif (or(mes==1 , mes==2))
      Y=C-4715;
      endif
      
      dia=[Y mes dia];