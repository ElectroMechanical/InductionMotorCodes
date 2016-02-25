script;% SINCHRON GENEROTOR WITH UNDK35T5
clc;
%echo on
%       Calculation of sinchron generator with Permanent Magnet;
%        =====================================================     
disp(' Student of group EL-11-03:  Kuznetsov A.S.');
%   Input data (Starting data):
%  =========================
disp(' Magnit UNDK35T5')
sn=2000; % NOMINAL POWER Sn, [VA],
un=230;  % NOMINAL VOLTAGE Un, [V],
m=3; %%  NUMBER OF PHACES m,
in=sn/m/un;  % Nominal current, [A],
cos_fi=0.7; % COS(fi) [p.u],
p=4; % NUMBER OF PAIRS POLE,
f1=400; % SUPLY FREGUENSY f1 ,[Hz],
ai=0.9; % Coefficient pole perekritia [p.u],
u=0.9;  % COEFFISIENT SNIZENIA VOLTAGE , u=Uíîì/E0 [p.u],
%    Construction coefficients ,
%   ===========================
kcim=0.6; % kcim=bm/tau,
lamdd=0.96/sqrt(p);% lamda=lm/dm ,
kd=0.8; % Coefficient reachion armature at axis d,
kq=0.7; % Coefficient reaction armature at axis q,
kf=1.11;% Coefficient flux magnet,
hpb=5.7e-3; %[M] high pole nakonechnikov:{0.05-0.08}*da, 
j=6*1.0e+6; % density of current, [A],
%  Parameters of magnet  UNDK35T5 
% ================================
br=0.8;     %% Br- REMANENCE  INDUTION [T}, 
hc=108.8e3; %% Hc- COERCHITIVNAIA FORSE [A/M],
gamma=0.42; %% GAMMA- COEFFICIENT FORM CURVE  B(H),[p.u] 
tgalf0=0.2; % Summer admittance outer circuit,
%echo off,
a=(2*sqrt(gamma)-1)/gamma; % ostatochnii coefficient
tgbet=1-a; % magnet relative recoil permeability
format short e;
%         Main Program
%  ==========================
% Calculation optimal admittance KZ (Gk)
tgalfk1=0.1:0.01:1.2;
m1=1+tgalfk1;
n1=(tgbet+tgalfk1).*(1-tgalf0.*tgalfk1)./(1+tgalf0.*tgbet);
s=((m1-sqrt(m1.^2-4.*a.*tgalfk1))./(2.*a.*tgalfk1)).^2.*n1;
ku=(sqrt(1-(u*cos_fi)^2)-u*sqrt(1-cos_fi^2))*u;
% Calculation (tgalfk)opt for (Eo*Ik)max 
[ss,js]=max(s);
tgalfakm=tgalfk1(js);
disp('     Results of calculation of Sinchr_Gen with PM');
disp('   =============================================='),  
figure(1),
hp3=plot(tgalfk1,s,'k');hold on;
set(hp3,'LineWidth',2);
plot(tgalfakm,ss,'or');grid,
ht3=title(' (Eo*Ik) = f[tg(alfak)]');
set(ht3,'FontSize',12,'FontName','Arial','FontWeight','bold');
htx=text(0.65,0.47,'Maximum (Eo*Ik)');
set(htx,'FontSize',10,'FontWeight','bold');
hx3=xlabel(' tg(alfak), [p.u]');
set(hx3,'FontSize',10,'FontWeight','bold');
hy3=ylabel('(Eo*Ik), [p.u]'); 
set(hy3,'FontSize',10,'FontWeight','bold');
hold off;
%======================================
tgalfk=0.1; 
s0=0; e1=10;
   while e1 >= 0
m4=1+tgalfk;
n4=(tgbet+tgalfk)*(1-tgalf0*tgalfk)/(1+tgalf0*tgbet);
s1=((m4-sqrt(m4^2-4*a*tgalfk))/(2*a*tgalfk))^2*n4;
e1=s1-s0;
s0=s1;
tgalfk=tgalfk+0.01;
  if tgalfk > 5, break, end % Prerivanie chikla, if tg(alfk) >5,
  end
