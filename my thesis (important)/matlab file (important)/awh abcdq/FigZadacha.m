% Задача 
clc;
x1=0:0.1:1;
x4=0:0.1:0.8;
m=1-x1;
ma=0.5-1.25./2.*x4;
figure(1)
hp4=plot(x1,m,'k',x4,ma,'-k'); grid;
set(hp4,'LineWidth',2);
ht4=title(' \mu=f(\nu) AID');
set(ht4,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hx4=xlabel('\nu [o.e]');
set(hx4,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hy4=ylabel('\mu [o.e]');
set(hy4,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
%text(0.45,0.85,'Polusnoe upravlenie');
text(0.42,0.63,'\alpha_e=1');
text(0.2,0.43,'\alpha_e=0.5');