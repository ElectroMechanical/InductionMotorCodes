load DanTPCH;% Dannie out file TPCH1 (Model AD+TPCH)
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
Isb=Psb.*a7-Prb.*a8;
Pow=1.5.*(Ua.*Isa+Ub.*Isb);
Q=1.5.*(Ub.*Isa-Ua.*Isb);
S=sqrt(Pow.^2+Q.^2);
%========================
figure(1);
subplot(2,1,1);
hp2=plot(t,Isa,'r'); grid ;
set(hp2,'LineWidth',2);
%hx2=Xlabel('   time, [c] ');
%set(hx2,'FontSize',10,'FontWeight','bold');
hy2=Ylabel(' Ialfa [A] ');
set(hy2,'FontSize',10,'FontWeight','bold');
ht2=Title('Current  Ialfa (t)');
set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
%--------------
subplot(2,1,2);
hp3=plot(t,Isb,'g'); grid ;
set(hp3,'LineWidth',2);
hx3=Xlabel('   time, [c] ');
set(hx3,'FontSize',10,'FontWeight','bold');
hy3=Ylabel(' Ibetta [A]  ');
set(hy3,'FontSize',10,'FontWeight','bold');
ht3=Title('Current  Ibetta (t)');
set(ht3,'FontSize',12,'FontName','Arial','FontWeight','bold');
%=========================
figure(2),
hp4=plot(t,Pow,'r'); grid ;
set(hp4,'LineWidth',2);
hx4=Xlabel(' time, [c] ');
set(hx4,'FontSize',10,'FontWeight','bold');
hy4=Ylabel(' P1 [Wt]  ');
set(hy4,'FontSize',10,'FontWeight','bold');
ht4=Title(' POWER P1(t)');
set(ht4,'FontSize',12,'FontName','Arial','FontWeight','bold');
%--------------
figure(3)
hp5=plot(t,Q,'b'); grid ;
set(hp5,'LineWidth',2);
hx5=Xlabel('   time, [c] ');
set(hx5,'FontSize',10,'FontWeight','bold');
hy5=Ylabel(' Q1 [VAR]  ');
set(hy5,'FontSize',10,'FontWeight','bold');
ht5=Title('Power Q1(t)');
set(ht5,'FontSize',12,'FontName','Arial','FontWeight','bold');
%'The end'