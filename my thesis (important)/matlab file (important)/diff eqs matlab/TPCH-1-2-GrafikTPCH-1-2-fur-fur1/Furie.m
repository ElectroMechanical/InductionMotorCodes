script,
% Callculation  garmoniks of riad Furie
Ts=0.01;% shag of time (diskret of time);
T=100; % interval of time;
%=========================
t=0:0.01:T;
Y=0.6*cos(2.*t)+0.3*sin(2.*pi.*t)+0.7*cos(6*pi.*t+pi/4);% function y
figure(1),
hp1=plot(t,Y); grid
set(hp1,'LineWidth',1);
hx1=Xlabel(' time, [c] ');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=Ylabel(' Y(t)  ');
set(hy1,'FontSize',10,'FontWeight','bold');
ht1=Title('3x chastonii garmonicheskii prochess');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
%========================
df=1/T;% shag of chastoti (discret of chactoti)
Fmax=1/Ts;% diapozon chastot
dovg=length(t);% length vectora (y)
f=-Fmax/2:df:Fmax/2;
X=fft(Y);% Preobrazovanie Furie in chstotnoi oblasti
Xp=fftshift(X);% perestanovka riada chastot;
A=abs(Xp);
A1=A/dovg;
s1=(dovg-1)/2-400; s2=(dovg-1)/2+400;
%===================================
figure(2);
hs2=stem(f(s1:s2),A1(s1:s2)); grid,
set(hs2,'LineWidth',2); 
%stem(f,A1); grid,
hx2=Xlabel(' Frequesy, [Hz] ');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=Ylabel(' Modul Furie ');
set(hy2,'FontSize',10,'FontWeight','bold');
ht2=Title('Modul spektra garmonicheskogo prochessa');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
%===================================
disp(' The end callculation'); 