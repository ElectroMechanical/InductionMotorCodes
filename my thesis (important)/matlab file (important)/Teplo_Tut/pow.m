function y=pow(P2),% Callculation slips for P2=const
global U f;% script file Ust_Rezim.m
m=3;       % number of phace, Y-CONNECTED,
pol=3;      % number of par pole [o.e], 
%==============================================
% Parametrs of T -basic circuit AD 
Rs=0.355;  % Resistance of phace stator,[Om]
Rr=0.186;  % Resistance of phace rotor,[Om]
Xs=0.673*f/50;  % Leakage reactance of phace stator,[Om]
Xr=0.912*f/50;  % Leakage reactance of phace  rotor,[Om]
Xm=27.14*f/50; % Main reactance of phace  stator and rotor,[Om]
Rm=1.47*(f/50)^1.6; % Resistance of iron losses,[Om]
% Callculation charakteristik
%==============================================================
%Pdob=0.005*P1
Pmex=117;
Pfe=369.5;
Pdob=80;
P2=P2+Pmex+Pdob+Pfe;
%==============================================================
c1=sqrt(((Rs+Rm)^2+(Xs+Xm)^2)/(Rm^2+Xm^2));
A=m*U^2/(2*P2)-Rs;
Rp=Rr*((Rs/Rr*(1+Xr/Xm))^2+(Xs/Rr+(1+Xr/Xm)+Xr/Rr)^2);
B=2*A+Rp;
y=(A-sqrt(A^2-c1^2*Rr*B))/B;