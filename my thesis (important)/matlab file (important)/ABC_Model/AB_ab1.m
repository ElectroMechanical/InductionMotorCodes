 script,
 clc; %Callculation  Diff. Equestion of AD with Rmu
 clf; % File - AB_ab1.m. 
 tic;% start computer timer
% Use File M-function <<ad_ab1.m>> - diff. equestions of AD 
%      Nominal date
global Rs Rr Rmu l1s l2r M pol Jr Mnom w1 Km Kj Un k
%================================================
%P2n=1700;  % nominal power [WT] 
%n=987;     % [rout/min] nominal speed of rotor
%m=3;       % number of phace, Y-CONNECTED,
Pmex=7;     % mecanical losses
Pdob=10.5;   % dobavochie losses
In=4.3;     % nomial phace current [A],
f=50;       % nominal frequency [Hz], 
Un=220*sqrt(2)*f/50;% nomial input phace voltage [V],
pol=3;      % number of par pole [o.e], 
Mnom=17.46;    % Torque of load [N*m]
Mn=17.46;   % nominal torque of load [N*M],
Jr=1.48e-2; % Moment inertia of rotora,[Kg*M^2],
w1=2*pi*f;  % frequensy of circuit [1/rad];
k=0;% timer number of iteration
%==============================================
% Parametrs of T -basic circuit AD 
Rs=3.57;  % Resistance of phace stator,[Om]
Rr=3.8;   % Resistance of phace rotor,[Om]
Xs=4.99;  % Leakage reactance of phace stator,[Om]
Xr=8.28;  % Leakage reactance of phace  rotor,[Om]
Xm=82.9; % Main reactance of phace  stator and rotor,[Om]
Rmu=1.24e3; % Resistance of iron losses,[Om]
l1s=Xs/w1; l2r=Xr/w1; M=Xm/w1;
Ls=l1s+M; Lr=l2r+M;
Km=pol/sqrt(3); 
Kj=pol/Jr;
%==========================================
%     Nachalnie yclovie
%==========================================
t0=0;     
tfinal=0.2;
y0=zeros(1,7);  
%=====================================
[t,y]=ode45(@ad_ab1,[t0,tfinal],y0');
n=length(t);
me=zeros(n,1);
ia=zeros(n,1);
ib=zeros(n,1);
id=zeros(n,1);
iq=zeros(n,1);
ica=zeros(n,1);
icb=zeros(n,1);
Ps=zeros(n,1);
Qs=zeros(n,1);
P2=zeros(n,1);
Pfe=zeros(n,1);
%====================
tfin=length(t);
tpusk=round(tfin/2);
%===================================================
ia(:,1)=(y(:,1)-M.*y(:,5))/l1s;
ib(:,1)=(y(:,2)-M.*y(:,6))/l1s;
id(:,1)=(y(:,3)-M.*y(:,5))/l2r;
iq(:,1)=(y(:,4)-M.*y(:,6))/l2r;
ica(:,1)=y(:,5)-ia(:,1)-id(:,1);
icb(:,1)=y(:,6)-ib(:,1)-iq(:,1);
Ps(:,1)=3/2*(Un.*sin(w1.*t(:,1)).*ia(:,1)+Un.*sin(w1.*t(:,1)-pi./2).*ib(:,1));
Qs(:,1)=-3/2*(Un.*sin(w1*t(:,1)).*ib(:,1)-Un.*sin(w1*t(:,1)-pi./2).*ia(:,1));
Pfe(:,1)=Rmu.*(ica(:,1).^2+icb(:,1).^2);
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
me(:,1)=3/2.*pol.*(y(:,4).*id(:,1)-y(:,3).*iq(:,1));
%me(:,1)=3/2*pol.*M/Lr*(y(:,4).*(id(:,1)+ica(:,1))-y(:,3).*(iq(:,1)+icb(:,1)));% in dq
%================================================================================
P2(:,1)=me(:,1).*y(:,7)./pol;
IntP2=trapz(t(1:tpusk,1),P2(1:tpusk,1))/t(tpusk,1);
kpdv=IntP2/IntPs; % kpdnom
P2n=P2(tfin,1)-Pmex-Pdob;
%=================================================================
kpdn=(P2(tfin,1)-Pmex-Pdob)/Ps(tfin,1);
effn=Ps(tfin,1)/sqrt(Ps(tfin,1)^2+Qs(tfin,1)^2); % cos(fi)nom
%=================================================================
Mmax=max(me(:,1));
Km=Mmax/Mn;
Imax=max(ia(:,1));
Ki=Imax/In;
%disp([' ','Km=Myd/Mnom','  ','Ki=Iyd/Inom']);
%disp([Km,Ki]);
omegr=y(tfin,7)/pol;
IAd=sqrt(ia(tfin,1)^2+ib(tfin,1)^2)/sqrt(2);
%============================================
figure(1),
subplot(4,4,[1,2,5,6]);
H1=plot(t(:,1),ia(:,1),'g');grid;
set(H1,'LineWidth',2);
hy1=YLABEL('I_{A} [A]');
set(hy1,'FontSize',10,'FontWeight','bold');
ht1=title('Currents ');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
%===============================================================
subplot(4,4,[9,10,13,14]);
H4=plot(t(:,1),ica(:,1),'b');grid;
set(H4,'LineWidth',2);
hx4=XLABEL('t, [c]'); 
set(hx4,'FontSize',10,'FontWeight','bold');
hy4=YLABEL('I_{mA} [A]');
set(hy4,'FontSize',10,'FontWeight','bold');
%===========================================
subplot(4,4,[3,4,7,8,11,12,15,16]);
H2=plot(t(:,1),me(:,1),'r');grid;
set(H2,'LineWidth',2);
hx2=XLABEL('t, [c]');
set(hx2,'FontSize',10,'FontWeight','bold');
ht2=title(' M_{e} [N*m] ');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=============================================================
figure(2)
subplot(1,2,1);
H26=plot(t(:,1),y(:,7),'r');grid;
set(H26,'LineWidth',2);
hx26=XLABEL('t, [c]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('\omega_{R} [1/c] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title('Angular rotor"s speed ');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=============================================================
e=toc;% end computer timer
subplot(1,2,2);
axis('off');
h1=text(0.1,1.05,'REZULT CALCULATION','FontSize',10);
h1=text(0.3,1,'Start duty','FontSize',10);
h1=text(0.1,0.95,' ------------------------------------');
h1=text(0.1,0.9,sprintf('Km= %g [o.e];',Km),'FontSize', 10);
h1=text(0.1,0.85,sprintf('Ki= %g [o.e];',Ki),'FontSize', 10);
h1=text(-0.04,0.8,'Average value Ps, Qs, kpd, cos(fi)','FontSize', 10);
h1=text(0.1,0.75,sprintf('Ps= %g [Wt];',IntPs),'FontSize', 10);
h1=text(0.1,0.7,sprintf('Qs= %g [Var];',IntQs),'FontSize', 10);
h1=text(0.1,0.65,sprintf('Pfe= %g [Wt];',IntPfe),'FontSize', 10);
h1=text(0.1,0.60,sprintf('Kpd= %g [o.e];',kpdv),'FontSize', 10);
h1=text(0.1,0.55,sprintf('Cos(fi)= %g [o.e];',effv),'FontSize', 10);
h1=text(0.3,0.5,' Nominal duty ','FontSize', 10);
h1=text(0.1,0.45,' --------------------------------------');
h1=text(0.1,0.4,sprintf('IA= %g [A];',IAd),'FontSize', 10);
h1=text(0.1,0.35,sprintf('Kpd= %g [o.e];',kpdn),'FontSize', 10);
h1=text(0.1,0.3,sprintf('Cos(fi)= %g [o.e];',effn),'FontSize', 10);
h1=text(0.1,0.25,sprintf('Pfe= %g [Wt];',Pfen),'FontSize', 10);
h1=text(0.1,0.2,sprintf('Omega= %g [1/c];',omegr),'FontSize', 10);
h1=text(0.1,0.15,sprintf('P2= %g [Wt];',P2n),'FontSize', 10);
h1=text(0.1,0.10,sprintf('M= %g [N*m];',Mnom),'FontSize', 10);
h1=text(0.1,0.05,sprintf('Computer time= %g [c];',e),'FontSize', 10);
%============================================
%subplot(1,2,2);
%H42=plot(t(:,1),Qs(:,1),'b');grid;
%set(H42,'LineWidth',2);
%hx42=XLABEL('t, [c]'); 
%set(hx42,'FontSize',10,'FontWeight','bold');
%hy42=YLABEL('Q_{S} [VAr]');
%set(hy42,'FontSize',10,'FontWeight','bold');
%ht22=title('Reactive power');
%set(ht22,'FontSize',12,'FontName','Arial','FontWeight','bold');
disp(' The end of program');
%==========================================
% Various formuls of torque
%me(:)=Km.*(y(:,1).*(ib(:,1)-ic(:,1))+y(:,2).*(ic(:,1)-ia(:,1))...
%+y(:,3).*(ia(:,1)-ib(:,1)));
%Pmd(:,1)=y(:,4)-id(:,1).*l2r;
%Pmq(:,1)=y(:,5)-iq(:,1).*l2r;
%me(:,1)=3/2*pol*(Pmq(:,1).*id(:,1)-Pmd(:,1).*iq(:,1));% in  coordinate dq Psm*Ir