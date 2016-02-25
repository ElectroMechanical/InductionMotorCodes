load dataAlphaBeta;% Date out file TPCH1.m (Model AD+TPCH),
% or out file Difteplo1.m 
%Plot grafiki Tetalob and Tetapaz=f(t);
clc;
t=ans(1,:);
Moment=ans(2,:);
Omega=ans(3,:);
Isa=ans(4,:);
P1=ans(5,:);
Q1=ans(6,:);
%==================
figure(1);
hp2=plot(t,Moment,'r',t,Omega,'b',t,Isa,'k'); grid ;
set(hp2,'LineWidth',2);
%hx2=Xlabel('   time, [c] ');
%set(hx2,'FontSize',10,'FontWeight','bold');
hy2=Ylabel(' teta_lob [grag Celcia]');
set(hy2,'FontSize',10,'FontWeight','bold');
ht2=Title('Teperature  Tlob(t)');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
%--------------

%=========================
figure(2),
hp4=plot(t,P1,'r',t,Q1,'b'); grid ;
set(hp4,'LineWidth',2);
hx4=Xlabel(' time t*=t/Tbaz, [o.e] ');
set(hx4,'FontSize',10,'FontWeight','bold');
hy4=Ylabel(' t [Grag Celcia]  ');
set(hy4,'FontSize',10,'FontWeight','bold');
ht4=Title(' Tlob and Tpaz vc time');
set(ht4,'FontSize',12,'FontName','Arial','FontWeight','bold');
legend('Tlob','Tpaz',4);
%--------------
figure(3),
hp5=plot(t,Isa,'b'); grid ;
set(hp5,'LineWidth',2);
hx5=Xlabel(' time t*=t/Tbaz, [o.e] ');
set(hx5,'FontSize',10,'FontWeight','bold');
hy5=Ylabel(' t [Grag Celcia]  ');
set(hy5,'FontSize',10,'FontWeight','bold');
ht5=Title(' Tlob and Tpaz vc time');
set(ht5,'FontSize',12,'FontName','Arial','FontWeight','bold');
legend('Tlob','Tpaz',4);
%--------------
%End program