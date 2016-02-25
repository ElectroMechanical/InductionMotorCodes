%Rezult of callculation
clc,
clf,
f=[25 50 75 100 150];
Skr=[0.28 0.133 0.078 0.051 0.027] ;
kpd=[0.83 0.91 0.932 0.94 0.945];
cos=[0.91 0.909 0.9 0.898 0.89];
Bdel=[0.85 0.89 0.91 0.918 0.92];
figure(1);
H26=plot(f,kpd,'-r',f,cos,'-b',f,Bdel,'-k'); grid;
set(H26,'LineWidth',2);
hx26=XLABEL('f, [Hz]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('kpd, cos(fi)[o.e], Bdel[T] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title('kpd, cos(fi), Bdel vs f (M=const)');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
legend('kpd','cos','Bdel',4);
%==============================================================
kpd1=[0.68 0.91 0.93 0.931 0.898];
cos1=[0.9 0.9 0.86 0.82 0.72];
Bdel1=[0.7 0.89 0.92 0.93 0.94];
figure(2);
H2=plot(f,kpd1,'-r',f,cos1,'-b',f,Bdel1,'-k'); grid;
set(H2,'LineWidth',2);
hx2=XLABEL('f, [Hz]');
set(hx2,'FontSize',10,'FontWeight','bold');
hy5=YLABEL('kpd, cos(fi)[o.e], Bdel[T] ');
set(hy5,'FontSize',10,'FontWeight','bold');
ht2=title('kpd, cos(fi), Bdel vs f (P2=const)');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
legend('kpd','cos','Bdel',4);


