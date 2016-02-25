script,
% Systems of differential equations of three-phase symmetrical
% induction motors for flux linkage (PSI). 
% Program function Vpk1 used for sinus voltage
% Parameters taked of LAB_work  N0 1  17.10.04 year
% for file Diplom2_2kWt.mdl, serve as input parameter file
% for alpha-beta model
% Programmer Yu. A. Moshinskii, 
%=======================================================
clc,
clear,  %to clear data and functions in moemory
%==============================
disp('            === Type AD-42-6 ===');
P2n=1700; % Nominal power [Wt]
fn=50;    % Nominal frequency of voltage [Hz]
p=3;     % Number of poles pair; 
nc=1000; % Synchronous angular frequency of rotor [turn/min]
omegc=2*pi*nc/60;% Sinchronous angular frequency [1/cec] 
sn=0.07; % Nominal slip of rofor;
cosn=0.75; % Nominal efficiency
kpdn=0.795;% Nominal koeffisient aktive work
Ufn=220;% Nominal  voltage of phase[V]
m=3;% Number of stator phases;
%============================================
% Parameteres of equivalent circuit phace IM
%============================================
rs=3.57;%  Resistanse of stator,[Ohm]
rr=3.8; % ALumin  Resistance of rotor,[Ohm]
%=============================================
xm=82.52;  % Mutual inductive resistance of stator and rotor,[Ohm]
xs=4.99; % Dissipated inductive resistance of stator,[Ohm] 
xr=8.28; % Dissipated inductive resistance of rotor,[Ohm]
ls=(xs+xm)/(2*pi*fn); % Inductance of stator,[Hen] 
lr=(xr+xm)/(2*pi*fn);% Inductance  of rotor,[Hen]
M=xm/(2*pi*fn);  % Mutual inductance of stator and rotor,[Hen]
jr=0.0148; % Moment of inertia,[KG*M^2)]
%============================
disp('    Mnom     Inom');
Inom=P2n/(m*Ufn*kpdn*cosn);% Nominal current of phase, [A]
Mnom=P2n/omegc/(1-sn);% Nominal moment, [N*M];
%============================
% Calculation of bases units (BLOK 2)
%============================
disp([Mnom Inom]);
%========================================
% Parameters of differensial equations (DE) 
% Calculation of coefficients DE 
%=========================================
a1=rs*lr/(ls*lr-M^2);
a2=rs*M/(ls*lr-M^2);
a3=rr*M/(ls*lr-M^2);
a4=rr*ls/(ls*lr-M^2);
a5=p/jr;
a6=3*p*M/(2*(ls*lr-M^2));
a7=lr/(ls*lr-M^2);
a8=M/(ls*lr-M^2);
a9=a8/M*ls;


disp('    a1         a2        a3       a4');
disp([a1 a2 a3 a4]);
disp('    a5        a6         a7       a8         a9'); 
disp([a5 a6 a7 a8 a9]);
disp(['      ',' !=========================!']);
disp('                ---The end---- ')

dQmodel2;
