% Script file Iden1d.m 
% Opredelenie parametrs sxem zameschenia AD
% Raschet po ctatie  "Identification of parametrs AD",
% Becpalov V.I, Moscinskii Y.A.- write in
% jornal "Elektrichestvo" - N4, 1998year. 
% Insrution: zapustie file Iden1d.m, zatem file Iden2d.m,
% Program function y= Kpd(p2nom,p)
clc;
%==============================
%     VVOD date AD  
%==============================
%      NOMINAL REZIM
%==============================
P2n=7.5e3; % nominal power [Wt]
Un=220; f1=50;% nominal faznoe U and chastota ceti
m=3; p=2; % chislo faz and chislo polusov
kpdn=0.88; cosn=0.86; % nominal kpd and cos(fi)
Km=3; Kp=1.7; %Km=Mmax/Mnom; Kp=Mkz/Mnom;
Ki=6.7; %  Ki=I1kz/I1nom
n1=60*f1/p;% sinxron. chastota [ob/min]
nr=1461; % chastota rotora [ob/min]
sn=1-nr/n1; % nominal slip
%==============================================
%===============================================
%   REZIM  RELATIVE POWER - P2rp=rp*P2n; 
%         rp=0.25;   
%==============================================
rp=0.25; % Koeffisient  power rp=P2/P2n
P2nom=P2n*1e-3; % perevod Nominal Power in [kWt]
y=Kpd(P2nom,p);
kpdr=y(1,1); cosr=y(1,2);% kpd, cos(fi) pri rp=0.25
%===============================================
%   MAIN PROGRAM
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
X=[R1 R2 Rmu X1 X2 Xmu P2n Pdob C11 m Un R2pr X2pr n1 Pmex I0a I0p Pfe];
save dan1 X,
%disp('              Raschet is end');
%===================================
Iden2d