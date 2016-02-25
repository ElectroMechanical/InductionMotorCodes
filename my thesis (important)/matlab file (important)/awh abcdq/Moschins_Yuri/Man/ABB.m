% Identification parametrov cxemi-zamechenia AD- firma ABB
% Main dannie of AD-firma ABB
clc,
Pn=0.25e3;% nominal power, [WT]
Un=380; % nominal line voltage, [V]
f=50;% nominal chastota, [HZ}
Sn=0.08;% nominal slip,
sk=0.48;% criticheskoe slip,
n=1500*(1-Sn);% nominal speed, [ob/min],
kpd=0.68;% nominal kpd, [o.e.],
cosfi=0.65;% nominal cos(fi), [o.e.],
In=Pn/(sqrt(3)*Un*kpd*cosfi); % nominal current, [A],
ik=4;% current of s=1, (o.e.),
mk=2.0;% moment pri s=1, (o.e.),
mmax=2.2;% moment pri s=sk, (o.e.),
p=2;% number of par poles,
%===========================
Zb=Un/sqrt(3)/In;%resistanse AD of serii 4A (Spravochik for serii 4A),
R1=0.15*Zb; R2=0.14*Zb; Xmu=1.4*Zb; X1=0.082*Zb; X2=0.17*Zb;
%===========================
Uf=Un/1.73; % faznoe uoltage,
n1=60*f/p; % sinxron speed,
sn=(n1-n)/n1; % slip,
Sk=(mmax+sqrt(mmax^2-1))*sn; % criticheskoe sleep, 
w1=2*pi*f/p; % sinxron omega ,
w=pi*n/30; % nominal omega,
Mn=Pn/w; % nominal moment,
%======================
c=1.047; % c=1.02-1.05 - konstructive koeffisient,
Rr=(1.06*Pn)/(3*In^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-kpd))/In)-(Rr*c^2)-(0.06*Pn/(3*In^2));
Ll=Uf/(2*w1*(1+c^2)*ik*In);
Ls=Uf/(w1*In*sqrt(1-cosfi^2)-(2*w1*mmax*Mn*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
disp('     c         c1');
disp([c c1]);
Xm=w1*Lm;
X1s=w1*Ll;
X2r=0.96*X1s;
disp('     Rs         Rr      Xls        Xm         X2r');
disp([Rs Rr X1s Xm X2r]);
disp('    =============  SERIA 4A ===============');
disp('     Rs         Rr      Xls        Xm          X2s');
disp([R1 R2 X1 Xmu X2]);
disp('The end')

