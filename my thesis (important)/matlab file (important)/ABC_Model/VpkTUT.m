function yp=vpk1(t,y);
%  Sistems of diffferensial equestion for  
%  cordinates PSI(1:4),
% Paramerrs used in diplom of LAPUNOVA ELEN ;
% Script file AD3a_TUT.m, 
%==================================
global aa1 aa2 aa3 aa4  a4 a5 Mc Un w1,
%==================================
% Differensial equestions
%=================================
if t<0.06;
    Mn=0;
else 
    Mn=Mc;
end;
 if t<=0.05
   %==================================
%   U/f=const; 1-variant
Utalfa=20*Un.*t.*cos(20.*t.*w1.*t); 
Utbeta=20*Un.*t.*sin(20.*t.*w1.*t);
%==================================
%    U=kt;  2-variant
%Utalfa=20*Un.*t.*cos(w1.*t);
%Utbeta=20*Un.*t.*sin(w1.*t);
%===================================
%      3-variant
%Utalfa=Un.*cos(w1.*t);
%Utbeta=Un.*sin(w1.*t);
else
    Utalfa=Un.*cos(w1.*t);
    Utbeta=Un.*sin(w1.*t);
end
if t>=0.3 % DC brake - tormoz
    Utalfa=100;% Ualfa=Ua
    Utbeta=-57.4;% Ubet=(Ub-Uc)/sqrt(3)
    Mn=0;
    aa1=88.1*3;% Vkluchenie Rs+Rdob=3*Rs
    aa2=80*3;  % Vkluchenie Rs+Rdob=3*Rs
end;
if y(5)<=-0.01
    Utalfa=0;
    Utbeta=0;
end;
yp(1)=Utalfa-aa1.*y(1)+aa2.*y(3);
yp(2)=Utbeta-aa1.*y(2)+aa2.*y(4);
yp(3)=aa3.*y(1)-aa4.*y(3)-y(5).*y(4);
yp(4)=aa3.*y(2)-aa4.*y(4)+y(5).*y(3);
yp(5)=(a4.*(y(2).*y(3)-y(1).*y(4))-Mn).*a5;
yp=[yp(1); yp(2); yp(3); yp(4); yp(5)];
return;
%===========================
%The end;