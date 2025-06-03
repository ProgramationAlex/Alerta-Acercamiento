function hr_frcc=fracc_hora_inv(hr,min,sec,seg3)
  fr_sec=seg3/1000;
  secT=sec+fr_sec;
  fr_min=secT/60;
  minT=min+fr_min;
  fr_hr=minT/60;
  hr_frcc=hr+fr_hr;