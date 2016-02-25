% Script file IdenAD.m 
% Opredelenie parametrs sxem zameschenia AD
% Raschet po ctatie  "Identification of parametrs AD",
% Becpalov V.I, Moschinskii Y.A.- write in
% jornal "Elektrichestvo" - N4, 1998 year. 
% Insrution: zapusk file IdenAD.m: Put Debug,zatem Run or F5   
clc;
clf;
%==============================
%    Input DATE of test AD  
%==============================
%      NOMINAL REZIM
%==============================
f1=50;% chastota ceti f1=50Hz
P2n=15e3; % nominal power [Wt] P2n=7.5e3 kWt
Un=380; % nominal faznoe voltage U=220 v 
m=3; p=2;; % chislo polusov and number of phase
kpdn=0.89; cosn=0.89; % nominal kpd=0.88 and cos(fi)=0.86
Km=3; Kp=1.7; % Km=Mmax/Mnom; Kp=Mkz/Mnom;
Ki=7; %  Ki=I1kz/I1nom=6.7 
nr=1476; % chastota rotora nr= 1461 [ob/min]
%========================================
%   REZIM  RELATIVE POWER - P2rp=rp*P2n; 
%         rp=0.25;   
%==============================================
rp=0.25; % Koeffisient  power rp=P2/P2n
% Attension! 
% P2nom dolzno ne previchat 90 kWt and number par poles p<= 4;
P2nom=P2n*1e-3; % Perevod Nominal Power in [kWt]
y=Kpd(P2nom,p);
kpdr=y(1,1); cosr=y(1,2);% kpd, cos(fi) pri rp=0.25
%===============================================
%   MAIN PROGRAM
n1=60*f1/p;% sinxron. chastota [ob/min]
sn=1-nr/n1; % nominal slip
I1n=P2n/(m*Un*kpdn*cosn);
I1rp=rp*P2n/(m*Un*kpdr*cosr);
Ach=I1rp^2-I1n^2*(rp*(1-sn)/(1-rp*sn))^2;
Azn=1-((rp*(1-sn)/1-rp*sn))^2;
I0=sqrt(Ach/Azn);
bet=1.5; aa=Km^2-(1-2*sn*bet*(Km-1));
ab=1-2*sn*bet*(Km-1);
sk=sn*(Km+sqrt(aa))/ab;
%====================================
fio=87*pi/180;
A0=(I1n*cosn-I0*cos(fio))/Un;
C1=I0/(2*Ki*I1n)+1;
A1=m*Un^2*(1-sn)/(2*C1*Km*P2n);
B=1/sn+1/sk-2*A0*A1/sn;
C=1/(sn*sk)-(1/sn^2+1/sk^2)*A0*A1;
bet=-B/2+sqrt((B/2)^2-C);
R2=A1/((bet+1/sk)*C1);
R1=C1*R2*bet;
Gm=sqrt(1/(sk^2)-bet^2);
Xn=Gm*C1*R2;
%% X1=0.42*Xn; X2=0.58*Xn;
X1=0.38*Xn; X2=0.62*Xn;
sinN=sqrt(1-cosn^2);
E1=sqrt((Un*cosn-R1*I1n)^2+(Un*sinN-X1*I1n)^2);
Xmu=E1/I0;
dPn=P2n*(1/kpdn-1)-0.005*P2n/kpdn;
dPrp=rp*P2n*(1/kpdr-1)-0.005*rp*P2n/kpdr;
Rv=(dPn-dPrp)/(m*(I1n^2-I1rp^2));
P0=(dPn-m*I1n^2*Rv)*0.5;% 
Pmex=0.33*P0; Pfe=P0-Pmex;
I0a=Pfe/(m*E1); I0p=sqrt(I0^2-I0a^2); 
%===============
X0=E1/I0p; 
R0=E1/I0a;
sinalf=I0a/I0;
Rmu=Pfe/(m*I0^2);
Z0=sqrt(R0^2+X0^2);
Rm=X0^2*R0/Z0^2;
Xm=X0*R0^2/Z0^2;
%===== Puckovoi rezim(PU) ==========
I2pu=0.97*Ki*I1n;
Aa=P2n+Pmex+0.005*P2n/kpdn;
Ab=m*(1-sn)*I2pu^2;
R2pr=Kp*Aa/Ab;  
Zpr=Un/I2pu;
Xpr=sqrt(Zpr^2-(R1+C1*R2pr)^2);
%X2pr=(Xpr-X1*Xpr/Xn)/C1;
X2pr=(Xpr-X1)/C1;
x1=num2str(R1);  x2=num2str(X1);  x3=num2str(R2); x4=num2str(X2);
x5=num2str(Rmu); x6=num2str(Xmu); x7=num2str(R0); x8=num2str(X0);
x9=num2str(R2pr); x10=num2str(X2pr);
x11=num2str(P2n);
%===============================================================
% % Print of rezults calculation             
disp('      PARAMETRS T-obraznoi CXEM ZAMECHENIA AD');
disp(['    ','P2n=',x11,'[Wt]']); 
disp('  ==================================================')
disp(['  R1= ',x1,'[0m];','    ','R2= ', x3, '[Om];']);
disp(['  X1= ',x2,'[Om];','     ','X2= ', x4, '[Om];']);
disp('  ==================================================')
disp(' Posledovatelnoe vkluchenie resistanse  Rmu and Xmu');
disp(['  Rmu= ',x5,'[Om];','    ','Xmu= ', x6, '[Om];']);
disp('  ===================================================');
disp('   Parallelnoe vkluchenie resistanse  Rm0 and Xm0)');
disp(['  Rm0= ',x7,'[Om];','    ','Xm0= ', x8, '[Om];']);
disp('  ==============================================');
disp('     Rotors resistans  R2 and X2 pri S=1 ');
disp(['  R2kp= ',x9,'[Om];','    ','X2kp= ', x10, '[Om];']);
disp('  ==============================================');
Ch=(Rmu+R1)^2+(X1+Xmu)^2;
Zz=Rmu^2+Xmu^2;
C11=sqrt(Ch/Zz);
bet1=R1/(C1*R2);
Pdob=0.005*P2n/kpdn;
%=================================
% Paschet  rabochix 
% and mechanicheskix xar-k AD
%=======================================
h=0.1;
rp1=0:h:1.5;
nn=length(rp1);
mn=1/h+1;
%==================
P2=zeros(1,nn);
P1r=zeros(1,nn);
M=zeros(1,nn);
kpdi=zeros(1,nn);
cosfi=zeros(1,nn);
I1r=zeros(1,nn);
s=zeros(1,nn);
n2=zeros(1,nn);
%=================
P2=P2n.*rp1;
Pdobr=Pdob.*rp1;
P2r=P2+Pdobr+Pmex;
A=m.*Un.^2./(2.*P2r)-R1;
AA=R1/R2*(1+X2/Xmu);
BB=(X1/R2*(1+X2/Xmu)+X2/R2);
Rrp=R2*(AA^2+BB^2);
B=2.*A+Rrp;
s=(A-sqrt(A.^2-C1.^2.*R2.*B))./B;
Rekv=C1.*R1+C1.^2.*R2./s;
Xekv=C1.*X1+C1.^2.*X2;
Zekv=sqrt(Rekv.^2+Xekv.^2);
I2r=Un./Zekv;
cosfir=Rekv./Zekv;
I2ra=I2r.*cosfir;
I2rp=I2r.*sqrt(1-(cosfir).^2);
I1a=I0a+I2ra;
I1p=I0p+I2rp;
I1r=sqrt(I1a.^2+I1p.^2);
cosfi=I1a./I1r;
P1r=m.*Un.*I1a;
kpdi=P2./P1r;
Pcu1=m.*I1r.^2.*R1;
Pem=P1r-Pcu1-Pfe;
n2=n1.*(1-s);
M=9.55.*Pem./n2;
%====================
% Print on display
%=====================
disp('            HOMINAL REZIM');
disp(' =========================================');
P2x=P2(mn); P1x=P1r(mn); Mx=M(mn); kpdx=kpdi(mn);
cosx=cosfi(mn); I1x=I1r(mn); sx=s(mn); nx=n2(mn);
y1=num2str(P2x); y2=num2str(P1x); y3=num2str(Mx);
y4=num2str(kpdx); y5=num2str(cosx); y6=num2str(I1x);
y7=num2str(sx); y8=num2str(nx);
disp(['  Mn= ',y3,'[N*m];','    ','Sn= ', y7, '[o.e];']);
disp(['  P2n= ',y1,'[Bt];','       ','P1n= ', y2, '[Bt];']);
disp(['  kpd= ',y4,'[o.e];','   ','cos(fi)= ', y5, '[o.e];']);
disp(['  I1n= ',y6,'[A];','     ','n2= ', y8, '[0b/min];']);
%===========================================
%Paschet   mexanich. charakter.  M= f(s)
%==========================================
asn=sqrt(s(mn));
R2k=R2pr; X2k=X2pr;
R2rc=(R2-R2k*asn)/(1-asn);
X2rc=(X2-X2k*asn)/(1-asn);
sr=0.025:0.025:1;
mm=length(sr);
%==================
Mr=zeros(1,mm);
as=sqrt(sr);
R2r=zeros(1,mm);
X2r=zeros(1,mm);
%===========================
if sr<=s(11),
    R2r=R2; X2r=X2;
