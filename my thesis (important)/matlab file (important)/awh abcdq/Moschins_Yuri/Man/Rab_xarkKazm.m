script;
format short e
clc,
clear,
%===========================
%  Номинальные данные AD 
%    TYPE 4A-160-S4 (Kazman)
%=================================
disp('      Type  < 4A-160-S4 >'),
fn=50;      % Частота сети,гц
p=2;        % Число пар полюсов
p2n=15000;  % Мощность, Вт
u1n=380;    % VOLTAGE, V
sn=0.016;    % Скольжение
kpdn=0.89; % КПД;
kosn=0.893;% Коэфициент мощности
mk=2.0;   % Кратность максимального момента 
ki=7;     % Кратность пускового тока
%======================== 
r1=1.1;  x1=1.74;
rm =4.4;  xm=85.2;
r2=0.37;  x2=3.8; 
%=========================
% Расчет характеристик АД
%=========================
pmex=123;
pct=264;
pdob=p2n/kpdn*0.005;
c1=sqrt(((r1+rm)^2+(x1+xm)^2)/(rm^2+xm^2));
rc=r2*((r1/r2*c1)^2+(x1/x2*c1+x2/xm)^2);
p2=p2n+pdob+pmex;
a=3*u1n^2/(2*p2)-r1;
b=2*a+rc;
sn=(a-sqrt(a^2-c1^2*r2*b))/b;
s=sn;
zm=sqrt(xm^2+rm^2);
gm=rm/zm^2; bm=xm/zm^2;
z22=r2^2+(x2*s)^2;
g2=r2*s/z22;
gm2=g2+gm;
b2=x2*s^2/z22;
bm2=b2+bm;
ym2=gm2^2+bm2^2;
rm2=gm2/ym2;
rsum=rm2+r1;
xm2=bm2/ym2;
xsum=x1+xm2;
zsum=sqrt(rsum^2+xsum^2);
is=u1n/zsum;
p1=3*rsum*is^2;
pel1=3*r1*is;
p12=p1-(pel1+pct);
pel2=p12*s;
delp=pel1+pel2+pct+pmex+pdob;
p2=p1-delp;
%======================
kpd1=(1-delp/p1);
kos1=rsum/zsum;
%======================
n1=60*fn/p;
nr=n1*(1-s);
w0=2*pi*fn/p;
m=p2/w0/(1-s);
skr=c1*r2/sqrt(r1^2+(x1+c1*x2)^2);
%skr1=c1*r2/(x1+c1*x2);
%=================================
R2kr=2*r1*skr/(c1*r2);
km=(s/skr+skr/s+R2kr)/(2+R2kr);
Mmax=m*km;
%========================
disp(['   ',' РАБОЧИЕ ХАРАКТЕРИСТИКИ AD Power P2=15000 [Вт]'])
disp(['   ',' Mnom','         ',' kpd','         ',' cosfi','       ' ,'sn']);
bbp=[m,kpd1,kos1,s,];
disp(bbp);
disp(['   ','skr ','          ','Mmax','          ','Km']);
disp([skr,Mmax,km]);
%The end;


