% Opredelenie parametrov cxemi-zamechenia of AD
% Dannie of AD
clc,
Pn=3e3;% nominal power, [WT]
Un=380;  % nominal line voltage, [V]
f=50; % nominal chastota, [HZ}
n=1420; % nominal speed, [ob/min]
kpd=0.81;% nominal kpd, [o.e.]
cosfi=0.81;% nominal cos(fi), [o.e.]
In=7.0; % nominal current, [A]
ik=6.2; % current of s=1, (o.e.)
mk=2.2; % moment pri s=1, (o.e.)
mmax=2.6; % moment pri s=sk, (o.e.)
p=2;% number of par poles
%===========================
Uf=Un/1.73; %faznoe uoltage
n1=60*f/p; % cinxron speed
sn=(n1-n)/n1; % sleep
sk=(mmax+sqrt(mmax^2-1))*sn; % criticheskoe sleep 
w1=2*pi*f; % cinxronoe omega 
w=pi*n/30; % nominal omega 
Mn=Pn/w; % nominal moment
%======================
c=1.02; % c=1.02-1.05 - konstructive koeffisient
Rr=(1.016*Pn)/(3*In^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-kpd))/In)-(Rr*c^2)-(0.06*Pn/(3*In^2));
Ll=Uf/(2*w1*(1+c^2)*ik*In);
Ls=Uf/(w1*In*sqrt(1-cosfi^2)-(2*w1*mmax*Mn*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
disp('     c         c1');
disp([c c1]);
disp(['       ', 'PARAMETRS OF AD']);
disp('     Rs        Rr         Lls       Lm ');
disp([Rs Rr Ll Lm]);
Xm=w1*Lm;
X1s=w1*Ll;
X2r=0.8*X1s;
disp('     X1s         Xm       X2r   [Om]');
disp([X1s Xm  X2r]);
disp('The end')