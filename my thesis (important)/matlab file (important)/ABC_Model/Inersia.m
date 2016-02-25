% Pachet  moment of inersii
%======== Date for callculation =========
d1=0.080;
d2=0.148;
del=0.55e-3;
cp=15e-3;
De=0.2093;
Di=0.0331;
hm=0.004;
ha=0.0114;
hz=0.0237;
%== Diametrs ========
Dsrm=(d2+d1)/2;
Dkz2=(De+d2)/2;
Dkz1=(d1+Di)/2;
Dval=0.8*Di;
Dsrz=Dsrm;
%======== MASSA=========
gamM=8300;
gamFe=7874;
gamAl=2700;%1700 Cteklovolokno;
Mmag=(pi/4*(d2^2-d1^2)*hm-cp*(d2-d1)*hm)*gamM;
Mz2=cp*(d2-d1)*hm*gamAl;
Mkz2=(De^2-d2^2)*pi/4*hm*gamAl;
Mkz1=(d1^2-Di^2)*pi/4*hm*gamAl;
Mval=0.8*Di^2*(ha+hz+del+0.02)*gamFe;
J=0.5*(Mmag*Dsrm^2+Mkz2*Dkz2^2+Mkz1*Dkz1^2+Mz2*Dsrz^2+Mval*Dval^2);
disp('Moment inersia [Kg*m^2] ');
disp(J);
disp('The end program');