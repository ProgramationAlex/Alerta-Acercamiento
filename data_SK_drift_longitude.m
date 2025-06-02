# Datos sobre la longitud y declinación del satélite
# Longitud del satélite
THsattrue = zeros(1,length(t));
# Ascensión recta del satélite
alfatrue = zeros(1,length(t));
alfameme = zeros(1,length(t));
alfaj2000 = zeros(1,length(t));   
# Latitud del satélite
deltatrue = zeros(1,length(t));
deltameme = zeros(1,length(t));
deltaj2000 = zeros(1,length(t));
for i = 1 : length(t)
  THsattrue(i) = atan2d(ECFtrue(3,i),ECFtrue(1,i));
  if (ztrue(3,i) < 0)
    alfatrue(i) = 360 + atan2d(ztrue(3,i),ztrue(1,i));
    alfameme(i) = 360 + atan2d(z(3,i),z(1,i));
    alfaj2000(i) = 360 + atan2d(zj2000(3,i),zj2000(1,i));
  else
    alfatrue(i) = atan2d(ztrue(3,i),ztrue(1,i));
    alfameme(i) = atan2d(z(3,i),z(1,i));
    alfaj2000(i) = atan2d(zj2000(3,i),zj2000(1,i));
  endif
    deltatrue(i) = atand(ztrue(5,i) / sqrt((ztrue(3,i)).^2 + ztrue(1,i).^2));  % declinación (corregir nombre)
    deltameme(i) = atand(z(5,i) / sqrt((z(3,i)).^2 + z(1,i).^2));
    deltaj2000(i) = atand(zj2000(5,i) / sqrt((zj2000(3,i)).^2 + zj2000(1,i).^2));
  endfor
  

THreltrue = -longW - THsattrue;

# longitud este
longE = zeros(1,length(t));
for i = 1 : length(t)
  if (THsattrue(i) < 0 )
    longE(i) = 360 + THsattrue(i);
   else
    longE(i) = THsattrue(i);
  endif
endfor