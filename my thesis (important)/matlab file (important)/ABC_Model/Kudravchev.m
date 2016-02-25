%     AD - P2=120 [Bt],
 % Calculation for Kudriavchev
clc,
%=============================
% Motor AIP71B4
P2n=750;
r1=11.76;  x1=8.82;
r2=10.42;  x2=9.25;
xm=195.98; 
cos=0.74;
kpd=0.81;
%=======================
omega=314;
U=220;
In=P2n/(3*U*cos*kpd);
Cp=4800*In/U;% Eмкость [[Mkf]
a=-0.5+j*0.866;
a2=-0.5-j*0.866;
z1=r1+j*x1;
zm=j*xm; 
k=1;
%=================================================
s=0.01; 
disp(s);
Cp=40*k;
zk=-1e6/(omega*Cp)*j;
s1=s; s2=2-s;
z2f=r2./s1+j*x2;
z2b=r2./s2+j*x2;
Z11=z1+zm.*z2f./(zm+z2f);
Z22=z1+zm.*z2b./(zm+z2b);
%===================================
a11=Z11; a12=Z22;
a21=a2-a+a2.*Z11./zk;
a22=a-a2+a.*Z22./zk;
A=[a11 a12; a21 a22];
B=[-U 0]';
I=A\B;
I1=I(1);
I2=I(2);
Ib=a2.*I1+a.*I2;
Ic=a.*I1+a2.*I2;
Ia=I1+I2;
Ub=a2.*I1.*Z11+a.*I2.*Z22;
Uc=a.*I1.*Z11+a2.*I2.*Z22;
Ua=I1.*Z11+I2.*Z22;
UC(1,:)=abs(Uc);
UB(1,:)=abs(Ub);
UA=abs(Ua);
IC=abs(Ic);
IB=abs(Ib);
IA=abs(Ia);
%======================
disp(['UA UB UC']);
disp([UA UB,UC]);
%disp([IA IB IC]);
%========================
UB=[199 221 264 277 247 201 163 134];
Ck=[0.5 1 2 3 4 5 6 7];
UC=[189 174 123 60 80 126 156 173];
figure(1)
H1=plot(Ck,UB,'r',Ck,UC,'o-b');grid
set(H1,'LineWidth',2);
hx1=XLABEL('Cp*=Cp/41 [o.e]');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=YLABEL('UB, UC [V]');
set(hy1,'FontSize',10,'FontWeight','bold');
Ht=title(' Voltage UB, UC=f(Cp) for s=0.01');
set(Ht,'FontSize',10,'FontWeight','bold');
legend('UB','UC',1);
%figure(2)
%plot(s,UC(1,:),'r');grid
%H2=plot(s,IC,s,IA,s,IB);grid
%set(H2,'LineWidth',2);
%hx2=XLABEL('s, [o.e]');
%set(hx2,'FontSize',10,'FontWeight','bold');