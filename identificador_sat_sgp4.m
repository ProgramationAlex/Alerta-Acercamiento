# Lectura del identificador del sat�lite
fid=fopen('tle.txt','r');
tline_sgp4 = fgetl(fid);
id_sat = tline_sgp4(3:8)
%fclose(fid); % l�nea agregada 19/05/2025