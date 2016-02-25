 script,
 clc;
 clf;
% File - ABC_ab.m: Callculation  Diff. Equestion of AD
% Use File M-function <<ad_ab.m>> - diff. equestions of AD 
%      Nominal date
global A Rs Rr pol Jr Mnom w1 Km Kj Un k 
%================================================
%P2n=2200;   % [WT], nominal power
% Y-CONNECTED
%n=1425;     % [rout/min] nominal speed of rotor
%m=3;       %[ o.e] number of phace
In=5;     % [A], nomial phace current 
Un=220*sqrt(2);% [V], nomial input phace voltage 
f=50;       % [Hz], nominal frequency  
pol=2;      % [o.e] number of par pole
Mnom=17.46; %[N*M] nominal torque of load 
Jr=1.48e-2; % Moment inertia of rotora,[Kg*M^2]
w1=2*pi*f;  % frequensy of circuit [1/rad];
k=0;% timer number of iteration
%==============================================
% Parametrs of T -basic circuit AD 
Rs=4.09;  % Resistance of phace stator,[Om]
Rr=2.397;   % Resistance of phace rotor,[Om]
Xs=3.439;  % Leakage reactance of phace stator,[Om]
Xr=6.36;  % Leakage reactance of phace  rotor,[Om]
Xm=94.773; % Main reactance of phace  stator and rotor,[Om]
l1s=Xs/w1; l2r=Xr/w1;M=Xm/w1;
Ls=l1s+M; Lr=(l2r+M);
Km=pol/sqrt(3);
Kj=pol/Jr;
% Formirovanie matriz;
%========================
Lsr=[Ls 0 0 M 0; 
    0 Ls 0 0 M; 
    0 0 Ls -M -M;
    M 0 0 Lr 0;
    0 M 0 0 Lr];
A=inv(Lsr);
%     Nachalnie yclovie
%=====================================
t0=0;     
tfinal=0.2;
y0=zeros(1,6);  
%=====================================
[t,y]=ode45(@ad_ab,[t0,tfinal],y0');
n=length(t);
me=zeros(n,1);
ia=zeros(n,1);
ib=zeros(n,1);
ic=zeros(n,1);
%=========================================================================
% Toki statora
ia(:)=A(1,1).*y(:,1)+A(1,2).*y(:,2)+A(1,3).*y(:,3)+A(1,4).*y(:,4)+A(1,5).*y(:,5);
ib(:)=A(2,1).*y(:,1)+A(2,2).*y(:,2)+A(2,3).*y(:,3)+A(2,4).*y(:,4)+A(2,5).*y(:,5);
ic(:)=A(3,1).*y(:,1)+A(3,2).*y(:,2)+A(3,3).*y(:,3)+A(3,4).*y(:,4)+A(3,5).*y(:,5);
%==========================================================================
me(:)=Km.*(y(:,1).*(ib(:)-ic(:))+y(:,2).*(ic(:)-ia(:))+y(:,3).*(ia(:)-ib(:)));
Mmax=max(me(:));
Km=Mmax/Mnom;
Imax=max(ia(:));
Ki=Imax/In;
disp([' ','Km=Myd/Mnom','  ','Ki=Iyd/Inom']);
disp([Km,Ki]);
%============================================
figure(1),
subplot(4,4,[1,2,5,6]);
H1=plot(t(:),ia(:),'g');grid;
set(H1,'LineWidth',2);
%hx1=XLABEL('t, [c]');
%set(hx1,'FontSize',10,'FontWeight','bold');
hy1=YLABEL('I_{A} [A]');
set(hy1,'FontSize',10,'FontWeight','bold');
ht1=title(' Current I_{A} vs time ');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
%============================================
subplot(4,4,[9,10,13,14]);
H4=plot(t(:),y(:,6),'b');grid;
set(H4,'LineWidth',2);
hx4=XLABEL('t, [c]'); 
set(hx4,'FontSize',10,'FontWeight','bold');
hy4=YLABEL('N_{r} [rad/c]');
set(hy4,'FontSize',10,'FontWeight','bold');
%===========================================
subplot(4,4,[3,4,7,8,11,12,15,16]);
H2=plot(t(:),me(:),'k');grid;
set(H2,'LineWidth',2);
hx2=XLABEL('t, [c]');
set(hx2,'FontSize',10,'FontWeight','bold');
ht2=title(' Torque [N*m] vs time ');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=========================================
figure(2),
H3=plot(t(:),y(:,1),'b');grid;
set(H3,'LineWidth',2);
hx3=XLABEL('t, [c]');
set(hx3,'FontSize',10,'FontWeight','bold');
hy3=YLABEL('Psi_A, [Wb]');
set(hy3,'FontSize',10,'FontWeight','bold');
ht3=title(' Psi_{A} vs time ');
set(ht3,'FontSize',12,'FontName','Arial','FontWeight','bold');
disp(' The end of program');