else
    as=sqrt(sr);
    R2r=R2rc+(R2k-R2).*as./(1-asn);
    X2r=X2rc-(X2-X2k).*as/(1-asn);
end  
Zn=n1.*sr.*((R1+C1.*R2r./sr).^2+(X1+C1.*X2r).^2);
Mr=9.55.*m.*Un^2.*R2r./Zn;
[Mmax,j]=max(Mr); Skr=sr(j);
Km=Mmax/M(mn);
z1=num2str(Mmax); z2=num2str(Skr);
z3=num2str(Km);
disp('               Rezim M=Mmax');
disp(' ===================================================');
disp(['  Mmax= ',z1,' [N*m];','      ','Skr= ', z2, ' [o.e];']);
disp(['  Km=  ',z3,' [o.e];']);
%===============================
 disp( '                 Rezim KZ');
 disp( ' ===================================================');
 Zkz=R2k+X2k*i;
 Zmu=Rmu+Xmu*i; Z1=R1+X1*i;
 Z1k=Z1+Zmu*Zkz/(Zmu+Zkz);
 Ik1=Un/Z1k; Ikz=abs(Ik1);
 Mkz=9.55*m*Ikz^2*R2k/n1;
 Ki=Ikz/I1r(mn);
 Kp=Mkz/M(mn);
 v1=num2str(Kp); v2=num2str(Ki);
 disp(['  Kp= ',v1,' [o.e];','      ','Ki= ', v2, ' [o.e];']);
