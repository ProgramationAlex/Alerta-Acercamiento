% funci�n que cierra todas las ventanas de los plots al cerra la ventana 
% principal "plots"
function closemainplots(src,callbackdata)
  close(figure(2))   % vector de eccentricidad
  close(figure(3))   % vector de inclinaci�n
  close(figure(4))   % Caja de control
  close(figure(5))   % Error longitud
  close(figure(1))   % Grafica ECI
  close(figure(6))   % Grafica ECF
  close(figure(15))  % Paralelepipedo de control
  close(figure(13))  % Ground track
  close(figure(17))  % Ground track 3D
  close(figure(115)) % Interface Animaci�n caja de control
  close(figure(20))  % Animaci�n caja de control
  close(figure(116)) % Interface animaci�n ECI&ECF
  close(figure(21))  % Animaci�n ECI&ECF
  close(figure(13))  % Animaci�n groudtrack
  close(figure(9))   % Animaci�n first person satellite
  close(figure(119)) % Interface animaci�n huella
  close(figure(170)) % Animaci�n huella
  
  delete(figure(100))
end