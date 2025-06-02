% función que cierra todas las ventanas de los plots al cerra la ventana 
% principal "plots"
function closemain(src,callbackdata)
  delete(gcf)
  exit
end