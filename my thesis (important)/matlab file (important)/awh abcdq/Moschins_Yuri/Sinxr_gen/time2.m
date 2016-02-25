script; % SINCHRON GENERATOR WITH PM - KC37A- SmCo
clc;
clf;
% Radial construction
%        Calculation sinchron generator with Permanent Magnet;
%        =====================================================     
disp(' Student of group EL-11-03:  Kuznetsov A.S.');
%   Input data (Starting data):
%  =========================
disp(' Magnit Smco')
%  =========================
sn=5500; % Nominal power, [VA],
un=400;  % Nominal voltage ,[V],
m=3; %  Number of phaces,
in=sn/m/un;  % Nominal current ,[A],
cos_fi=0.9; % cos(fi) [p.u],
p=4; % Number of pairs pole,
f1=400; % Suply freguency ,[Hz],
%============================================
ai=0.9; % Coefficient pole perekritia [p.u],
u=0.85; % Coefficient snizenia voltage, u=Uíîì/E0 [p.u],
%    Constructive coefficients ,
%    ==========================================
kcim=0.6; % kcim=bm/tau,
lamdd=0.96/sqrt(p);% ratio lamda=lm/dm ,
kd=0.85; % Coefficient reachion armature at axis d,
kq=0.7; % Coefficient reaction armature at axis q,
kf=1.11;% Coefficient flux magnet,
ku=(sqrt(1-(u*cos_fi)^2)-u*sqrt(1-cos_fi^2))*u;
hpb=9.8e-3; % {0.05-0.08}*da,[M] -  High pole nakonechnikov
j=6*1.0e+6; % Density of current, [A],
%==================================
%  PERMANENT MAGNET: SmCo5 - KC37A 
% =================================
br=0.82;     % Br - Permanet magnet remanence [T}, 
hc=560e3; % Hc -coerchitivnaia forse [A/M],
gamma=0.25; % Gamma-coefficient form curve B(H), 
a=(2*sqrt(gamma)-1)/gamma; % Ostatochnii coefficient
tgbet=1-a; % Magnet relative recoil permeability
%         MAIN PROGRAM
%===========================
% Calculation optimal (E0*IK)
%===========================
format short e;
ap=0.7;% 0.6-0.7
kp=0.9;% 0.85-0.9
ddelt=0.2;% 0.1-0.2
ai=0.485+0.4*ap;
mur=1;
delo=5.56e-3; %[p. u] Air length (6-10)e-3  iz punkta No 143
lamdela=ai*(1-ap*kp-ddelt)/(2*delo*mur*ap*kp);
%==============================
%hpb*=hpb/da=0.08;
%xsig=[ap kp  mur ddelt p 0.08]; %Callculation Lsigm PM
%lamdsm=lsigm2(xsig);
%ksig=1+lamdsm/lamdela;
%==============================
ksig=1.2; lsum1=2; q=1.6;
ch=2*p*(1-ap*kp-ddelt)*lsum1;
ko=0.9;
zz=ap*mur*q*m*kd*ko^2*kp;
lamdsa=ch/zz;% 4.25 (0,05-0,15)*un/in/zb
lamdsm=(ksig-1)*lamdela;
lamdelo=lamdsm+lamdela;
adel=acot(lamdelo);
tgalf0=tan(adel);% <= 0.2 -Summer admittance outer circuit,
%==========================
lamdelb=0.1:0.1:20;
e01=lamdelb./(1+lamdsm+lamdelb);
ik1=1./[lamdsa+(1+lamdsm).*(1+lamdsm./lamdelb)];
s=e01.*ik1;
% Calculation (lamdel)opt for (Eo*Ik)max 
%===========================
lamdel=lamdela;
e0=lamdel/(1+lamdsm+lamdel);
ik=1/[lamdsa+(1+lamdsm)*(1+lamdsa/lamdel)];
smax=e0*ik;
lamd0=lamdsm+lamdel;
disp('     Results of calculation of Sinchr_Gen with PM');
disp('   =============================================='),  
figure(1),%###################
hp3=plot(lamdelb,s,'k');hold on;
set(hp3,'LineWidth',2);
Hpp=plot(lamdel,smax,'or');grid,
set(Hpp,'LineWidth',2);
ht3=title(' (Eo*Ik) = f(lamda_d_e_l)');
set(ht3,'FontSize',12,'FontName','Arial','FontWeight','bold');
htx=text(0.75*lamdel,smax,'Max (Eo*Ik)');
set(htx,'FontSize',10,'FontWeight','bold');
hx3=xlabel(' lamda_d_e_l, [p.u]');
set(hx3,'FontSize',10,'FontWeight','bold');
hy3=ylabel('(Eo*Ik), [p.u]'); 
set(hy3,'FontSize',10,'FontWeight','bold');
hold off;
%======================================
clear lamdelb e01 ik1 1 zz ch lsum1 
v=2*sn*kd*kf/(pi^2*ku*(br*hc)*smax*f1);%Volume of magnet predvaritelno,
% Print calculation
%===================================
disp(' (lamdel)opt   (Eo*Ik)max[p.u]  Vmag [M^3] ');
disp([lamdel smax v]);
%============================================
%  Calculation constructive razmerov rotora
% ===========================================
a0=sin(pi/2/p*kcim);
a1=tan(pi/2/p);
a2=sin(pi/2/p);
dzet=(1-a0/a1)*a0;
dm1=log(v/(lamdd*p*dzet));
dm=exp(dm1/3);% Diameter magnet,
da=dm+2*hpb;  % Diameter rotora,
dk=dm*a0/a2;  % Diameter kolesa,
bm=dk*a1; % Width of magnet ,
hm=1/2*(dm-dk*cos(pi/2/p));% High of magnets,
%### 2 variant #########
%kk=(1-ap*kp-ddelt);
%hm=kk*0.5*dm;
%bm=hm*ap*kp*pi/(p*kk);
%======================
disp('    Results calculation of inductors with Permanent Magnet' ),
disp('     dm          da           dk           bm          hm');
disp([dm da dk bm hm]);
%db=dm*(1/a0-2)*a0;
db=0.02*da;   % Diameter vala 
tau=pi*da/2/p; % Pole delenie
lm=dm*lamdd; % Length of magnets
la=lm*1.15;  % Lenght of rotora
sm=bm*lm; % Area poperechnogo sechenia of magnets
v=sm*hm*2*p;% Volume of magnet
clear a0 a1 a2 dzet dm1,
%  Print of results of calculation
disp('      dval          tau        lm          sm=bm*lm    vmag=sm*lm');
disp([db tau lm sm v]);
%====================================
%  Calculation  of stator winding     
%====================================
q=1.5; % q=1.25 1.75 2.25 2.75 for 2p=8
z1=2*m*p*q;
yp=fix(z1/2/p);
y=yp/m/q;
ky=sin(pi/2*y);% Coefficient ukorochenia
kq1=sin(pi/2/m)/(q*sin(pi/2/m/q));% Coefficient raspregelenia
ko=ky*kq1; % Winding coefficient
Fa0=0.7*br*sm;% Flux Fao for XX
w=(un/(u*4*kf*f1*Fa0*ko));% Number turns of phase predvaritelno  
np=round(2*m*w/z1);% Number provodnikov in slots
w=np*z1/(2*m);% Number turn of phase okruglenno  
qp=in/j; % Sechenie  provodnika
as=z1*np*in/(pi*da); % Line load A, 
bdel=Fa0/tau/la;% Induction Bdelta,
mu0=4*pi*1.0e-7;
del=1e-4+0.005*da;%[M] Length air gap (0.5-0.95)e-3
%del1=tgalf0*hm*hc*la*tau*ai/(br*sm)*mu0; 2-variant
%======================
% Print results
%=====================
disp('     Results calculation of stator winding'),
disp('      z1          ko          w           np           qp,(Ì^2)');
z1=ceil(z1);
disp([z1 ko w np qp]);
disp('     Air gap, Flux, Line Load A, Induction Bdelta'),
disp('      del          Fao(Vb)     As(À/Ì)     Âdel(Tl)'),
disp([del Fa0 as bdel]);
clear  kq as ,
%====================================
%     Calculation of Stator Slots  
%====================================
tz1=pi*da/z1;
kc=0.95;% Coefficient zaplonenia paketa stali,
%kzm=0.3-0.4, Slot fill factor
kzm=0.3;% Coefficient zapolnenia paza izolirovanim provodom 
bbz=1.4; % Induction in tooth Âz=1.4 [Tl],
bz1=bdel/bbz*tz1/kc;% Width slot,
sp=1.15*np*qp/kzm; % Area of slot,
bch=4.0e-3; % Width shliza,
hch=1.0e-3;% High shliza,
% Litle width slot - b1,
b1=(pi*(da+2*del+2*hch-bch)-z1*bz1)/(z1-pi);
% Ladge width slot - b2,
b2=sqrt((4*pi*sp+z1*b1^2)/z1);
h1=(b2-b1)/(2*pi)*z1; % high slot,
% Calculation admittance rassenia of stator winding 
lmk=(3*y+1)/4*(del/(bch+0.8*del));
lmp=(3*y+1)/4*(2*h1/(3*(b1+b2))+hch/bch);
tauy=pi*(da+2*del+h1+hch)*y/2/p;
ll=1.5*tau+0.02;% Length  of lobovoy part winding,
%x3=0.3*(ll-0.64*y*tau)*q/la;% Calculation "Proektirovanie..." Kopilov I.P.
lmlob=(0.42-0.27*y*tau/ll)*q*ky;
%lmlob=q/(2*p*lamdd);
lsum=lmk+lmp+lmlob*ll/la;% Summer admittance rassenia winding,
clear sp 
%===========================
%  Calculation baze units
%===========================
km=4*sin(ai*pi/2)/pi;% Coefficient form pole magneta,
kfm=ai*pi*pi/(8*sin(ai*pi/2)); % Coefficient flux magneta,
kad=(ai*pi+sin(ai*pi))/pi;% Coefficient reaction pole armature at axis d,
kfd=pi*sin(ai*pi/2)/(ai*pi+sin(ai*pi)); %Coefficient prodolnogo flux armature ,
kd=kad/km;
kaq=(pi*ai-sin(pi*ai))/pi;% Coefficient reaction pole armature  at axis q,
kfq=pi*(1-cos(ai*pi/2))/(ai*pi-sin(ai*pi));% Coefficient poperechogo flux iarmature ,
kq1=kaq/km;
ebz=pi*sqrt(2)*(ko*w)*f1*br*sm/km; % Base voltage U
ibz=pi*p*hc*hm/(m*sqrt(2)*kd*ko*w);% Base  current I
zb=ebz/ibz; % Base Z
lbz=br*sm/(hc*hm); % Base admittance,
%====================================
% Calculation  parameters of magnet
%====================================
xs=4*pi*mu0*f1*w^2*la*lsum/(p*q);% Indutive inpedance Xs, [om],
lso=xs/zb;% Inductanse  Ls stator, [o.e],
tgalfk=5.49;%##### UTOCHNENIE iz punkta No 254
lsm=tgalfk-lso/(1+lso*tgalf0);%Admittance rasseinia of magneta,[o.e],
lsma=lsm*lbz;% Provodimost  rasseinia  of magnet,[H]
hdl=1.5*mu0*hpb*la/lsma;%Air gap  between magnet poles,[M]~1-variant
%hdl=15*del;% Air gap  between magnet poles,[M]~ 2-variant
kkd=1+bch/(tz1-bch+5*del*tz1/bch);% Coefficient Cartera,
del=1.2*kkd*del;
tgdel=(mu0*la*tau*ai/del)/lbz;% Admittance of air gap, [o.e],
tc=1/tgdel;
tgalf0=tc/(1+tc*lsm);%[o.e] Admittance of xolostogo xoga, tgalf0=0.2;
%===================================================
E0=un/u;% EDS XX [V]
w=round(E0*kf/(4.44*f1*ko*br*sm*e0)); % Correct number of turns,
ik=1/[lso+(1+lsm)*(1+lso/tgdel)]; % Current ÊÇ,[î.å]
%  Callculation of Base Units and Impedances,
%==========================================
ebz=pi*sqrt(2)*(ko*w)*f1*br*sm;     % /kfm;
ibz=pi*p*hc*hm/(m*sqrt(2)*ko*w*kd); 
zb=ebz/ibz;
e0n=E0/ebz;%  EDS XX [o.e],
tgxi=e0n/ik;;
xd=zb*tgxi;  % Sinchron inductive impedance at axis d,
xq=zb*kq1/tc;% Sinchron inductive impedance at axis q,
Ik=ik*ibz;
ki=Ik/in;
disp('   Result calculation Base Units and Coefficient Form of pole '),
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
disp('   IMPEDANCES [OM] Sincron_gener. and CORRETION of Number Turns'),
disp('      Xd          Xq          Xs           Rs            Wa');
disp([xd xq xs rs w]);
lss=sprintf('  lsa = %g [o.e]', lso);
disp(lss);
%=========================
sdel=2*mu0*tau*la/(pi*del)/lbz;
sdd=kad*kfd*sdel;
sdq=kaq*kfq*sdel;
sdm=km*kfm*sdel;
sd=sdd*(lsm+tgbet)/(sdd+lsm+tgbet)+lso;
sq=sdq+lso;
%===========================
tgalfk=lsm+lso/(1+lso/sdd); % for punkt No 203
tgg=sprintf('  tgalfak = %g [o.e]', tgalfk);
disp(tgg);
tgalf0=1/(sdm+lsm);
%   Calculation Xd Xq in standart forms
%=======================================
%kxd=6*f1*(w*ko)^2/(p*kfd)*sd*lbz;
%kxq=6*f1*(w*ko)^2/(p*kfq)*sq*lbz;
%xdd=sd*zb;
%xqq=sq*zb;
%=======================================
zn=un/in;
xdo=xd/zn;
xqo=xq/zn;
rso=rs/zn; 
xso=xs/zn;
disp('     IMPEDANSE IN STANDART RELATIVE UNITS [o.e]');
disp('      Xd*          Xq*          Rs*           Xs*');
disp([xdo xqo rso xso]);
%================================================
% Calculation characteristic U=f(I),cos(fi)=const
%================================================
rn=200:-10:0;
c0=sqrt(1-cos_fi)/cos_fi;
xn=rn.*c0;
is=E0.*sqrt((xq+xn).^2+(rs+rn).^2)./((xq+xn).*(xd+xn)+(rs+rn).^2);
u1=is.*sqrt(xn.^2+rn.^2);
u1=[E0 u1]; is=[0 is];% Rasshirenie massiva u1 and i1
%==========================================
ps=m.*u1.*is.*cos_fi;
for i=1:length(is)
e2=ps(i+1)-ps(i);
   if e2 <=0
   cm=i; break,
   end 
