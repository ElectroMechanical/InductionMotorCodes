%================================
clc;
clf;% Type- 4A160S4Y3
PH=15e3;% nominal power[Wt]
Ufn=220; % nominal phaze voltage[V]
fn=50;% nominal frequency (Hz]
p=2;% number par of poles
m=3;% number of phaze
cosfi=0.892;
eff=0.892;
% Parametrs[om] AD iz book "Proektirovanie" KOPILOV 
R1=0.355; X1=0.673;
R2=0.186; X2=0.918;
%R2k=0.246; Xk=0.866;
Xm=27.14; Rm=1.47;
L1=X1/(2*pi*fn); L2=X2/(2*pi*fn); Lm=Xm/(2*pi*fn);
%======================
IH=PH/(m*Ufn*cosfi*eff);% nominal current [A]
c=(1+(j*X1+R1)/(j*Xm+Rm)); c1=abs(c);
%=========================================
sn=0.024;
nc=60*fn/p;
wcn=pi*nc/30;
wn=(1-sn)*wcn;
MH=PH/wn;
%===========================
dd=30:10:100;
N=length(dd);
P1a=zeros(1,N);
Is=zeros(1,N);
Isf=zeros(1,N);
P2=zeros(1,N);
Kpd=zeros(1,N);
Kos=zeros(1,N);
s1=zeros(1,N);
Uff=zeros(1,N);
kos1=zeros(1,N);
Mc=zeros(1,N);
Mci=zeros(1,N);
%================
f=30:10:100;
%====================================
%Uff=Ufn.*f/fn;% Zakon M=const
Uff=Ufn.*sqrt(f./fn);% Zakon P=const
%Uff=Ufn.*(f./fn).^2;% Zakon U/f^2=const
%=======================================
omeg=2.*pi.*f;
wc=omeg./p;
X11=L1.*omeg; X22=L2.*omeg; Xmu=Lm.*omeg;
Z1=complex(R1,X11);
c1=sqrt(((R1+Rm).^2+(X11+Xmu).^2)./(Xmu.^2+Rm.^2));
%======================================
%Zakon P2=const
%skr=c1/R22/(sqrt(R1^2+(x11+c1*X22)^2);
Mmax=m.*Uff.^2./(2.*wc.*(R1+sqrt(R2.^2+(X11+c1.*X22).^2)));
kp=(f./30).^0.2;
Mc=0.5*Mmax./kp;
Pf=wc.*Mc;
%zakon Mc=k^2*wc;
%Mc=Mc(1).*f/f(1).^2;
%===================================
%Mc=MH; % Zakon U/f=const
Mci=Mc./MH;
k=(m.*Uff.^2)./(2.*wc.*Mc.*c1)-R1;
a=k.^2-R1^2-(X11+c1.*X22).^2;
s1=c1*R2./(k+sqrt(a));
%==================================
R2r=R2./s1;
Z2a=complex(R2r,X22);
%==================================
% Callculation curve cos(fi),kpd,is =F(f)
Zek=j.*Xmu.*Z2a./(Z2a+j.*Xmu);
Z=Zek+Z1;
I1=Uff./Z;
U2=Zek.*I1;
I2=U2./Z2a;
Ir=abs(I2);
fi=angle(I1);
kos1=sqrt(1-sin(fi).^2);
Is=abs(I1);
Isa=real(I1);
kos=Isa./Is;
P1=m.*Uff.*Is.*kos;
P2=P1-(m.*Ir.^2.*R2)-(m.*Is.^2.*R1);
MM=P2./wc;
%P2=Mc.*wc.*(1-s1);
Kpd=P2./P1;
Isf=Is./IH;
%===============================================
figure(1);
H=plot(f,kos,'-k',f,Kpd,'-r'); grid
set(H,'LineWidth',2);
legend('cos(fi)','kpd',4);
xlabel('frequency [Hz] ','FontSize', 12,'FontWeight','bold');
ylabel('cos(fi),kpd, Is,[o.e]','FontSize', 12,'FontWeight','bold'); 
title('Cos(fi),Kpd = F(f)','FontSize',12,'FontAngle','italic','FontWeight','bold');
%================================================
figure(2);
H2=plot(f,Isf,'-b');grid
set(H2,'LineWidth',2);
xlabel('frequency [Hz] ','FontSize', 12,'FontWeight','bold');
ylabel(' Is,[o.e]','FontSize', 12,'FontWeight','bold'); 
title('Is=F(f)','FontSize',12,'FontAngle','italic','FontWeight','bold');
%====================================================
figure(3)
H3=plot(f,Mci,'-b');grid
set(H3,'LineWidth',2);
xlabel('frequency [Hz] ','FontSize', 12,'FontWeight','bold');
ylabel(' Ms,[o.e]','FontSize', 12,'FontWeight','bold'); 
title('Mc/Mn=F(f)','FontSize',12,'FontAngle','italic','FontWeight','bold');
% END PROGRAM