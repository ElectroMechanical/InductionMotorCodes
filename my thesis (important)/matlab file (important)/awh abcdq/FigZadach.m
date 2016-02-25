% «‡‰‡˜‡ 5
% (“√œ“) )
clc;
x1=0:0.1:1;
x=3000.*x1;
y=0.0107.*x;
y1=y-2;
figure(1);
hp1=plot(x,y,'k', x,y1,'*-k'); grid;
set(hp1,'LineWidth',2);
ht=title(' Ugen =f(n)');
set(ht,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hx=xlabel('n [ob/min]');
set(hx,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hy=ylabel(' Ugen [V]');
set(hy,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
text(250,-2,'N_{min}');
%===========================
%IDPT
x3=0:0.1:0.5;
m=1-x1;
m1=0.5-x3;
%=======================================
figure(2);
hp2=plot(x1,m,'k', x3,m1,'-k'); grid;
set(hp1,'LineWidth',2);
ht2=title(' \mu=f(\nu), Iakornoe upravlenie');
set(ht2,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hx2=xlabel('\nu [o.e]');
set(hx2,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hy2=ylabel('\mu [o.e]');
set(hy2,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
%text(0.49,0.82,'Iakornoe upravlenie')
text(0.52,0.52,'\alpha=1');
text(0.31,0.33,'\alpha=0.5');
%=============================================================
figure(3)
x4=0:0.1:2;
m3=0.5-0.25.*x4;
hp3=plot(x1,m,'k', x4,m3,'-k'); grid;
set(hp3,'LineWidth',2);
ht3=title(' \mu=f(\nu), Polusnoe upravlenie');
set(ht3,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hx3=xlabel('\nu [o.e]');
set(hx3,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hy3=ylabel('\mu [o.e]');
set(hy3,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
%text(0.45,0.85,'Polusnoe upravlenie');
text(0.42,0.63,'\alpha=1');
text(1.21,0.23,'\alpha=0.5');
%==================================
ma=0.5-0.5.*(1.25).*x1;
%m3=0.5-0.25.*x4;
figure(4)
hp4=plot(x1,m,'k', x1,ma,'-k'); grid;
set(hp4,'LineWidth',2);
ht4=title(' \mu=f(\nu) AID');
set(ht4,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hx4=xlabel('\nu [o.e]');
set(hx4,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
hy4=ylabel('\mu [o.e]');
set(hy4,'Fontsize',12,'FontAngle','normal','Fontweight','bold');
%text(0.45,0.85,'Polusnoe upravlenie');
text(0.42,0.63,'\alpha_e=1');
text(0.41,0.3,'\alpha_e=0.5');
% Tht End
