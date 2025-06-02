% propagador SDP4

% Lectura de la época de los TLE's
% TLE file name 
fname = 'tle.txt';

% Open the TLE file and read TLE elements
fid = fopen(fname, 'r');

% read first line
tline_tle = fgetl(fid);
epoch_tle = str2num(tline_tle(19:32));              % Epoch
year_tle = str2num(tline_tle(19:20));
days_tle = str2num(tline_tle(21:32));

% día Juliano
% El día del año. La época en los TLE's, para un valor de 1 corresponde a la 
% medianoche entre diciembre 31 y enero 1ro. Por tal motivo, para el cálculo
% de los días julianos es necesario restar un día.
JD_tle = julian_day(1,1,2000 + year_tle,0) + days_tle - 1;
wtierra = 7.2921158553e-5; 

%incre_tle = 10;         % incremento en minutos
%dur_dias_tle = 10; 
dur_dias_tle = Dur;
incre_tle = 1440 / rate_day;
dur_tle = 1440 * dur_dias_tle;      % duración en días
t_tle = 0 : incre_tle : dur_tle;   % vector de tiempo para el cálculo de efemérides (minutos)
t = t_tle *60;
tst = zeros(1,length(t_tle));
tst = JD_tle : incre_tle / 1440 : JD_tle + dur_dias_tle;

tic
testmat2
 
# generación de la matriz de  
z = [est_tle(:,1)';est_tle(:,4)';est_tle(:,2)';est_tle(:,5)';est_tle(:,3)';est_tle(:,6)'];  
JD = JD_tle;

toc  

