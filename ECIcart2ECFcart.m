% transformación de coordenadas de ECI a ECF (MEME of date)

global ECF
tic
tiempo = JD + (t / 86400);
  T_ecf = ((tiempo - 2451545)./ 36525);  % sideral time at the meridian Greenwich
  th1_ecf = 280.46061837 + 360.98564736629 * (tiempo - 2451545) + 0.000387933 * T_ecf.^2 - (T_ecf.^3 / 38710000);
  th_ecf = rev(th1_ecf);
    
  % transformación de las coordenadas x, y & z
  ECF = zeros(6,length(t));
  for i = 1 : length(t)
    ECF(:,i) = ECI2ECF([z(1,i);z(2,i);z(3,i);z(4,i);z(5,i);z(6,i);th_ecf(i)]);
  endfor
  toc