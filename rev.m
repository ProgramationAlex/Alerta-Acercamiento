% convierte cualquier ángulo a uno que esté entre 0 y 360 grados
% IMPORTANTE para hacer el groundtrack

function ang=rev(phi)
  
  ang=phi-floor(phi/360)*360;