s=s0;
clear s1 s0 m4 n4,
v=2*sn*kd*kf/(pi^2*ku*(br*hc)*s*f1);%Volume of magnet predvaritelno,
% Print calculation
%===================================
disp(' (tgalfak)opt   (Eo*Ik)max [o.e] Vmag [M^3] ');
disp([tgalfk s v]);
%  Calculation constructive razmerov rotora
% ===========================================
a0=sin(pi/2/p*kcim);
a1=tan(pi/2/p);
a2=sin(pi/2/p);
dzet=(1-a0/a1)*a0;
dm1=log(v/(lamdd*p*dzet));
dm=exp(dm1/3);% diameter magnet,
da=dm+2*hpb;  % diameter rotora,
dk=dm*a0/a2;  % diameter kolesa,
bm=dk*a1; % width of magnet ,
hm=1/2*(dm-dk*cos(pi/2/p));% high of magnets,
disp('    Results calculation of inductors with Permanent Magnet' ),
disp('     dm          da           dk           bm          hm');
disp([dm da dk bm hm]);
%db=dm*(1/a0-2)*a0;
db=0.02*da;   % diameter vala 
tau=pi*da/2/p; % pole delenie
lm=dm*lamdd; % length of magnets
la=lm*1.15;  % lenght of rotora
sm=bm*lm; % area poperechnogo sechenia of magnets
v=sm*hm*2*p;% volume of magnet
clear a0 a1 a2 dzet dm1,
%  Print of results of calculation
disp('      dval          tau        lm          sm=bm*lm    vmag=sm*lm');
disp([db tau lm sm v]);
%====================================
%  Calculation  of stator winding     
%====================================
q=1.5;%###########
z1=2*m*p*q;
yp=fix(z1/2/p);
y=yp/m/q;
ky=sin(pi/2*y);% coefficient ukorochenia
kq1=sin(pi/2/m)/(q*sin(pi/2/m/q));% coefficient raspregelenia
kp=ky*kq1; % winding coefficient
Fa0=0.7*br*sm;% Flux Fao
w=(un/(u*4*kf*f1*Fa0*kp));% number turns of phase predvaritelno  
np=round(2*m*w/z1);% number provodnikov in slots
w=np*z1/(2*m);% number turn of phase okruglenno  
qp=in/j; % sechenie  provodnika
as=z1*np*in/(pi*da); % Line load A, 
bdel=Fa0/tau/la;% Induction Bdelta,
mu0=4*pi*1.0e-7;
del=tgalf0*hm*hc*la*tau*ai/(br*sm)*mu0; % air gap , 
del=0.3e-3;%#######(0.5-0.95)e-3
% Print results
%=====================
disp('     Results calculation of stator winding'),
disp('      z1          kp          w           np           qp,(Ì^2)');
z1=ceil(z1);
disp([z1 kp w np qp]);
disp('     Air gap, Flux, Line Load A, Induction Bdelta'),
disp('      del          Fao(Vb)     As(À/Ì)     Âdel(Tl)'),
disp([del Fa0 as bdel]);
clear  kq as ,
%====================================
%     Calculation of stator slots  
%====================================
tz1=pi*da/z1;
kc=0.95;% coefficient zaplonenia paketa stali,
% kzm=0.3-0.4, slot fill factor
kzm=0.3;% coefficient zapolnenia paza izolirovanim provodom 
bbz=1.4; % induction in tooth Âz=1.4 [Tl],
bz1=bdel/bbz*tz1/kc;% width slot,
sp=1.15*np*qp/kzm; % area of slot,
bch=4.0e-3; % width shliza,
hch=1.0e-3;% high shliza,
% litle width slot - b1,
b1=(pi*(da+2*del+2*hch-bch)-z1*bz1)/(z1-pi);
% ladge width slot - b2,
b2=sqrt((4*pi*sp+z1*b1^2)/z1);
h1=(b2-b1)/(2*pi)*z1; % high slot,
% Calculation admittance rassenia of stator winding 
lmk=(3*y+1)/4*(del/(bch+0.8*del));
lmp=(3*y+1)/4*(2*h1/(3*(b1+b2))+hch/bch);
tauy=pi*(da+2*del+h1+hch)*y/2/p;
ll=1.5*tau+0.02;% lehgth  of lobovoy part winding,
%x3=0.3*(ll-0.64*y*tau)*q/la;% calculation "Proektirovanie..." Kopilov I.P.
lmlob=(0.42-0.27*y*tau/ll)*q*ky;
%lmlob=q/(2*p*lamdd);
lsum=lmk+lmp+lmlob*ll/la;% summer admittance rassenia winding,
clear sp 
%===========================
%  Calculation baze units
%===========================
km=4*sin(ai*pi/2)/pi;% coefficient form pole magneta,
kfm=ai*pi*pi/(8*sin(ai*pi/2)); % coefficient flux magneta,
kad=(ai*pi+sin(ai*pi))/pi;% coefficient reaction pole armature at axis d,
kfd=pi*sin(ai*pi/2)/(ai*pi+sin(ai*pi)); % coefficient prodolnogo flux armature ,
kd=kad/km;
kaq=(pi*ai-sin(pi*ai))/pi;% coefficient reaction pole armature  at axis q,
kfq=pi*(1-cos(ai*pi/2))/(ai*pi-sin(ai*pi));%coefficient poperechogo flux iarmature ,
kq1=kaq/km;
%ai=0.485+0.4*ap;
ebz=pi*sqrt(2)*(kp*w)*f1*br*sm/km; % base voltage U
ibz=pi*p*hc*hm/(m*sqrt(2)*kd*kp*w);% base  current I
zb=ebz/ibz; % base Z
lbz=br*sm/(hc*hm); % base admittance,
%====================================
% Calculation  parameters of magnet
%====================================
% Indutive inpedance Xs, [om],
xs=4*pi*mu0*f1*w^2*la*lsum/(p*q);
lso=xs/zb;% Inductanse  Xs stator, [o.e],
lsm=tgalfk-lso/(1+lso*tgalf0);% admittance rasseinia of magneta,[o.e],
lsma=lsm*lbz;% provodimost  rasseinia  of magnet,[H]
hdl=1.5*mu0*hpb*la/lsma;% air gap  between magnet poles , [M],
kkd=1+bch/(tz1-bch+5*del*tz1/bch);% coefficient Cartera,
del=1.2*kkd*del;
%hdl=15*del;
tgdel=(mu0*la*tau*ai/del)/lbz;% admittance of air gap, [o.e],
tc=1/tgdel;
tgalf0=tc/(1+tc*lsm);% admittance of xolostogo xoga,[o.e],
bb=(1+tgalf0*tgbet)*(1+tc*lsm);
tgxi=(tgbet+tgalfk)*(1+lso*tc)/bb;
m2=1+tgalfk;
n2=(tgbet+tgalfk)/(1+tgalf0*tgbet)/(1+tc*lsm);
e0=((m2-sqrt(m2^2-4*a*tgalfk))/(2*a*tgalfk))*n2;%  EDS XX [o.e],
E0=un/u;% EDS XX [V]
w=round(E0*kf/(4.44*f1*kp*br*sm*e0)); % utochnennoe number of turns,
ik=((m2-sqrt(m2^2-4*a*tgalfk))/(2*a*tgalfk)/1+lso*tc);% current ÊÇ,[î.å]
%  Utochnenie base units and impedance,
%==========================================
ebz=pi*sqrt(2)*(kp*w)*f1*br*sm;     % /kfm;
ibz=pi*p*hc*hm/(m*sqrt(2)*kp*w*kd); % kd
zb=ebz/ibz;
xd=zb*tgxi;  % sinchron inductive impedance at axis d,
xq=zb*kq1/tc;% sinchron inductive impedance at axis q,
Ik=ik*ibz;
ki=Ik/in;
disp('   Result calculation base units and coefficient form of pole '),
disp('      Ebaz          Ibaz         Zbaz     Lambdabaz       Km ');
disp([ebz ibz zb lbz km]);
disp('      Kfm           Kad          Kfd         Kaq          Kfq ');
disp([kfm kad kfd kaq kfq]);
disp('    Coefficients  Kd, Kq, air gap between pole - hdl [M]'),
disp('      Kd             Kq           hdl'),
disp([kd kq1 hdl]);
disp('   EDC XX [o.e,V], TOK KZ[o.e,A]  , kratnost toka KZ [o.e]'),
disp('      e0         E0          ik           Ik           ki ');
disp([e0 E0 ik Ik ki]);
rs=2/41*1.0e-6*(la+ll)*w/qp;
disp('   Impedance sinchr_gen. and utochnenie Number Turns'),
disp('      Xd          Xq          Xs           Rs            Wa');
disp([xd xq xs rs w]);
%========================================
% Calculation outer characteristic U=f(I)
%========================================
rn=200:-10:0;
c0=sqrt(1-cos_fi)/cos_fi;
xn=rn.*c0;
is=E0.*sqrt((xq+xn).^2+(rs+rn).^2)./((xq+xn).*(xd+xn)+(rs+rn).^2);
u1=is.*sqrt(xn.^2+rn.^2);
u1=[E0 u1]; is=[0 is];
%u1=E0:-10:-5;
%is=(sqrt(E0.^2-(u1.*cos_fi).^2)-u1.*sqrt(1-cos_fi.^2))./(xd+xq).*2;
%=====================
ps=m.*u1.*is.*cos_fi;
for i=1:length(is)
 e2=ps(i+1)-ps(i);
   if e2 <=0
   cm=i; break,
   end 
