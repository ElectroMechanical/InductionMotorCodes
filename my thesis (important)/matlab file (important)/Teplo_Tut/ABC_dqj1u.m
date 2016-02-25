 script,
 clc; %Callculation  Diff. Equestion of AD with Rmu
 clf; % File - ABC_dqju.m. 
 tic;% start computer total timer
% Use File M-function <<ad_dqj1u.m>> - diff. equestions of AD 
%      Nominal date
global Rs Rr Rmu l1s l2r M pol Jr Mnom w1 Km Kj Un k OMEG
%================================================
%P2n=1700;  % nominal power [WT] 
%n=697;     % [rout/min] nominal speed of rotor
%m=3;       % number of phace, Y-CONNECTED,
Pmex=1;     % mecanical losses
Pdob=1;   % dobavochie losses
f=25;       % nominal frequency [Hz],
%if f<=50
% Un=220*sqrt(2)*f/50;% nomial input phace voltage [V],
%else
Un=220*sqrt(2)*f/50;
%end 
pol=3;      % number of par pole [o.e], 
Jr=1.48e-2; % Moment inertia of rotora,[Kg*M^2],
w1=2*pi*f;  % frequensy of circuit [1/rad];
k=0;% timer number of iteration
%==============================================
% Parametrs of T -basic circuit AD 
Rs=3.57;  % Resistance of phace stator,[Om]
Rr=3.8;   % Resistance of phace rotor,[Om]
Xs=4.99*f/50;  % Leakage reactance of phace stator,[Om]
Xr=8.28*f/50;  % Leakage reactance of phace  rotor,[Om]
Xmu=82.53*f/50; % Main reactance of phace  stator and rotor,[Om]
Rmu=5.49*(f/50)^1.6; % Resistance of iron losses,[Om]
%======================================================
ka=Rmu/Xmu;
R0=Rmu*(1+1/ka^2);
X0=Xmu*(1+ka^2);
Xm=X0;
Rmu=R0;
%=======================================================
%Xm=82.9; % Main reactance of phace  stator and rotor,[Om]
%Rmu=1.24e3*(f/50)^0.4; % Resistance of iron losses,[Om]
l1s=Xs/w1; l2r=Xr/w1; M=Xm/w1;
Ls=l1s+M; Lr=l2r+M;
Km=pol/sqrt(3); 
Kj=pol/Jr;
s=0.025;
OMEG=2*pi*f*(1-s);
%=====================================
%     Nachalnie yclovie
%=====================================
t0=0;     
tfinal=0.2;
y0=zeros(1,8); 
%=====================================
[t,y]=ode45(@ad_dqj1u,[t0,tfinal],y0');
n=length(t);
me=zeros(n,1);
ia=zeros(n,1);
ib=zeros(n,1);
ic=zeros(n,1);
id=zeros(n,1);
iq=zeros(n,1);
ica=zeros(n,1);
icb=zeros(n,1);
icc=zeros(n,1);
Ps=zeros(n,1);
Qs=zeros(n,1);
P2=zeros(n,1);
Pfe=zeros(n,1);
%====================
tfin=length(t);
tpusk=round(tfin/2);
%===================================================
%Lm0=0.2628;% Lbaz [Hn]
%===================================================
ia(:,1)=(y(:,1)-M.*y(:,6))/l1s;
ib(:,1)=(y(:,2)-M.*y(:,7))/l1s;
ic(:,1)=(y(:,3)-M.*y(:,8))/l1s;
id(:,1)=(y(:,4)-M.*y(:,6))/l2r;
iq(:,1)=(y(:,5)-M.*(y(:,7)-y(:,8))/sqrt(3))/l2r;
ica(:,1)=y(:,6)-ia(:,1)-id(:,1);
icb(:,1)=y(:,7)-ib(:,1)+id(:,1)/2-iq(:,1)*sqrt(3)/2;
icc(:,1)=y(:,8)-ic(:,1)+id(:,1)/2+iq(:,1)*sqrt(3)/2;
Ps(:,1)=Un.*sin(w1.*t(:,1)).*ia(:,1)+Un.*sin(w1.*t(:,1)-2.*pi./3).*ib(:,1)...
+Un.*sin(w1.*t(:,1)+2.*pi./3).*ic(:,1);
Qs(:,1)=1/sqrt(3).*(Un.*sin(w1*t(:,1)).*(ic(:,1)-ib(:,1))...
+Un.*sin(w1*t(:,1)-2.*pi./3).*(ia(:,1)-ic(:,1))...
+Un.*sin(w1*t(:,1)+2.*pi./3).*(ib(:,1)-ia(:,1)));
Pfe(:,1)=Rmu.*(ica(:,1).^2+icb(:,1).^2+icc(:,1).^2);
%==================================================
%Pfen=2/3*(ica(tfin,1)^2+icb(tfin,1)^2+icc(tfin,1)^2)*Rmu;
Imd=min(ica(tpusk:n,1));
Pfen=3/2*Imd^2*Rmu;
%==================================================
IntPfe=trapz(t(1:tpusk,1),Pfe(1:tpusk,1))/t(tpusk,1);
IntPs=trapz(t(1:tpusk,1),Ps(1:tpusk,1))/t(tpusk,1);
IntQs=trapz(t(1:tpusk,1),Qs(1:tpusk,1))/t(tpusk,1);
effv=IntPs/sqrt(IntPs^2+IntQs^2);% cos(fi)v
%===================================================
me(:,1)=3/2.*pol.*(y(:,5).*id-y(:,4).*iq);% in dq
mend=me(end,1);
%================================================================
P2(:,1)=me(:,1).*OMEG./pol;
IntP2=trapz(t(1:tpusk,1),P2(1:tpusk,1))/t(tpusk,1);
kpdv=IntP2/IntPs; % kpdnom
P2n=P2(tfin,1)-Pmex-Pdob;
%=================================================================
kpdn=(P2(tfin,1)-Pmex-Pdob)/Ps(tfin,1);
effn=Ps(tfin,1)/sqrt(Ps(tfin,1)^2+Qs(tfin,1)^2); % cos(fi)nom
%===============================================================
omegr=OMEG/pol;
IAd=sqrt(1/3*(ia(tfin,1)^2+ib(tfin,1)^2+ic(tfin,1)^2));
%=============================================================
figure(1)
subplot(1,2,1);
H26=plot(t(:,1),me(:,1),'r');grid;
set(H26,'LineWidth',2);
hx26=XLABEL('t, [c]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('[N*m] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title('Torque M_e ');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=============================================================
e=toc;% end  total  timer
subplot(1,2,2);
axis('off');
h1=text(0.15,0.55,' Ustanoviv. rezim ','FontSize', 12);
h1=text(0.1,0.5,' --------------------------------------');
h1=text(0.1,0.45,sprintf('S= %g [o.e];',s),'FontSize', 10);
h1=text(0.1,0.4,sprintf('IA= %g [A];',IAd),'FontSize', 10);
h1=text(0.1,0.35,sprintf('Kpd= %g [o.e];',kpdn),'FontSize', 10);
h1=text(0.1,0.3,sprintf('Cos(fi)= %g [o.e];',effn),'FontSize', 10);
h1=text(0.1,0.25,sprintf('Pfe= %g [Wt];',Pfen),'FontSize', 10);
h1=text(0.1,0.2,sprintf('Omega= %g [1/c];',omegr),'FontSize', 10);
h1=text(0.1,0.15,sprintf('P2= %g [Wt];',P2n),'FontSize', 10);
h1=text(0.1,0.10,sprintf('M= %g [N*m];',mend),'FontSize', 10);
h1=text(0.1,0.05,sprintf('Total time= %g [c];',e),'FontSize', 10);
%============================================
disp(' The end of program');
%==========================================
% Various formuls of torque
%me(:)=Km.*(y(:,1).*(ib(:,1)-ic(:,1))+y(:,2).*(ic(:,1)-ia(:,1))...
%+y(:,3).*(ia(:,1)-ib(:,1)));
%Pmd(:,1)=y(:,4)-id(:,1).*l2r;
%Pmq(:,1)=y(:,5)-iq(:,1).*l2r;
%me(:,1)=3/2*pol*(Pmq(:,1).*id(:,1)-Pmd(:,1).*iq(:,1));% in  coordinate dq Psm*Ir