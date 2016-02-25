script,
clc;
%File-REZIM; Calculation of matrix for Ustanov. rezim AD
%=======================================================
%               Nominal date
%P2n=1700;                        %[Wt], nominal power
%In=4.3;                          %[A], nominal phase current
%Y-connected
Un=220;                           %[V], nomial input phase voltage
f=50;                             %[Hz], nominal frequency
pol=3;                            %[o.e],number of pole pair
n=697;                            %rout/min] nominal speed of rotor
n1=750;                           %sinxron frequency rotate
sn=(n1-n)/n1;                     %nominal slip
m=3;                              %[o.e],number of phase
Mnom=17.46;                       %[N.m],nominal torque of load
w1=2*pi*f;                        %frequency of circuit [1/rad]
%================================================================
%Parameters of T-basis ckt AD
R1=3.57;
R2=3.8;
X1=4.99;
X2=8.28;
Xm=82.52;
Rm=2.1;
%Rormirovanie matirx;
s=0.064; %s=sn
a=R2/s;
gr=a/(a^2+X2^2); gm=Rm/(Rm^2+Xm^2);
br=X2/(a^2+X2^2); bm=Xm/(Rm^2+Xm^2);
G12=gr+gm; B12=br+bm;
R12=G12/(G12^2+B12^2);  X12= B12/(G12^2+B12^2);
Rsum=R1+R12;  Xsum=X1+X12;
I1=Un/sqrt(Rsum^2+Xsum^2);
Eb=I1*sqrt(R12^2+X12^2);
I2=Eb/sqrt(a^2+X2^2);
cosfi=I1*Rsum/Un;
kpd=I2^2*R2*(1-s)/(I1^2*s*Rsum);
Mem=m*pol*I2^2*a/w1;
disp(['     ','I1[A]','     ','I2[A]','    ','M2 [Nm]','   ','kpd[oe]','   ','cosfi[oe]']);
disp([I1 I2 Mem kpd cosfi]);
%==========================================================================
Xs=X1+Xm;
Zs=R1+i*Xs;
Xr=X2+Xm;
Zr=R2+i*Xr;
Xm1=Xm*(1-s)/sqrt(3);
Xr1=Xr*(1-s)/sqrt(3);
V1=Zs*[1 1 1];
V2=j*Xm*[1 1 1];
V11=diag(V1);V12=diag(V2);
V21=[j*Xm Xm1 -Xm1; -Xm1 j*Xm Xm1;Xm1 -Xm1 j*Xm];
V22=[Zr Xr1 -Xr1; -Xr1 Zr Xr1;Xr1 -Xr1 Zr];
V=[V11 V12;V21 V22];
A1=inv(V);
fi=2*pi/3;
UA=Un;
%UB=Re((Un*exp(i*fi));
UB=Un*exp(i*fi);
%UC=Re((Un*exp(-i*fi));
UC=Un*exp(-i*fi);
U=[UA UB UC 0 0 0]';
Y=A1*U;
disp('  IA    IB     IC');
disp([Y(1) Y(2) Y(3)]');
disp([abs(Y(1)) abs(Y(2)) abs(Y(3))]');
