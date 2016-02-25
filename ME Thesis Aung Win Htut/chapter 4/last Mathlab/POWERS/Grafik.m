load QPS;
t=ans(1,:);
Q1=ans(2,:);
P1=ans(3,:);
S1=ans(4,:);
cos=0.8
figure(1)
hp2=plot(t,Q1,'r',t,P1,'g',t,S1,'k'); grid ;
set(hp2,'LineWidth',2);
hx2=Xlabel('   time, [c] ');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=Ylabel(' Q [var] , P[Wt], S [VA]  ');
set(hy2,'FontSize',10,'FontWeight','bold');
ht2=Title('GRAFIK of  Q(red), P(green), S(blak) = f(t)');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
figure(2)
hp2=plot(t,cos,'k'); grid ;
set(hp2,'LineWidth',2);
hx2=Xlabel('   time, [c] ');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=Ylabel(' cos(fi)  ');
set(hy2,'FontSize',10,'FontWeight','bold');
ht2=Title('GRAFIK of  cos(fi) = f(t)');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
'The end'