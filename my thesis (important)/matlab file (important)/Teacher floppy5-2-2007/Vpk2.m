function yp=vpk2(t,y);
% Systems of differensial equation for cordinates PSI(1:4);
% Starting characteristic of the restangular-wave inverter fed
% induction motor (AD+PCH)
% Parameters taked out diplom's work of(ORLOV MIXAIL) LAPUNOVOY ELENI ,
% Script file AD3_1.m, 
%==================================
global aa1 aa2 aa3 aa4  a4 a5 mc n1,
%==================================
% Differensial equations
%==================================
% Riad Furie for Ualfa and Ubetta
%==================================
% 1- METOD ( ychet 1, 5, 7, 9 and 11 garmonik)
ua=cos(t)+cos(5.*t)./5+cos(7.*t)./7+cos(9.*t)./9+cos(11.*t)./11;
ub=sin(t)+sin(5.*t)./5+sin(7.*t)./7+sin(9.*t)./9+sin(11.*t)./11;
yp(1)=ua-aa1.*y(1)+aa2.*y(3);
yp(2)=ub-aa1.*y(2)+aa2.*y(4);
%==================================
% 2- METOD (use funchion floor(x))
%um=1.047;  
%tet=3.*t./pi; x=floor(tet);
%yp(1)=um.*cos(pi./3.*x)-aa1.*y(1)+aa2.*y(3);
%yp(2)=um.*sin(pi./3.*x)-aa1.*y(2)+aa2.*y(4);
%===================================
yp(3)=aa3.*y(1)-aa4.*y(3)-y(5).*y(4);
yp(4)=aa3.*y(2)-aa4.*y(4)+y(5).*y(3);
yp(5)=(a4.*(y(2).*y(3)-y(1).*y(4))-mc).*a5;
yp=[yp(1); yp(2); yp(3); yp(4); yp(5)];
%==========================================
%The end;