 script,
 clc; %Callculation  Diff. Equestion of AD with Rmu
 clf; % File - ABC_dq.m. 
% Use File M-function <<ad_dq.m>> - diff. equestions of AD 
%      Nominal date
tic; % start computer timer
% tstart=clock; %2-variant
global A Rs Rr Rmu pol Jr Mnom w1 Km Kj Un k 
%================================================
%P2n=1700;  % nominal power [WT] 
%n=987;     % [rout/min] nominal speed of rotor pri f=50
%m=3;       % number of phace, Y-CONNECTED,
Pmex=7;     % mecanical losses
Pdob=10.5;   % dobavochie losses
In=4.3;     % nomial phace current [A],
f=50;       % nominal frequency [Hz], 
Un=220*sqrt(2)*(f/50);% nomial input phace voltage [V],
pol=3;      % number of par pole [o.e], 
Mnom=17.46; % Torque of load [N*m]
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
Xm=82.53; % Main reactance of phace  stator and rotor,[Om]
Rmu=5.49*(f/50)^1.6; % Resistance of iron losses,[Om]
l1s=Xs/w1; l2r=Xr/w1; M=Xm/w1;
Ls=l1s+M; Lr=l2r+M;
Km=pol/sqrt(3); 
Kj=pol/Jr;
% Formirovanie matriz;
M1=M/2; M2=M*sqrt(3)/2;
M3=M/sqrt(3);
%========================
Lsr=[Ls 0 0 M 0;
    0 Ls 0 -M1 M2; 
    0 0 Ls -M1 -M2;
    M 0 0 Lr 0;
    0 M3 -M3 0 Lr];
A=inv(Lsr);
%     Nachalnie yclovie
%==========================================
t0=0;     
tfinal=0.2;
y0=zeros(1,6);  
%=====================================
[t,y]=ode45(@ad_dq,[t0,tfinal],y0');
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
%imq=zeros(n,1);
%========================================
Ps=zeros(n,1);
Qs=zeros(n,1);
P2=zeros(n,1);
Pfe=zeros(n,1);
tfin=length(t);
tpusk=round(tfin/2);
%=======================================
ia(:,1)=A(1,1).*y(:,1)+A(1,2).*y(:,2)+A(1,3).*y(:,3)+A(1,4).*y(:,4)+A(1,5).*y(:,5);
ib(:,1)=A(2,1).*y(:,1)+A(2,2).*y(:,2)+A(2,3).*y(:,3)+A(2,4).*y(:,4)+A(2,5).*y(:,5);
ic(:,1)=A(3,1).*y(:,1)+A(3,2).*y(:,2)+A(3,3).*y(:,3)+A(3,4).*y(:,4)+A(3,5).*y(:,5);
id(:,1)=A(4,1).*y(:,1)+A(4,2).*y(:,2)+A(4,3).*y(:,3)+A(4,4).*y(:,4)+A(4,5).*y(:,5);
iq(:,1)=A(5,1).*y(:,1)+A(5,2).*y(:,2)+A(5,3).*y(:,3)+A(5,4).*y(:,4)+A(5,5).*y(:,5);
%================================================
ima(:,1)=ia(:,1)+id(:,1);
imb(:,1)=ib(:,1)-id(:,1).*M1+ iq(:,1).*M2;
imc(:,1)=ic(:,1)-id(:,1).*M1- iq(:,1).*M2;
%me(:,1)=Km.*(y(:,1).*(ib(:)-ic(:))+y(:,2).*(ic(:)-ia(:))+y(:,3).*(ia(:)-ib(:)));
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
IntPfe=trapz(t(1:tpusk,1),Pfe(1:tpusk,1))/t(tpusk,1);
%IntPs1=mean(Ps(1:tpusk,1));
%IntQs1=mean(Qs(1:tpusk,1));
IntPs=trapz(t(1:tpusk,1),Ps(1:tpusk,1))/t(tpusk,1);
IntQs=trapz(t(1:tpusk,1),Qs(1:tpusk,1))/t(tpusk,1);
effv=IntPs/sqrt(IntPs^2+IntQs^2);% cos(fi)v
%==================================================
me(:,1)=3/2.*pol.*(y(:,5).*id-y(:,4).*iq);
P2(:,1)=me(:,1).*y(:,6)./pol;
IntP2=trapz(t(1:tpusk,1),P2(1:tpusk,1))/t(tpusk,1);
kpdv=IntP2/IntPs; % kpdnom
%===================================================
P2n=(P2(tfin,1)-Pmex-Pdob);
kpdn=P2n/Ps(tfin,1);
effn=Ps(tfin,1)/sqrt(Ps(tfin,1)^2+Qs(tfin,1)^2); % cos(fi)nom
%==================================================
Mmax=max(me(:,1));
Km=Mmax/Mnom;
Imax=max(ia(:,1));
Ki=Imax/In;
%============================================
omegr=y(tfin,6)/pol;
IAd=sqrt(1/3*(ia(tfin,1)^2+ib(tfin,1)^2+ic(tfin,1)^2));
%disp([' ','Km=Myd/Mnom','  ','Ki=Iyd/Inom']);
%disp([Km,Ki]);
%============================================
figure(1),
subplot(4,4,[1,2,5,6]);
H1=plot(t(:,1),ia(:,1),'g');grid;
set(H1,'LineWidth',2);
hy1=YLABEL('I_{A} [A]');
set(hy1,'FontSize',10,'FontWeight','bold');
ht1=title('Currents ');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
%============================================
subplot(4,4,[9,10,13,14]);
H4=plot(t(:,1),ima(:,1),'b');grid;
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
%============================================================
figure(2)
subplot(1,2,1);
H26=plot(t(:,1),y(:,6),'r');grid;
set(H26,'LineWidth',2);
hx26=XLABEL('t, [c]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('\omega_{R} [1/c] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title('Angular rotor"s speed ');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=============================================================
e=toc;% end computer timer
%e1=etime(clock,tstart);% 2-variant
%disp(e1);
%===================================
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
%==================================================================
%figure(3)% Grafik Ps i Qs
%subplot(1,2,1);
%H12=plot(t(:,1),Ps(:,1),'r');grid;
%set(H12,'LineWidth',2);
%hx41=XLABEL('t, [c]'); 
%set(hx41,'FontSize',10,'FontWeight','bold');
%hy12=YLABEL('p_{S} [Wt]');
%set(hy12,'FontSize',10,'FontWeight','bold');
%ht12=title('Active power' );
%set(ht12,'FontSize',12,'FontName','Arial','FontWeight','bold');
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