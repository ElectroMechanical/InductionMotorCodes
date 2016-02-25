%Справочные данные
PH=2.2e3;
UH=380;
f=50;
n=2820;
eff=0.82;
cosfi=0.87;
IH=4.0;
ik=6.5;
mk=2.9;
mmax=3.4;
J=1.5e-4;
p=1;

%Расчет параметров
Uf=UH/1.73;
n1=60*f/p;
sn=(n1-n)/n1;
sk=(mmax+sqrt(mmax^2-1))*sn;
w1=2*pi*f;
w=pi*n/30;
MH=PH/w;
for c=1:0.01:1.08;
Rr=(1.06*PH)/(3*IH^2*((1-sn)/sn));
Rs=((Uf*cosfi*(1-eff))/IH)-(Rr*c^2)-(0.06*PH/(3*IH^2));
Ll=Uf/(2*w1*(1+c^2)*ik*IH);
Ls=Uf/(w1*IH*sqrt(1-cosfi^2)-(2*w1*mmax*MH*sn/p)/(3*Uf*sk));
Lm=Ls-Ll;
c1=1+Ll/Lm;
[Rs Rr Ll Lm c c1]
end