%fclose(fid)
%T_ecf_tle = ((tst - 2451545)./ 36525);  % sideral time at the meridian Greenwich
%  th1_ecf_tle = 280.46061837 + 360.98564736629 * (tst - 2451545) + 0.000387933 * T_ecf_tle.^2 - (T_ecf_tle.^3 / 38710000);
%  th_ecf_tle = rev(th1_ecf_tle);
%cart_ecf_tle = zeros(6,length(t_tle));  
%# cálculo de las coordenadas catesianas en el sistema ECF
%
%GAST_tle = zeros(1,length(tst));
%  for i = 1 : length(tst)
%    corr = correctionobliq((tst(i) - 2451545)./36525);
%    GAST_tle(i) = th_ecf_tle(i) + corr(3) * cosd(corr(2));
%  endfor
%
%for i = 1 : length(t_tle)
%  cart_ecf_tle(:,i) = ECI2ECF([est_tle(i,1),est_tle(i,4),est_tle(i,2),est_tle(i,5),est_tle(i,3),est_tle(i,6),GAST_tle(i)]);
%endfor
%
%cart_ecf_true_tle = zeros(6,length(t_tle)); 
%for i = 1 : length(t_tle)
%  cart_ecf_true_tle(:,i) = MEMEdate2Truedate([cart_ecf_tle(:,i)',(tst(i) - 2451545)/36525]);
%endfor
%
%################################################################################
%# calculo de la longitud y latitud
%%dth_tle = zeros(1,length(t_tle));
%%for i = 1 : length(t_tle)
%%  if (cart_ecf_true_tle(3,i) < 0)
%%    dth_tle(i) = 360 + atan2d(cart_ecf_true_tle(3,i),cart_ecf_true_tle(1,i));
%%   else
%%    dth_tle(i) = atan2d(cart_ecf_true_tle(3,i),cart_ecf_true_tle(1,i));
%%  endif
%%endfor
%%dth_tle = dth_tle - 360;
%
%# calculo de la longitud y latitud
%dth_tle = zeros(1,length(t_tle));
%for i = 1 : length(t_tle)
%  dth_tle(i) = atan2d(cart_ecf_true_tle(3,i),cart_ecf_true_tle(1,i));
%endfor
%
%% cálculo de la ascención recta del satélite
%  
%%for i = 1 : length(t_tle)
%%  if (est_tle(i,2) < 0)
%%    alfa(i) = 360 + atan2d(est(i,2),est(i,1));
%%  else
%%    alfa(i) = atan2d(est(i,2),est(i,1));
%%    end
%%    end
%    
%% cálculo de la declinación
%delta_tle = zeros(1,length(t_tle));
%for i = 1 : length(t_tle)
%  delta_tle(i) = atand(cart_ecf_true_tle(5,i)./norm([cart_ecf_true_tle(3,i) cart_ecf_true_tle(1,i)]));
%  end
%################################################################################
%
%
%% Greenwich Apparent Sideral Time para el vector de tiempo
%% Una aproximación (sólo se considera la rotación de la tierra)
%%GASTi=app_sidereal_time_modif(JD);
%%GST=mod((180/pi)*60*wtierra*t+GASTi+(360-114.8),360);
%
%% otra aproximación
%% calcular el GAST con la fórmula
%for i = 1 : length(t_tle)
%  GST_tle(i) = mod(app_sidereal_time_modif(tst(i)) + (360 - 114.8),360);
%  end
%
%fid=fopen('cruce_caja.txt','w');
%fprintf(fid,'%s \r\n','Cruces por la caja MX3')
%
%%dth = zeros(1,length(t));
%% diferencias longitudinales
%for i = 1 : length(t_tle)
%%  dth(i) = GST(i) - alfa(i);
%%  if (abs(dth(i))> 180)
%%    dth(i) = abs(dth(i)) - 360;
%%    end
%    %if (dth(i) > -0.05 & dth(i) < 0.05 & delta(i) > -0.05 & delta(i) < 0.05)
%    if (and(dth_tle(i) > -114.85 , dth_tle(i) < -114.75 , delta_tle(i) > -0.05 , delta_tle(i) < 0.05))  
%      evento_tle(i,:) = calendar_day(JD_tle + (t_tle(i)./1440));
%      hri_tle = (evento_tle(i,3) - floor(evento_tle(i,3))) * 24;
%      hr_tle = fracc_hora(hri_tle);
%      fprintf(fid,'%d/%02d/%02d %02d:%02d:%02d.%03d %f\r\n',evento_tle(i,1),evento_tle(i,2),floor(evento_tle(i,3)),hr_tle(1),hr_tle(2),hr_tle(3),hr_tle(4),dth_tle(i));
%      evento_tle;
%      end
%  end
%  
%  fclose(fid);
%%  evento  
% 
%################################################################################
%mapa = imread('mapa3.png');
%MAPA=im2double(mapa);
%xmap=-180:360:180;
%ymap=-90:180:90;
%[Xmap,Ymap]=meshgrid(xmap,ymap); 
%  
%figure 1
%clf
%hold on
%grid on
%axis equal
%%axis ([-114.86 -114.74 -0.06 0.06])
%%axis ([-0.06+114.8 0.06+114.8 -0.06 0.06],'equal')
%ylim([-90 90])
%xlim([-180 180])
%line([-0.05 -0.05],[-5 5],'color','g','linewidth',1)
%line([0.05 0.05],[-5 5],'color','g','linewidth',1)
%line([-0.2 0.2],[.05 .05],'color','g','linewidth',1)
%line([-0.2 0.2],[-.05 -.05],'color','g','linewidth',1)
%line([0 0],[-5 5],'linestyle','-.','color','g','linewidth',1)
%line([-0.2 0.2],[0 0],'linestyle','-.','color','g','linewidth',1)
%# mapa
%h_mapa=surf(Xmap,-Ymap,0*Xmap);
%set(h_mapa,'cdata',MAPA,'Facecolor','texturemap','edgecolor','none')
%
%
%
%line([-114.75 -114.75],[-5 5],'color','g','linewidth',1)
%line([-114.85 -114.85],[-5 5],'color','g','linewidth',1)
%line([-180 180],[-.05 -.05],'color','g','linewidth',1)
%line([-180 180],[0.05 0.05],'linestyle','-.','color','g','linewidth',1)
%plot(dth_tle,delta_tle,'.y')
