%P2n=1700;   % [WT], nominal power
% Y-CONNECTED
clc,
s=0.062;     % nominal sleep 
n=958;      % [rout/min] nominal speed of rotor
m=3;        %[ o.e] number of phace
In=4.3;     % [A], nomial phace current
U=220;     % [V], nomial input phace voltage 
f=50;       % [Hz], nominal frequency  
pol=3;      % [o.e] number of par pole
Mnom=17.46; %[N*M] nominal torque of load 
Jr=1.48e-2; % Moment inertia of rotora,[Kg*M^2]
w1=2*pi*f;  % frequensy of circuit [1/rad];
%==============================================
% Parametrs of T -basic circuit AD 
Rs=3.57;  % Resistance of phace stator,[Om]
Rr=3.8;   % Resistance of phace rotor,[Om]
Xs=4.99;  % Leakage reactance of phace stator,[Om]
Xr=8.28;  % Leakage reactance of phace  rotor,[Om]
Xm=82.53; % Main reactance of phace  stator and rotor,[Om]
Rm=5.49; % Resistance of iron losses,[Om]
% Callculation charakteristik
%================================
Rd=Rr/s;
gr=Rd/(Rd^2+Xr^2); gm=Rm/(Rm^2+Xm^2);Rc=1/gm;
br=Xr/(Rd^2+Xr^2); bm=Xm/(Rm^2+Xm^2);
gz=gr+gm; bz=br+bm;
Rz=gz/(gz^2+bz^2);Xz=bz/(gz^2+bz^2);
R=Rs+Rz; X=Xs+Xz;
Is=U/sqrt(R^2+X^2);
Ed=Is*sqrt(Rz^2+Xz^2);
Im=Ed/sqrt(Rm^2+Xm^2);
Ir=Ed/sqrt(Rd^2+Xr^2);
cos=Is*R/U;
dP=3*(Is^2*Rs+Im^2*Rm+Ir^2*Rr);
kpd=1-dP/(3*Is^2*R);
M=m*Ir^2*Rd*pol/w1;
P1=m*U*Is*cos;
P2=(P1-dP);
Pfe=m*Im^2*Rm;
%============================
Img=Ed/Rc;
Imr=Ed/Xm;
Imz=sqrt(Img^2+Imr^2);
%============================
disp(['     ','P1','        ','P2 [Wt]']);
disp([P1,P2]);
disp(['     ','Is','        ','Im','       ','Ir [A]']);
disp([Is,Im,Ir]);
disp(['    ','kos(fi)','    ','kpd  [o.e.]']);
disp([cos,kpd]);
disp(['    ','Mem',' [N*m]  ']);
disp(M);
disp(['    ','Pfe','     ','Pcu [Wt]']);
disp([Pfe,dP]);
    