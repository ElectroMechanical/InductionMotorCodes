% Nominal date 
%================================
clc;
PH=2.2e3;% nominal power[Wt]
UH=380;% nominal voltage[V]
f=50;% nominal frequency (Hz]
n=2820;% nominal speed [rout/min]
eff=0.82;% nominal  effictiv
cosfi=0.87; % nominal cos(fi)
ik=6.5;% ik=Ik/Inom
mk=2.9; % mk= Mk/Mnom
mmax=3.4;% mmax= Mmax/Mnom
J=1.5e-4;% moment of inerchii [Kg*m^2]
p=1;% number par of poles
m=3;% number of phaze
% Callculation parametrov AD
%======================
IH=PH/(UH*sqrt(3)*cosfi*eff);% nominal current [A]
Uf=UH/1.73;
n1=60*f/p;
sn=(n1-n)/n1;
sk=(mmax+sqrt(mmax^2-1))*sn;
w1=2*pi*f;
w=pi*n/30;
MH=PH/w;
Mmaxx=mmax*MH;
Mkz=mk*MH;% Torque KZ
IK=ik*IH; % Current  of KZ
%=====================
ck=1:0.01:1.08;
Nk=length(ck);
c1k=zeros(1,Nk);
ck=zeros(1,Nk);
mk0=1:1:Nk;
mkk=1;
%============================
for c=1:0.01:1.08;
Rr=(1.06*PH)/(3*IH^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-eff))/IH)-(Rr*c.^2)-(0.06*PH/(3*IH^2));
Ll=Uf/(2*w1*(1+c^2)*ik*IH);
Ls=Uf/(w1*IH*sqrt(1-cosfi^2)-(2*w1*mmax*MH*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
c1k(mkk)=c1;
ck(mkk)=c;
mkk=mkk+1;
end
%========================================
dk=abs(c1k-ck);
[dk,ki]=min(dk);
Nkm=mk0(ki);
Cm=ck(Nkm);
a1=(c1k(Nk)-c1k(1))/(Nk-1);
a2=(1.08-1)/(Nk-1);
x=(c1k(1)-1+a2-a1)/(a2-a1);
cx=a1*x+c1k(Nk);
%========================================
Pfe=0.1*PH;% Pfe=(0.15-0.36)*Pnom
Pmech=0.01*PH;% Pmech=(0.04-0.1)*Pnom
Pdob=0.005*PH;% Pdob=(0.01-0.05)*Pnom
Pcons=Pfe+Pmech+Pdob;
dPn=PH*(1-eff)/eff;
Pvar=dPn-Pcons;
Mo=(Pmech+Pfe)/w;
Mem=MH+Mo;
Pvar2=Mem*w*sn;
Io=IH*sqrt(1-cosfi^2);
I2=sqrt(IH^2-Io^2);
R2=Pvar2/(m*I2^3);
R1=(Pvar-Pvar2)/(m*IH^2);
Zh=m*Uf^2/(2*w*Mmaxx)-R1;
Xsh=sqrt(Zh-R1^2);
Xs1=0.46*Xsh;
Xr2=Xsh*0.54;
Rmu=Pfe/(m*Io^2);
sin0=sqrt(1-((Rmu+R1)*Io/Uf)^2);
Xmu=Uf/Io*sin0-Xs1;
%=================KZ===========================
Zk=Uf/IK;  Rrk=Mkz*w/(m*IK^2);
Rk=Rs*cx+Rrk; Xrkk=(sqrt(Zk^2-(Rk*cx)^2))/cx^2;
Xrk=Xrkk/2;
%===============================================
c=cx;% Tochnoe - C
T='Tochnoe C =';
disp(['        ','Results callculation : ',T,num2str(cx)]);
Rr=(1.06*PH)/(3*IH^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-eff))/IH)-(Rr*c.^2)-(0.06*PH/(3*IH^2));
Ll=Uf/(2*w1*(1+c^2)*ik*IH);
Ls=Uf/(w1*IH*sqrt(1-cosfi^2)-(2*w1*mmax*MH*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
Lr=Ll;
Xrk=w1*Lr*0.7;
%===================================
Xs=Ll*w1;  Xm=Lm*w1;
disp(['    ','     ','PARAMETRS OF  T-oi CIRCUIT AD for C=',num2str(cx)]);
disp('        =============================================');
disp(['      ','Rs','       ','Rr','        ','Xs','       ','Xm','        ','Xr']);
disp([Rs Rr Xs1 Xm Xr2]);
disp('New calculaution');
disp([R1 R2 Xs1 Xmu Xr]);
disp(['      ','Rmu','      ','Rrk','        ','Xs','       ','Xmu','        ','Xrk']);
disp([Rmu Rrk Xs Xmu Xrk]); 
%============================
% Callculation curve M,Is =f(s)
% End of program