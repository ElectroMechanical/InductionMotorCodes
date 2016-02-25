%sprabochnie dannie
%   This program calculte parametes of ad from template data
% Original data from book (gelman garkin) original name as.m
% PH=2.2e3;
% UH=380;
% f=50;
% n=2820;
% eff=0.82;
% cosfi=0.87;
% IH=4.0;
% ik=6.5;
% mk=2.9;
% mmax=3.4;
% J=1.5e-4;
% p=1;


clc;
%2.2kw motor
PH=2.2e3;
UH=380;
f=50;
n=1423;
eff=0.79;
cosfi=0.82;
IH=5.127;
ik=6.5;
mk=2.1;  %mk=mp/mn
mmax=2.4;
% J=1.5e-4;
p=2;

%calculation of parameters
Uf=UH/1.73;
n1=60*f/p;
sn=(n1-n)/n1;
sk=(mmax+sqrt(mmax^2-1))*sn;
w1=2*pi*f;
w=pi*n/30;
MH=PH/w;
disp('Rs    Rr      L1      Lm      c       c1');

%first we test with different vale of c and then correct with the vale of
%c1 i.e. if c=c1 then use the parameters
for c=1:0.01:1.08;
    Rr=(1.06*PH)/(3*IH^2*((1-sn)/sn));
    Rs=((Uf*cosfi*(1-eff))/IH)-(Rr*c^2)-(0.06*PH/(3*IH^2));
    Ll=Uf/(2*w1*(1+c^2)*ik*IH);
    Ls=Uf/(w1*IH*sqrt(1-cosfi^2)-(2*w1*mmax*MH*sn/p)/(3*Uf*sk));
    Lm=Ls-Ll;
    c1=1+Ll/Lm;
    [Rs Rr Ll Lm c c1]
end


%    4.0388    1.6002    0.0051    0.2341    1.0200    1.0220



