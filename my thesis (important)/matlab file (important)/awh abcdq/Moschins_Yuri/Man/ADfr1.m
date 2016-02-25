%================================
clc;% Type- 4A160S4Y3
PH=15e3;% nominal power[Wt]
Uf=220; % nominal phaze voltage[V]
fn=50;% nominal frequency (Hz]
p=2;% number par of poles
m=3;% number of phaze
cosfi=0.894;
eff=0.892;
% Parametri[om] AD iz book "Proektirovanie" KOPILOV 
R1=0.355; X1=0.673;
R2=0.186; X2=0.918;
Xm=27.14; Rm=1.47;
L1=X1/(2*pi*fn); L2=X2/(2*pi*fn); Lm=Xm/(2*pi*fn);
%======================
IH=PH/(Uf*cosfi*eff);% nominal current [A]
c=(1+(j*X1+R1)/(j*Xm+Rm)); c1=abs(c);
%=========================================
sn=0.024;
nc=60*fn/p;
wcn=pi*nc/30;
wn=(1-sn)*wcn;
MH=PH/wn;
Mc=0.4*MH;
%===========================
dd=30:10:130;
N=length(dd);
P1a=zeros(1,N);
Is=zeros(1,N);
Isf=zeros(1,N);
P2=zeros(1,N);
Kpd=zeros(1,N);
Kos=zeros(1,N);
s1=zeros(1,N);
Uff=zeros(1,N);
%==============================
f=30:10:130;
Uff=Uf./fn.*f;
omeg=2.*pi.*f;
wc=omeg./p;
X11=L1.*omeg; X22=L2.*omeg; Xmu=Lm.*omeg;
Z1=R1+j*X11;
k=(m.*Uff.^2)./(2.*wc.*Mc*c1)-R1;
a=k.^2-R1^2-(X11+c1.*X22).^2;
s1=c1*R2./(k+sqrt(a));
Xk=X11+c1.*X22;
skr=c1*R2./sqrt(R1^2+c1.*Xk.^2);
AA=2.*wc.*c1.*(R1+sqrt(R1^2+Xk.^2));
Mmax=m.*Uff.^2./(MH.*AA);
%===============================================
figure(1);
subplot(1,2,1);
H=plot(f,s1,'-k',f,skr,'-r');grid
set(H,'LineWidth',2);
legend('s1','skr',1);
xlabel('frequency [Hz] ','FontSize', 12,'FontWeight','bold');
ylabel('s1,skr,[o.e]','FontSize', 12,'FontWeight','bold'); 
title('s1,skr=F(f)','FontSize',12,'FontAngle','italic','FontWeight','bold');
%===================
subplot(1,2,2);
H=plot(f,Mmax,'-k');grid
set(H,'LineWidth',2);
%legend('s1','skr','Mmax',1);
xlabel('frequency [Hz] ','FontSize', 12,'FontWeight','bold');
ylabel('Mmax,[o.e]','FontSize', 12,'FontWeight','bold'); 
title('Mmax=F(f)','FontSize',12,'FontAngle','italic','FontWeight','bold');
% End of program