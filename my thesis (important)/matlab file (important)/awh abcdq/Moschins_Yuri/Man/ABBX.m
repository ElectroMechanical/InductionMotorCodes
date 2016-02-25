script,
clc;
% Calculation u=f(alfa) and moment M=f(s)
% motors  firm of ABB
%                  Nominal dates:
%--------------------------------------------
%clear,clg,clc,
p2n=250;  %[WT],
In=2.3;   %[A],
u1n=220;   %[V], 
jr=2.2e-3;%[kg*m*m];
fnom=50;  %[Hz]
n=1384;   %[rout/min]
p=2;
unom=u1n;
%=====================================================
%      Parametrs of T sxemi zameshenia
%------------------------------------------------
r1=50.5;   %[OM] 
x1=16.18;  %[OM]
xm=354;    %[OM]
r2=25.58;  %[OM]
x2=31.34;  %[OM]
%=====================
wc1=2*pi*fnom/p;
%=====================
s=0.01:0.01:1;
alfa=s;
z1u=r1./alfa+j*x1;
z2u=r2./alfa+j*x2;
zmu=j*xm;
z12u=z2u.*zmu./(z2u+zmu);
zu=z1u+z12u;
%======================
z1=r1+j*x1;
z2=r2./s+j*x2;
zm=j*xm;
z12=z2.*zm./(z2+zm);
z=z1+z12;
%ku1=abs(zu).*abs(z12)./(abs(z).*abs(z12u)).*alfa;
ku=abs(z)./abs(zu);
%u=ku;
ax=[0.0100   0.0162    0.3125
   0.0500    0.1285    1.3472
   0.1000    0.2385    2.2492
   0.2000    0.4067    3.2100
   0.3000    0.5294    3.5562
   0.4000    0.6249    3.6159
   0.5000    0.7038    3.5437
   0.6000    0.7715    3.4134
   0.7000    0.8330    3.2608
   0.8000    0.8906    3.1035
   0.9000    0.9459    2.9500
   1.0000    1.0000    2.8043];
figure(1)
hp1=plot(s,s,'r',s,ku,'g');grid ;%hold on
set(hp1,'LineWidth',2);
%plot(s,ku1,'y',s,s,'r');grid on;
%plot(ax(:,1),ax(:,2),'b');grid on;
hx1=xlabel('alfa, [o.e]');
set(hx1,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
hy1=ylabel(' u, [o.e]');
set(hy1,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
htx=text(0.21,0.63,'u=real');
set(htx,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
htx1=text(0.61,0.53,'U/f=const');
set(htx1,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
ht1=title ('Grafik function u = U/Unom with alfa = f/fnom');
set(ht1,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
%hold off;
figure(2)
hp2=plot(ax(:,1),ax(:,3),'g');grid on;
set(hp2,'LineWidth',2);
hx2=xlabel('Sleep [o.e.]');
set(hx2,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
hy2=ylabel(' M, [N*M]');
set(hy2,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
ht2=title (' Grafik function M(S) ');
set(ht2,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
% The end;
