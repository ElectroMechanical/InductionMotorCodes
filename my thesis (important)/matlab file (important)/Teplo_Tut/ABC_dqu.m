 script,
 global A Rs Rr Rmu pol Jr Mnom w1 Km Kj Un k OMEG
 clc; %Callculation  Diff. Equestion of AD with Rmu
 clf; % File - ABC_dqu.m. 
% Use File M-function <<ad_dqu.m>> - diff. equestions of AD 
%      Nominal date
tic; % start computer timer
% tstart=clock; %2-variant
%================================================
%P2n=1700;  % nominal power [WT] 
%n=987;     % [rout/min] nominal speed of rotor pri f=50
%m=3;       % number of phace, Y-CONNECTED,
Pmex=1;     % 7 mecanical losses
Pdob=1;  % 10.5 dobavochie losses
In=4.3;     % nomial phace current [A],
f=25;       % nominal frequency [Hz], 
Un=220*sqrt(2)*(f/50);% nomial input phace voltage [V],
pol=3;      % number of par pole [o.e], 
Mnom=15.3; % Torque of load [N*m]
Mn=15.3;   % nominal torque of load [N*M],
Jr=1.e-2; % Moment inertia of rotora,[Kg*M^2],
w1=2*pi*f;  % frequensy of circuit [1/rad];
k=0;% timer number of iteration
%==============================================
% Parametrs of T -basic circuit AD 
Rs=3.57;  % Resistance of phace stator,[Om]
Rr=3.8;   % Resistance of phace rotor,[Om]
Xs=4.99*f/50;  % Leakage reactance of phace stator,[Om]
Xr=8.28*f/50;  % Leakage reactance of phace  rotor,[Om]
Xm=82.53*f/50; % Main reactance of phace  stator and rotor,[Om]
Rmu=5.49*(f/50)^1.6; % Resistance of iron losses,[Om]
l1s=Xs/w1; l2r=Xr/w1; M=Xm/w1;
Ls=l1s+M; Lr=l2r+M;
Km=pol/sqrt(3); 
Kj=pol/Jr;
%====================================
%s=input('Input slip S=');
s=0.025;
OMEG=2*pi*f*(1-s);
%================================================
% Formirovanie matriz;
M1=M/2; M2=M*sqrt(3)/2;
M3=M/sqrt(3);
%==========================
Lsr=[Ls 0 0 M 0;
    0 Ls 0 -M1 M2; 
    0 0 Ls -M1 -M2;
    M 0 0 Lr 0;
    0 M3 -M3 0 Lr];
A=inv(Lsr);
%     Initial date
%==========================================
t0=0;     
tfinal=0.2;
y0=zeros(1,5); 
%=========================================
[t,y]=ode45(@ad_dqu,[t0,tfinal],y0');
n=length(t);
me=zeros(n,1);
ia=zeros(n,1);
ib=zeros(n,1);
ic=zeros(n,1);
id=zeros(n,1);
iq=zeros(n,1);
ima=zeros(n,1);
imb=zeros(n,1);
imc=zeros(n,1);
%========================================
Ps=zeros(n,1);
Qs=zeros(n,1);
P2=zeros(n,1);
Pfe=zeros(n,1);
tfin=length(t);
tpusk=round(tfin/2);
%==========================================================================
ia(:,1)=A(1,1).*y(:,1)+A(1,2).*y(:,2)+A(1,3).*y(:,3)+A(1,4).*y(:,4)+A(1,5).*y(:,5);
ib(:,1)=A(2,1).*y(:,1)+A(2,2).*y(:,2)+A(2,3).*y(:,3)+A(2,4).*y(:,4)+A(2,5).*y(:,5);
ic(:,1)=A(3,1).*y(:,1)+A(3,2).*y(:,2)+A(3,3).*y(:,3)+A(3,4).*y(:,4)+A(3,5).*y(:,5);
id(:,1)=A(4,1).*y(:,1)+A(4,2).*y(:,2)+A(4,3).*y(:,3)+A(4,4).*y(:,4)+A(4,5).*y(:,5);
iq(:,1)=A(5,1).*y(:,1)+A(5,2).*y(:,2)+A(5,3).*y(:,3)+A(5,4).*y(:,4)+A(5,5).*y(:,5);
%================================================
ima(:,1)=ia(:,1)+id(:,1);
imb(:,1)=ib(:,1)-id(:,1).*M1+ iq(:,1).*M2;
imc(:,1)=ic(:,1)-id(:,1).*M1- iq(:,1).*M2;
Ps(:,1)=Un.*sin(w1.*t(:,1)).*ia(:,1)+Un.*sin(w1.*t(:,1)-2.*pi./3).*ib(:,1)...
+Un.*sin(w1.*t(:,1)+2.*pi./3).*ic(:,1);
Qs(:,1)=1/sqrt(3).*(Un.*sin(w1*t(:,1)).*(ic(:,1)-ib(:,1))...
+Un.*sin(w1*t(:,1)-2.*pi./3).*(ia(:,1)-ic(:,1))...
+Un.*sin(w1*t(:,1)+2.*pi./3).*(ib(:,1)-ia(:,1)));
Pfe(:,1)=Rmu.*(ima(:,1).^2+imb(:,1).^2+imc(:,1).^2);
%====================================================
Imd=min(ima(tpusk:n,1));
Pfen=3/2*Imd^2*Rmu;
%==================================================
me(:,1)=3/2.*pol.*(y(:,5).*id-y(:,4).*iq);
mend=me(end,1);
P2(:,1)=me(:,1).*OMEG./pol;
%===================================================
P2n=(P2(tfin,1)-Pmex-Pdob);
kpdn=P2n/Ps(tfin,1);
effn=Ps(tfin,1)/sqrt(Ps(tfin,1)^2+Qs(tfin,1)^2); % cos(fi)nom
%==================================================
omegr=OMEG/pol;
%omegr=y(tfin,6)/pol;
IAd=sqrt(1/3*(ia(tfin,1)^2+ib(tfin,1)^2+ic(tfin,1)^2));
%disp([' ','Km=Myd/Mnom','  ','Ki=Iyd/Inom']);
%disp([Km,Ki]);
%============================================
figure(1)
subplot(1,2,1);
%H26=plot(t(:,1),y(:,2),'r');grid;
H26=plot(t(:,1),id(:,1),'r');grid;
set(H26,'LineWidth',2);
hx26=XLABEL('t, [c]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('Id [A] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title('Current Id ');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=============================================================
e=toc;% end computer timer
%e1=etime(clock,tstart);% 2-variant
%disp(e1);
%=============================================================
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
%==================================================================
disp(' The end of program');