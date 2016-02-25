function yp=vpk1(t,y);
% Systems of differensial equestion for cordinates PSI(1:4),
% Starting characteristic of the sinusoidal supplied induction motor 
% Parameters taked out diplom work of LAPUNOVOY ELENI ,
% Script file AD3_1.m, 
%==================================
global aa1 aa2 aa3 aa4  a4 a5 mc n1,
%==================================
% Differensial equestions
%=================================
if n1==1
  kr=1+0.133.*(1-y(5)).^3;% CU
elseif n1==2
  kr=1+0.035.*(1-y(5)).^3; % AL
else 
  kr=1+0.113.*(1-y(5)).^3; %LATUN
end   
yp(1)=cos(t)-aa1.*y(1)+aa2.*y(3);
yp(2)=sin(t)-aa1.*y(2)+aa2.*y(4);
yp(3)=aa3.*y(1).*kr-aa4.*y(3).*kr-y(5).*y(4);
yp(4)=aa3.*y(2).*kr-aa4.*y(4).*kr+y(5).*y(3);
yp(5)=(a4.*(y(2).*y(3)-y(1).*y(4))-mc).*a5;
yp=[yp(1); yp(2); yp(3); yp(4); yp(5)];
%===========================
%The end;