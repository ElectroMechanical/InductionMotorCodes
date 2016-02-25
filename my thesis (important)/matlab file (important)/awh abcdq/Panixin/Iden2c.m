% M file Iden2c.m
% Paschet  rabochix 
% and mechanicheskix xar-k AD
% Instruction: zapustite file Iden1c.m, zatem file Iden2c.m
clear;
%=======================================
load dan1.mat
%=======================================
R1=X(1); R2=X(2); Rmu=X(3);
X1=X(4); X2=X(5); Xmu=X(6);
P2n=X(7); Pdob=X(8); C1=X(9); 
m=X(10); Un=X(11);
R2k=X(12); X2k=X(13);
n1=X(14); Pmex=X(15);
I0a=X(16); I0p=X(17);
Pfe=X(18);
%==================
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
hp1=plot(rp1,kpdi,'k',rp1,cosfi,'-ok'); grid,
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
hp1=plot(rp1,I1r,'k'); grid,
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
ht1=title('Grafik moment AD M=f(s) ');
set(ht1,'Fontsize',14,'FontWeight','bold');
disp('                 End of program ');
disp('  ======================================');
