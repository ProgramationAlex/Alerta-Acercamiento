% cálculo del dia Juliano

function JD=julian_day(D,M,Y,UT)

%D=1;              % día (1-31)
%M=1;              % mes (1-12)
%Y=2000;           % año (1801-2099)
%UT1=0;            % universal time (0-24)

JD =367*Y-floor((7*(Y+floor((M+9)/12)))/4)+floor((275*M)/9)+D+1721013.5+(UT/24)-(0.5*sign(100*Y+M-190002.5))+0.5;
UT=(JD-2451545)/36525;   % sideral time at the meridian Greenwich