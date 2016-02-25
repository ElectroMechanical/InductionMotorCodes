function y=mom(Mc),% Callculation slips for Mc=const
global U f;% script file Ust_Rezim.m
m=3;       % number of phace, Y-CONNECTED,
pol=2;     % number of par pole [o.e], 
%==============================================
% PARAMETRS OF T-oi CIRCUIT AD
Rs=0.355;  % Resistance of phace stator,[Om]
Rr=0.186;  % Resistance of phace rotor,[Om]
Xs=0.673*f/50;  % Leakage reactance of phace stator,[Om]
Xr=0.912*f/50;  % Leakage reactance of phace  rotor,[Om]
Xm=27.14*f/50; % Main reactance of phace  stator and rotor,[Om]
Rm=1.47*(f/50)^1.6; % Resistance of iron losses,[Om]
% Callculation sleep s=f(Mc) po ZAICHIKU V.M. "Elektrichestvo" N7,1979 y
%==============================================================
w1=2*pi*f/pol;
c1=sqrt(((Rs+Rm)^2+(Xs+Xm)^2)/(Rm^2+Xm^2));
K=m*U^2/(2*w1*Mc*c1)-Rs;
zk=K+sqrt(K^2-Rs^2-(Xs+c1*Xr)^2);
y=c1*Rr/zk;

