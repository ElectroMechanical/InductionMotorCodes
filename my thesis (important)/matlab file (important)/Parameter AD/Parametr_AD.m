% Nominal date 
%================================
%clc;
%clf;
PH=2.2e3;% nominal power[Wt]
UH=380;% nominal voltage[V]
f=50;% nominal frequency (Hz]
n=2820;% nominal routine [1/c]
eff=0.82;% nominal  kpd
cosfi=0.87; % nominal cos(fi)
IH=PH/(UH*sqrt(3)*cosfi*eff);% nomihal current [A]
ik=6.5;% ik=Ik/Inom
mk=2.9; %mk= Mk/Mnom
mmax=3.4;%mmax= Mmax/Mnom
J=1.5e-4;
p=1;% number par of poles
m=3;% number of fazes
% Callculation parametrov of AD
%======================
Uf=UH/1.73;
n1=60*f/p;
sn=(n1-n)/n1;
sk=(mmax+sqrt(mmax^2-1))*sn;
w1=2*pi*f;
w=pi*n/30;
MH=PH/w;
Mk=mk*MH;% Torque KZ
IK=ik*IH; % Current  of KZ
%=====================
ck=1:0.01:1.08;
Nk=length(ck);
c1k=zeros(1,Nk);
ck=zeros(1,Nk);
mk0=1:1:Nk;
mkk=1;
for c=1:0.01:1.08;
Rr=(1.06*PH)/(3*IH^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-eff))/IH)-(Rr*c.^2)-(0.06*PH/(3*IH^2));
Ll=Uf/(2*w1*(1+c^2)*ik*IH);
Ls=Uf/(w1*IH*sqrt(1-cosfi^2)-(2*w1*mmax*MH*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
%A=[Rs Rr Ll Lm c c1];
c1k(mkk)=c1;
ck(mkk)=c;
mkk=mkk+1;
end
dk=abs(c1k-ck);
[dk,ki]=min(dk);
Nkm=mk0(ki);
Cm=ck(Nkm);
%disp(['   Primernoe c  ',' Ni']);
%disp([Cm, Nkm]);
a1=(c1k(Nk)-c1k(1))/(Nk-1);
a2=(1.08-1)/(Nk-1);
x=(c1k(1)-1+a2-a1)/(a2-a1);
cx=a1*x+c1k(Nk);
%=============================================
figure(1)
H=plot(mk0,c1k,'-k',mk0,ck,'-r');grid
set(H,'LineWidth',2);
legend('c1','c',2);
xlabel('Number Ni ','FontSize', 12,'FontWeight','bold');
ylabel(' c, c1, [o.e]','FontSize', 12,'FontWeight','bold'); 
title(' C,  C1=f(Ni) ','FontSize', 12,'FontAngle','italic','FontWeight','bold')
%========================================
%c=Cm;% primernoe C
c=cx;% Tochnoe - C
T='Tochnoe C =';
disp(['        ','Results callculation : ',T,num2str(cx)]);
Rr=(1.06*PH)/(3*IH^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-eff))/IH)-(Rr*c.^2)-(0.06*PH/(3*IH^2));
Ll=Uf/(2*w1*(1+c^2)*ik*IH);
Ls=Uf/(w1*IH*sqrt(1-cosfi^2)-(2*w1*mmax*MH*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
%===================================
X1=Ll*w1;
Xm=Lm*w1;
Xr=1.2*X1; Lr=Xr/w1;
disp(['    ','     ','PARAMETRS OF  T-oi CIRCUIT AD for C=',num2str(cx)]);
disp('        =============================================');
disp(['      ','Rs','       ','Rr','        ','L1s','       ','Lm','        ','L2r']);
disp([Rs Rr Ll Lm Lr]);
disp(['      ','Rs','       ','Rr','        ','Xs','       ','Xm','        ','Xr']);
disp([Rs Rr X1 Xm Xr]);
%============================
% Paschet characterictik M,Is =f(s)
s1=0:0.005:1;
nn=length(s1);
Isa=zeros(1,nn);
Ms=zeros(1,nn);
Pra=zeros(1,nn);% P2
Kpd=zeros(1,nn);% kpd
Cos=zeros(1,nn);% cos(fi)
Zs=Rs+j*X1;
%======================================
n=1;
for s=0:0.005:1; 
%====================================
%Rr=Rr+(Rrk-Rr)*sqrt(s);
dela=Rr^2+s^2*(Xm+Xr)^2;
Rra=s*Xm^2*Rr/dela;
Xra=(Xm*Rr^2+s^2*Xm*Xr*(Xm+Xr))/dela;
Zsa=Zs+Rra+j*Xra;
%=====================================
Ia=Uf/Zsa;
Pem=m*abs(Ia)^2*Rra;
Mem=Pem/w;
Is=abs(Ia);
Isx=real(Ia);
Isy=imag(Ia);
cos=Isx/Is;
Pr=(m*abs(Ia)^2*Rra)*(1-s)*0.95;
Ps=m*Uf*Is*cos;
kpd=Pr/Ps;
%=========================
Pra(n)=Pr;
Isa(n)=Is;
Ms(n)=Mem;
Cos(n)=cos;
Kpd(n)=kpd;
sz(n)=s;
n=n+1;
end
%=======================================
[Mmax,ki]=max(Ms);
sk=s1(ki);
disp(['    ','Mmax [N*M]',' ',' smax']);
disp([Mmax, sk]);
k1=ki-50;
%======================================
figure(2),
subplot(1,2,1);
H1=plot(s1,Ms,'k',s1,Isa,'r'); grid
set(H1,'LineWidth',2);
legend('M','Is',4);
xlabel('slip, [o.e]','FontSize', 12,'FontWeight','bold');
ylabel(' M [N*M], Is[A]','FontSize', 12,'FontWeight','bold'); 
title(' M, Is=f(s) ','FontSize', 12,'FontAngle','italic','FontWeight','bold');
%====================================================
subplot(1,2,2);
H3=plot(Pra(1:k1),Kpd(1:k1),'r',Pra(1:k1),Cos(1:k1),'-k'); grid
set(H3,'LineWidth',2);
legend('KPD','COS(fi)',4);
xlabel('Pr, [Wt]','FontSize', 12,'FontWeight','bold');
ylabel(' Kpd, Cos(fi) [o.e]','FontSize', 12,'FontWeight','bold'); 
title(' Kpd, Cos(fi)=f(Pr) ','FontSize', 12,'FontAngle','italic','FontWeight','bold');
%============================================
Mi=abs(Ms-MH);
[Mx,Nn]=min(Mi);
sn=s1(Nn);
Mn=Ms(Nn);
disp(['   ','Mnom [N*M]',' ',' snom']);
disp([Mn, sn]);
Kpdn=Kpd(Nn); Cosn=Cos(Nn); Isn=Isa(Nn);
disp(['     ','Kpdn','    ','Cosn(fi)','   ','Isn [A]']);
disp('nominal date');
disp([eff,cosfi,IH]);
disp('callculating date');
disp([Kpdn,Cosn,Isn]);
%===========================
Km=Mmax/Mn;
Mk=Ms(nn); Ik=Isa(nn);
Kp=Mk/Mn; Ki=Ik/Isn;
disp(['     ','Km','        ','Kp','        ','Ki']);
disp('nominal date');
disp([mmax,mk,ik]);
disp('calculating date');
disp([Km,Kp,Ki]);
% End of program