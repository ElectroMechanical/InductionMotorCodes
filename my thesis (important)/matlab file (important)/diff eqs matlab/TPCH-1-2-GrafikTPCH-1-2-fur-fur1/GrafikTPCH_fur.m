load DanTPCH;% Dannie out file TPCH1.m [Model-AD+TPCH],
% a takze iz file TPCH1a.m and TPCH2.m [Model-Ua=sin(w*t),Ub=cos(w*t)]
% Postroenie izobrazenia FURIE
clc;
t=ans(1,:);
Psa=ans(2,:);
Pra=ans(3,:);
Psb=ans(4,:);
Prb=ans(5,:);
Ua=ans(6,:);
Ub=ans(7,:);
%==================
a7=25.11; a8=22.81;
Isa=Psa.*a7-Pra.*a8;
%Isb=Psb.*a7-Prb.*a8;
%Pow=1.5.*(Ua.*Isa+Ub.*Isb);
%Q=1.5.*(Ub.*Isa-Ua.*Isb);
%S=sqrt(Pow.^2+Q.^2);
%========================
N=length(t);% dlina vektora t
tk=t(N)-t(200);
t1=t(200:end);
t2=t(200:end)-t(200);
N1=length(t1);% dlina vektora t1
N2=length(t2);
Isa1=Isa(200:end);% dlina vektora Isa1
Isa2=Isa(200:end)-Isa(200);
NI1=length(Isa1);
NI2=length(Isa2);
%disp([N,N1,N2,NI1,NI2]);
%==================================
Y=fft(Isa2,512);
Af=Y.*conj(Y)./512;
f=1e4/35*(0:255)/512;
%======================
%x=fftshift(Y);
%Af=abs(x);
%f1=-Fmax/2:df:Fmax/2;
Nf=length(f);
NAf=length(Af);
disp('    Nf,  Na')
disp([Nf,NAf]);
%==================
figure(1);
hp2=plot(t2,Isa2,'r'); grid ;
set(hp2,'LineWidth',2);
hx2=Xlabel('   time, [c] ');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=Ylabel(' Ialfa [A] ');
set(hy2,'FontSize',10,'FontWeight','bold');
ht2=Title('Current  Ialfa (t)');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=========================
figure(2),
hp4=plot(f,Af(1:256),'k'); grid ;
set(hp4,'LineWidth',2);
hx4=Xlabel(' frequensy, [Hz] ');
set(hx4,'FontSize',10,'FontWeight','bold');
hy4=Ylabel(' Amplituda ');
set(hy4,'FontSize',10,'FontWeight','bold');
ht4=Title(' Spektr Furie');
set(ht4,'FontSize',12,'FontName','Arial','FontWeight','bold');
%ginput % 
%--------------
disp('The end');