% Paschet xarakteristik M(S) and Is(s)of AD- firma ABB
% Main dannie of AD-firma ABB
%==============================
clc,
unom=220;% faznoe uoltage,
Pn=0.25e3;% nominal power, [WT]
m=3; % chislo faz
f=50;% nominal chastota, [HZ}
Sn=0.08;% nominal slip,
nr=1500*(1-Sn);% nominal speed, [ob/min],
kpd=0.68;% nominal kpd, [o.e.],
cosfi=0.65;% nominal cos(fi), [o.e.],
Inom=Pn/(m*unom*kpd*cosfi); % nominal current, [A],
p=2;% number of par poles,
wc=2*pi*f/p;% sinxron omega ,
w=pi*nr/30; % nominal omega,
Mnom=Pn/w;  % nominal moment,
%================= SERIA 4A ======================
Zb=unom/Inom;%resistanse AD of serii 4A (Spravochik for serii 4A),
R1=0.15*Zb; R2=0.14*Zb; Xmu=1.4*Zb; X1=0.082*Zb; X2=0.17*Zb;
%===========================
xma=Xmu;%250;
rr=R2;%22;
xr=X2;%32;
zsa=R1+j*X1;
%======================
s1=0:0.05:1;
nn=length(s1);
Is=zeros(1,nn);
Mm=zeros(1,nn);
Pem1=zeros(1,nn);
%======================
n=1;
for s=0:0.05:1;
%======================================
del1=rr^2+s^2*(xma+xr)^2;
Rra1=s*xma^2*rr/del1;
Xra1=(xma*rr^2+s^2*xma*xr*(xma+xr))/del1;
Za1=zsa+Rra1+j*Xra1;
%========================
Ia=unom/Za1;
Pem=m*abs(Ia)^2*Rra1;
Mem=Pem/wc;
Iaa=abs(Ia);
Is(n)=Iaa;
Mm(n)=Mem;
Pem1(n)=Pem;
n=n+1;
end
figure(1),
hp1=plot(s1,Is,'r');grid;
set(hp1,'LineWidth',2);
hx1=xlabel('slip, [o.e]');
set(hx1,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
hy1=ylabel('Is [A] ');
set(hy1,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
ht1=title('I = f(s)');
set(ht1,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
%========================
figure(2),
hp2=plot(s1,Mm,'-r'); grid
set(hp2,'LineWidth',2);
hx2=xlabel('slip, [o.e]');
set(hx2,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
hy2=ylabel(' Mem,  [N*M]');
set(hy2,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
ht2=title(' M = f(s) )');
set(ht2,'Fontsize',12,'FontAngle','italic','Fontweight','bold');
%========================
%figure(3);
%plot(s1,Pem1,'b'), grid
%xlabel('slip, [o.e]');
%ylabel(' Pem, [Wt]');
%title('Pem=f(s)');
%========================
Mmax=max(Mm);
Km=Mmax/Mnom;
disp('      ===========');
Ki=Iaa/Inom;
Kp=Mem/Mnom;
fx=num2str(f);
disp(['   f=', fx,'[Hz]']);
disp('     Km        Kp        Ki');
disp([Km Kp Ki]);
% The eng program ABB1.m