% The end of callculation
%==========================
%    PLOT of GRAFIKS
%==========================
figure(1),
subplot(2,2,[1,3]);
hp1=plot(rp1,kpdi,'r',rp1,cosfi,'-b'); grid,
set(hp1,'LineWidth',1.5);
hx1=xlabel('p2* [o.e]');
set(hx1,'Fontsize',10,'FontAngle','normal','FontWeight','bold');
%hy1=ylabel('kpd, cos(fi)' );
%set(hy1,'Fontsize',10,'FontAngle','normal','FontWeight','normal');
ht=title('   kpd, cos(fi)= f(P2/P2n) ');
set(ht,'Fontsize',10,'FontAngle','normal','FontWeight','bold');
legend('kpd','cos(fi)',4);
%==============================
subplot(2,2,2)
hp1=plot(rp1,I1r,'g'); grid,
set(hp1,'LineWidth',1.5);
%hx1=xlabel('p2* [o.e]');
%set(hx1,'Fontsize',10,'FontAngle','italic','Fontweight','normal');
hy1=ylabel('I1s [A]' );
set(hy1,'Fontsize',10,'FontAngle','normal','FontWeight','bold');
ht=title('Current I1s ');
set(ht,'Fontsize',10,'FontAngle','normal','FontWeight','bold');
%=========================================
subplot(2,2,4);
hp2=plot(rp1,s,'k'); grid,
set(hp2,'LineWidth',1.5);
hx2=xlabel('p2* [o.e]');
set(hx2,'Fontsize',10,'FontAngle','normal','FontWeight','bold');
%hy2=ylabel('s' );
%set(hy2,'Fontsize',10,'FontAngle','normal','Fontweight','normal');
ht1=title('Slip s ');
set(ht1,'Fontsize',10,'FontAngle','normal','FontWeight','bold');
%==================================================================
Mi=[0,Mr]; si=[0,sr];
figure(2),
hp2=plot(si,Mi,'k'); grid,
set(hp2,'LineWidth',1.5);
hx2=xlabel('s [o.e]');
set(hx2,'Fontsize',12,'FontWeight','bold');
hy2=ylabel('M [N*m]' );
set(hy2,'Fontsize',12,'FontWeight','bold');
ht1=title('Moment M=f(s)');
set(ht1,'Fontsize',14,'FontWeight','bold');
disp('                 End of program ');
disp('  ======================================');
%disp('              Raschet is end');
