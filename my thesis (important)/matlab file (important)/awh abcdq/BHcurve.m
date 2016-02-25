script;
clc;
clf;
% Aproksimation  curve H=F(B)for Stal 2013
%==========================================
A=0.05;
D=0.05;
C=10;
bet=3.7;
B=0:0.1:2.2;
H=(A*B.^2+D*B+C).*(exp(bet*B)-exp(-bet*B))/2;
figure(1),
H1=plot(H,B,'k');grid
set(H1,'LineWidth',2);
hx1=XLABEL('H, [A/M]');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=YLABEL('B, [ T ]');
set(hy1,'FontSize',10,'FontWeight','bold');
ht1=title(' Curve  B=f(H) ');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
figure(2),
H1=plot(B,H,'k');grid
set(H1,'LineWidth',2);
hx1=YLABEL('H, [A/M]');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=XLABEL('B, [ T ]');
set(hy1,'FontSize',10,'FontWeight','bold');
ht1=title(' Curve  B=f(H) ');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');

