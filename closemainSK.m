% funci�n que cierra todas las ventanas de los plots al cerra la ventana 
% principal "plots"
function closemainSK(src,callbackdata)
  close(figure(10))   % vector de drift
  close(figure(11))   % vector de eccentricidad
  close(figure(13))   % sun pointing perigee error
  close(figure(12))   % vector de inclinaci�n
  close(figure(105))  % interface maniobra drift
  close(figure(30))   % Grafica drift
  close(figure(40))   % gr�fica eccentricidad
  close(figure(106))  % interface maniobra inclinaci�n
  close(figure(32))   % grafica vector inclinaci�n
  close(figure(31))   % gr�fica vector inclinaci�n (X4)
  
  
  
  
  delete(figure(104))
end