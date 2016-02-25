% Callculation characteristik M(S) and Is(S) AD- firma ABB
% Main dannie of AD-firma ABB
%==============================
clc,
unom=220;% faznoe uoltage [V]
m=3; % chislo faze,
Pn=0.25e3;% nominal power, [WT]
f=50;% nominal chastota, [HZ}
Sn=0.08;% nominal slip,
nr=1500*(1-Sn);% nominal speed, [ob/min],
kpd=0.68;% nominal kpd, [o.e.],
cosfi=0.65;% nominal cos(fi), [o.e.],
Inom=Pn/(m*unom*kpd*cosfi); % nominal current, [A],
p=2;% number of par poles,
wc=2*pi*f/p; % sinxron omega ,
w=pi*nr/30; % nominal omega,
Mnom=Pn/w; % nominal moment,
%================ SERIA 4A =====================================
Zb=unom/Inom;%resistanse AD of serii 4A (Spravochik for serii 4A),
R1=0.15*Zb; R2=0.14*Zb; Xmu=1.4*Zb; X1=0.082*Zb; X2=0.17*Zb;
%===============================================================
s1=0:0.05:1;
nn=length(s1);
Is=zeros(1,nn);
Mm=zeros(1,nn);
Pem1=zeros(1,nn);
%======================
for f=40:10:60;
xma=Xmu*f/50;
xr=X2*f/50;
zsa=R1+j*X1*f/50; 
rr=R2; 
n=1;
for s=0:0.05:1;
%======================================
del1=rr^2+s^2*(xma+xr)^2;
Rra1=s*xma^2*rr/del1;
Xra1=(xma*rr^2+s^2*xma*xr*(xma+xr))/del1;
Za1=zsa+Rra1+j*Xra1;
%======================
Ua=unom*f/50;
Ia=Ua/Za1;
Pem=m*abs(Ia)^2*Rra1;
Mem=Pem/wc;
Iaa=abs(Ia);
Is(n)=Iaa;
Mm(n)=Mem;
Pem1(n)=Pem;
n=n+1;
end
figure(1),
plot(s1,Is,'k'); grid; hold on;
xlabel('slip, [o.e]');
ylabel('Is [A] ');
title('I = f(s)'); 
legend('f=60','f=50','f=40',4);
%========================
figure(2),
plot(s1,Mm,'-k');grid; hold on ;
xlabel('slip, [o.e]');
ylabel(' Mem,  [N*M]');
title(' M = f(s) )');
legend('f=60','f=50','f=40',4);
%========================
Mmax=max(Mm);
Km=Mmax/Mnom;
fx=num2str(f);
disp(['   f=', fx,'[Hz]']);
Ki=Iaa/Inom;
Kp=Mem/Mnom;
disp('     Km        Kp        Ki');
disp([Km Kp Ki]);
end
%=======================
% The eng program ABB2.m

