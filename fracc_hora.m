% conversión de fracción de horas a hora min sec
function hora = fracc_hora(x)
  hr = floor(x);
  min_dec = x - floor(x);
  min = 60 * min_dec;
  sec_dec = min - floor(min);
  sec = 60 * sec_dec;
  mil_sec = sec - floor(sec);
  
  hora = [floor(hr) floor(min) floor(sec) floor(mil_sec * 1000)];