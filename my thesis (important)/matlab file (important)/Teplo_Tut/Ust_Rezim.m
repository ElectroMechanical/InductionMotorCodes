%P2n=15000;   % [WT], nominal power
% Y-CONNECTED funtion mom.m
clc,% Callculation on Kopilov  I.P. "Proektirovanie"
global f Mc U
f=150;  % [Hz], nominal frequency 
Un=220; % [V], nomial  phace voltage 
%===========================================
%Input load torque- Mc=0 or power-P2=15000 [Wt]
%                   OR
%Input load torque- Mc=100 or power-P2=0 [Wt]
P2=0;  %P2= 25000 output power [Wt]
Mc=100; %Mc= 100 torque of load [N*m]
%============================================
U=Un*f/50;     % [V], nomial input phace voltage 
m=3;        %[ o.e] number of phace
pol=2;      % [o.e] number of par pole
w1=2*pi*f;  % frequensy of circuit [1/rad];
%==============================================
% Parametrs of T -basic circuit AD 
Rs=0.355;  % Resistance of phace stator,[Om]
Rr=0.186;  % Resistance of phace rotor,[Om]
Xs=0.673*f/50;  % Leakage reactance of phace stator,[Om]
Xr=0.912*f/50;  % Leakage reactance of phace  rotor,[Om]
Xm=27.14*f/50; % Main reactance of phace  stator and rotor,[Om]
Rm=1.47*(f/50)^1.6; % Resistance of iron losses,[Om]
% Callculation charakteristik
%======================================
Ws1=104;% number wound statora
ko1=0.958;% obmotocnii koefficient
D1=185e-3;% input diametr of statora
li=0.11;% lenght of statora
tau=pi*D1/2/pol;% polucnoe delenie
%==========================================
c1=sqrt(((Rs+Rm)^2+(Xs+Xm)^2)/(Rm^2+Xm^2));
skr=c1*Rr/(sqrt(Rs^2+(Xs^2+c1*Xr)^2));
Mkr=m*U^2*pol/(2*w1*c1*(Rs+sqrt(Rs^2+(Xs+c1*Xr)^2)));
%==========================================
if P2==0
    s=fzero('mom',[0 skr]);
    disp(['    ','Rezim  M=const']);
    elseif Mc==0
    [s]=feval('pow',P2);
    disp(['     ','Rezim P2=const']);
end
Pmex=117;
Pfe=369.5;
%Pdob=0.005*P1
Pdob=80;
%=======================================
Rd=Rr/s;
gr=Rd/(Rd^2+Xr^2); gm=Rm/(Rm^2+Xm^2);Rc=1/gm;
br=Xr/(Rd^2+Xr^2); bm=Xm/(Rm^2+Xm^2);Xmu=1/bm;
gz=gr+gm; bz=br+bm;
Rz=gz/(gz^2+bz^2);Xz=bz/(gz^2+bz^2);
R=Rs+Rz; X=Xs+Xz;
Is=U/sqrt(R^2+X^2);
Ed=Is*sqrt(Rz^2+Xz^2);
%==================================
FLUX=Ed/(4.44*f*ko1*Ws1);
Bdel=FLUX/(0.64*tau*li);
%==================================
Im=Ed/sqrt(Rm^2+Xm^2);
Ir=Ed/sqrt(Rd^2+Xr^2);
cos=Is*R/U;
dP=3*(Is^2*Rs+Im^2*Rm+Ir^2*Rr);
kpd=1-dP/(3*Is^2*R);
M=m*Ir^2*Rd*pol/w1;
Mkr=m*U^2*pol/(2*w1*c1*(Rs+sqrt(Rs^2+(Xs+c1*Xr)^2)));
P1=m*U*Is*cos;
P2=(P1-dP);
Pfe=m*Im^2*Rm;
%=====================================
Img=Ed/Rc;
Imr=Ed/Xmu;
Imz=sqrt(Img^2+Imr^2);
omega=2*pi*f/pol*(1-s);
%======================================
disp(['     ','Steady-state rezim']);
disp(['     ','=======================']);
disp(sprintf(['    ','f = %g [Hz]'],f));
disp(sprintf(['    ','S = %g [o.e]'],s));
disp(sprintf(['    ','Skr = %g [o.e]'],skr));
disp(sprintf(['    ','Mkr = %g [N*m]'],Mkr));
disp(sprintf(['    ','P2 = %g [Wt]'],P2));
disp(['     ','========================']);
disp(['     ','Series connection Rm and Xm']);
disp(sprintf(['    ','Ias = %g [A]'],Is));
disp(sprintf(['    ','Iam = %g [A]'],Im));
disp(['     ','=========================']);
disp(['     ','Parralel connection Rc and Xmu']);
disp(sprintf(['    ','Iac=%g [A]'],Img));
disp(sprintf(['    ','Iamu = %g [A]'],Imr));
disp(['     ','=========================']);
disp(sprintf(['    ','cos(fi) = %g [o.e.]'],cos));
disp(sprintf(['    ','kpd = %g [o.e.]'],kpd));
disp(sprintf(['    ','Mem = %g [N*m]'],M));
disp(sprintf(['    ','Pfe = %g [Wt]'],Pfe));
disp(sprintf(['    ','Pcu = %g [Wt]'],dP));
disp(sprintf(['    ','Omegar = %g [1/s]'],omega));
disp(sprintf(['    ','Bdel = %g [T]'],Bdel));
%==========================================
s1=0:0.02:1;
w11=2*pi*f/pol;
c1=sqrt(((Rs+Rm)^2+(Xs+Xm)^2)/(Rm^2+Xm^2));
zn1=(s1.*Rs+c1*Rr).^2+s1.^2.*(Xs+c1*Xr).^2;
M=m*U^2*Rr.*s1./(w11.*zn1);
figure(1)
H26=plot(s1,M,'-b'); grid,
set(H26,'LineWidth',2);
hx26=XLABEL('s, [o.e]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('Mem [N*m] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title('Torque vs slip');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
disp(['     ','The end program' ]); 