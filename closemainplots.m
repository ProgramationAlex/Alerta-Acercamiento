% función que cierra todas las ventanas de los plots al cerra la ventana 
% principal "plots"
function closemainplots(src,callbackdata)
  close(figure(2))   % vector de eccentricidad
  close(figure(3))   % vector de inclinación
  close(figure(4))   % Caja de control
  close(figure(5))   % Error longitud
  close(figure(1))   % Grafica ECI
  close(figure(6))   % Grafica ECF
  close(figure(15))  % Paralelepipedo de control
  close(figure(13))  % Ground track
  close(figure(17))  % Ground track 3D
  close(figure(115)) % Interface Animación caja de control
  close(figure(20))  % Animación caja de control
  close(figure(116)) % Interface animación ECI&ECF
  close(figure(21))  % Animación ECI&ECF
  close(figure(13))  % Animación groudtrack
  close(figure(9))   % Animación first person satellite
  close(figure(119)) % Interface animación huella
  close(figure(170)) % Animación huella
  
  delete(figure(100))
end