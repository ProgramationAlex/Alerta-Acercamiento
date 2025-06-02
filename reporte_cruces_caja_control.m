% Generar el archivo de reporte si se encontraron cruces
if ~isempty(cruces_dentro_caja_indices)
  nombre_archivo_reporte = 'reporte_acercamientos.txt';
  fid = fopen(nombre_archivo_reporte, 'w');
  
  load sat_db_id_name.bin
  name_sat = 'No name';
  for i = 1 : size(sat_db)(2)
    if id_sat(1:5) == sat_db{i}{1}(1:5)
      name_sat = sat_db{i}{2}
    end
  end
  
    

  if (fid == -1)
    disp(['Error al abrir el archivo: ', nombre_archivo_reporte]);
  else
    fprintf(fid, '--- Reporte de Acercamientos a la Caja de Control ---\r\n');
    fprintf(fid, 'Fecha y Hora de Generación: %s\n', datestr(now));
    fprintf(fid, '---------------------------------------------\r\n');
    fprintf(fid, 'ID Satellite: \t%s \r\n', id_sat)
    fprintf(fid, "Satellite Name: %s \r\n", name_sat)
    fprintf(fid, '\r\n')
    fprintf(fid, 'Epoch \t\t\t\tLongitude W \tRelative \tDeclination \tRadius \r\n');
    fprintf(fid, '\t\t\t\t\t\tLongitude \r\n')
    fprintf(fid, 'YYYY/MM/DD HH:MM:SS UTC \t(Deg) \t\t(Deg) \t\t(Deg) \t\t(Km) \r\n')
    fprintf(fid, '--------------------------------------')
    fprintf(fid, '-------------------------------------------------------\r\n');
    fprintf(fid, '')

    for i = 1:length(cruces_dentro_caja_indices)
      indice_acercamiento = cruces_dentro_caja_indices(i);
      epoca_acercamiento = estado(indice_acercamiento,1:6); % Tomar toda la fila del estado

      % Iterar a través de los elementos de la época e imprimirlos separados por tabulaciones
      if (isnumeric(epoca_acercamiento))
        fprintf(fid, '%d/%02d/%02d %02d:%02d:%02d UTC \t', epoca_acercamiento(1), epoca_acercamiento(2), epoca_acercamiento(3),...
                                            epoca_acercamiento(4), epoca_acercamiento(5), epoca_acercamiento(6));
        fprintf(fid, '%f \t%f \t%f \t%f', THreltrue(cruces_dentro_caja_indices(i)) + 114.8, THreltrue(cruces_dentro_caja_indices(i)),...
                                          deltatrue(cruces_dentro_caja_indices(i)), R_mag(cruces_dentro_caja_indices(i)));                                   
        fprintf(fid, '\r\n'); % Añadir el salto de línea después de imprimir toda la época
      else
        fprintf(fid, '%s\r\n', epoca_acercamiento); % Si no es numérico, imprimir directamente con salto de línea
      end
    end

    fclose(fid);
    disp(['Se ha generado un reporte de acercamientos en el archivo: ', nombre_archivo_reporte]);
  end
else
  disp('No se detectaron cruces por la caja de control.');
end