end
sdel=2*mu0*tau*la/(pi*del)/lbz;
sdd=kad*kfd*sdel;
sdq=kaq*kfq*sdel;
sdm=km*kfm*sdel;
sd=sdd*(lsm+tgbet)/(sdd+lsm+tgbet)+lso;
sq=sdq+lso;
%===========================
tgalfk=lsm+lso/(1+lso/sdd);
tgalf0=1/(sdm+lsm);
tc=1/sdm;
m2=1+tgalfk;
n2=(tgbet+tgalfk)/(1+tgalf0*tgbet)/(1+tc*lsm);
e0=((m2-sqrt(m2^2-4*a*tgalfk))/(2*a*tgalfk))*n2; %  ÝÄÑ ÕÕ
%ss=sprintf('  Eo = %g [o.e]', e0);
%disp(ss);
%#######    Attention utochnenie Xd Xq 
%=======================================
kxd=6*f1*(w*kp)^2/(p*kfd)*sd*lbz;
kxq=6*f1*(w*kp)^2/(p*kfq)*sq*lbz;
%xdd=sd*zb;
%xqq=sq*zb;
zn=un/in;
xd=xd/zn;
xq=xq/zn;
rs=rs/zn; 
xs=xs/zn;
disp('     Impedace in standart relative units [p.u]');
disp('      Xd*          Xq*          Rs*           Xs*');
disp([xd xq rs xs]);
%disp(' Calculation Xd  Xq [Om] '),
%disp([kxd kxq]),
%====================
figure(2),
subplot(1,2,1),
hp2=plot(is,u1,'r'); grid;
set(hp2,'LineWidth',2);
ht2=title(' U=f(I) for cos(fi)=const');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx2=xlabel('Current generator I, [A] ');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=ylabel('Voltage generator U, [V]'); 
set(hy2,'FontSize',10,'FontWeight','bold');
%===========================================
subplot(1,2,2),
hp1=plot(is(1:cm),ps(1:cm),'b'); hold on,
set(hp1,'LineWidth',2);
plot(in,sn,'or');grid,
htt=text(in*1.5,sn*1.1,'Snom');
set(htt,'FontSize',10,'FontWeight','bold');
ht1=title(' S = f(I)');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx1=xlabel('Current generator I, [A]'); 
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=ylabel(' S, [BA]');
set(hy1,'FontSize',10,'FontWeight','bold');
hold off,
%legend('Kpd','Cos(fi)');
disp('    ******* END PROGRAM **********');
clear is ps i,
X=[tgalfk tgalf0 tgbet tgdel lso lsm e0 ik a];
save dan1.mat X,
%THE END