script;
format short e
clc,
clear,
%===========================
%  Номинальные данные AD 
%    TYPE AIR-160-S4
%=================================
disp('      Type  < AIR-160-S4 >'),
fn=50;      % Частота сети,гц
p=2;        % Число пар полюсов
p2n=15000;  % Мощность, Вт
u1n=380;    % VOLTAGE, V
sn=0.02;    % Скольжение
kpdn=0.875; % КПД;
kosn=0.87;% Коэфициент мощности
mk=2.9;   % Кратность максимального момента 
ki=7;     % Кратность пускового тока
%======================== 
r1=0.98820;  x1=1.2190;
rm =2.4444;  xm=47.365;
%========================
r2=0.48003;  x2=1.022; % iz callculation
%r2=0.513;  x2=0.179; % cos i km
%r2=1.13;   x2=4.24;  % kpd i km
%r2=0.826;  x2=-26.3; % kpd i cos
%===========================
%r2=1.09;  x2=3.95;  xm=113.81;% kpd, cos i km
%=========================
% Расчет характеристик АД
%=========================
pmex=292.171;
pct=411.141;
pdob=p2n/kpdn*0.005;
c1=sqrt(((r1+rm)^2+(x1+xm)^2)/(rm^2+xm^2));
rc=r2*((r1/r2*c1)^2+(x1/x2*c1+x2/xm)^2);
p2=p2n+pdob+pmex;
a=3*u1n^2/(2*p2)-r1;
b=2*a+rc;
sn=(a-sqrt(a^2-c1^2*r2*b))/b;
s=sn;
%==============================
%r2=0.2:0.05:1.5;x2=0.2:0.05:1.5;
[r2,x2]=meshgrid(0.2:0.4:1.2,0.2:0.4:1.2);
aa=xm.^2+rm.^2;
zm=sqrt(aa);
gm=rm./zm.^2; bm=xm./zm.^2;
z22=r2.^2+(x2.*s).^2;
g2=r2.*s./z22;
gm2=g2+gm;
b2=x2.*s.^2./z22;
bm2=b2+bm;
ym2=gm2.^2+bm2.^2;
rm2=gm2./ym2;
rsum=rm2+r1;
xm2=bm2./ym2;
xsum=x1+xm2;
zsum=sqrt(rsum.^2+xsum.^2);
is=u1n./zsum;
p1=3.*rsum.*is.^2;
pel1=3.*r1.*is;
p12=p1-(pel1+pct);
pel2=p12.*s;
delp=pel1+pel2+pct+pmex+pdob;
p2=p1-delp;
%======================
kpd1=(1-delp./p1);
kos1=rsum./zsum;
%========================
n1=60.*fn./p;
nr=n1.*(1-s);
w0=2.*pi.*fn./p;
m=p2./w0./(1-s);
skr=c1.*r2./sqrt(r1.^2+(x1+c1.*x2).^2);
%=================================
gf=2.*r1./c1./r2;% Delectorskii
es=skr.^2+gf.*s.*skr.^2+s.^2;
km=es./(s.*skr.*(2+gf));
%Mmax=m*km;
%=======================
figure(1);
%surf(r2,x2,km);
surf(r2,x2,kpd1);
xlabel('r2');
ylabel('x2');
zlabel('Kpd');
%======================
figure(2);
surf(r2,x2,kos1);
xlabel('r2');
ylabel('x2');
zlabel('Cos(fi)');
%colormap pink
%brighten(0.5)
%========================
%The end;