end
figure(2),
subplot(1,2,1),hold on
hp2=plot(is,u1,'k');grid,
set(hp2,'LineWidth',2);
hpl=plot(in,un,'or');
set(hpl,'LineWidth',2);
htt=text(in*1.4,un*1.08,'Inom');
set(htt,'FontSize',10,'FontWeight','bold');
ht2=title(' U=f(I), cos(fi)=0.9');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx2=xlabel(' I, [A] ');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=ylabel(' U, [V]'); 
set(hy2,'FontSize',10,'FontWeight','bold');
hold off
%===========================================
subplot(1,2,2),
hp1=plot(is(1:cm),ps(1:cm),'b'); hold on,
set(hp1,'LineWidth',2);
hpx=plot(in,sn,'or');grid,
set(hpx,'LineWidth',2);
htt=text(in*1.5,sn,'Snom');
set(htt,'FontSize',10,'FontWeight','bold');
ht1=title(' S = f(I)');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx1=xlabel(' I, [A]'); 
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=ylabel(' S, [BA]');
set(hy1,'FontSize',10,'FontWeight','bold');
hold off,
%==============================================
clear is ps i,
X=[tgalfk tgalf0 tgbet tgdel lso lsm e0 ik a];
save dan2.mat X,
disp('    ******* END PROGRAM **********');
%THE END
