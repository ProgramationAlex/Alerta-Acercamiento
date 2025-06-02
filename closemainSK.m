% función que cierra todas las ventanas de los plots al cerra la ventana 
% principal "plots"
function closemainSK(src,callbackdata)
  close(figure(10))   % vector de drift
  close(figure(11))   % vector de eccentricidad
  close(figure(13))   % sun pointing perigee error
  close(figure(12))   % vector de inclinación
  close(figure(105))  % interface maniobra drift
  close(figure(30))   % Grafica drift
  close(figure(40))   % gráfica eccentricidad
  close(figure(106))  % interface maniobra inclinación
  close(figure(32))   % grafica vector inclinación
  close(figure(31))   % gráfica vector inclinación (X4)
  
  
  
  
  delete(figure(104))
end