% convierte cualquier �ngulo a uno que est� entre 0 y 360 grados
% IMPORTANTE para hacer el groundtrack

function ang=rev(phi)
  
  ang=phi-floor(phi/360)*360;