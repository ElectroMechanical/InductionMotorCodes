
% This file is part of TA001.
% TA001 is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% any later version.

% TA001 is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with TA001.  If not, see (http://www.gnu.org/licenses/).
% Callculation coefficients a1-a11  of Dif. Eq. 
%================================================
% DIPLOM  CDPM-60: P2=60 Wt: 
clear;
clc;
%======================================
% Nominal dates
%======================================
P2n=60;%[Wt]   rated output power
Unfaz=220;% [V]rated input phase voltage
Eofaz=79.18;%[V]
Infaz=0.2082;%[A]
m=3;            %no. of phase
p=2; f1=50;     %p=pole , f1=sinchronous frequency
omegc=2*pi*f1;  %angular velocity 
kr=1.5;
J=kr*0.00039268;%[Kg*M^2]; moment of inertia
E0=sqrt(2)*Eofaz;
Xs=57.6225;     %stator impedence
Xsd=307.9488 ; Xsq= 980.7075 ; 
Xad=Xsd-Xs; Xaq=Xsq-Xs; 
XrD=96.1963;
XrQ=39.9400;
Xrd=Xad+XrD ; Xrq=Xaq+XrQ;
Rs=106.5603;  
Rrd=132.8282; Rrq=56.5313;
%===================================================
% Callulation basic units
Ub=sqrt(2)*Unfaz; Ib=sqrt(2)*Infaz; Zb=Ub/Ib; Pb=m*Ub*Ib/2;
omegab=omegc; tb=1/omegab; 
Psib=Ub*tb; Mb=p*Pb*tb; Jb=p*Mb*(tb)^2;
%=============================================
disp(  '');
disp('  ===============================================');
disp('      Basic parametrs  '); 
disp('  ===============================================');
disp('     Ub          Ib       Zb       tb');
disp([Ub, Ib, Zb, tb]);
disp('     Pb         Psib        Mb');
disp([Pb, Psib, Mb]);
disp(['    ','Jb']);
disp(Jb);
rs=Rs/Zb; rd=Rrd/Zb; rq=Rrq/Zb;
xsd=Xsd/Zb; xsq=Xsq/Zb; xad=Xad/Zb; xaq=Xaq/Zb;
xrd=Xrd/Zb; xrq=Xrq/Zb;e0=E0/Ub; j=J/Jb;
disp('');
disp('  ===========================================================');
disp('      Parametrs SDPM in relative units [o.e]');
disp('  ===========================================================');
disp('     Rs         Rrd        Rrq       Xsd      Xsq       Xrd');
disp([rs,rd, rq, xsd, xsq, xrd]);
disp('     Xrq         J        Xad       Xaq       e0');
disp([xrq, j, xad, xaq, e0]); 
%===============================================
%Callculation of koefficients
%=================================
a1=rs; a2=rd/xrd; a3=rd*xad/xrd;
a4=rq*xaq/xrq; a5=rq/xrq; a6=1/j;
a7=xrd/(xsd*xrd-(xad)^2);
a8=xad/(xsd*xrd-(xad)^2);
a9=(xrd-xad)/(xsd*xrd-(xad)^2);
a10=xrq/(xsq*xrq-(xaq)^2);
a11=xaq/(xsq*xrq-(xaq)^2);
%====================== Dislpay ==============================
disp(  '');
disp('  ========================================================');
disp('      Koefficients a1, a2, a3.......a11 and e0');
disp('  =========================================================');
disp('     a1         a2        a3       a4        a5        a6');
disp([a1,a2 a3 a4 a5 a6]);
disp('     a7         a8        a9       a10       a11        e0');
disp([a7, a8, a9, a10, a11, e0]); 
disp('      The End program');
TA002;
