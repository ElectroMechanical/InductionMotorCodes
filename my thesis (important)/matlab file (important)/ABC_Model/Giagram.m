% Diagramma
clc
clf
f=[25 50 75 100]'; % f [Hz]
T=[1 2 3 5;
  3 5 6 7]'; 
P=[100 200 300 350;
     50 60 70 80]'; 
figure(1);
%subplot(1,2,1);%
%b1=bar(f,P);colormap([0 0 0;1 1 1]);
b1=bar(f,P); dd=colormap(summer);
ht1=title('Losses of iron');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
%H2=plot(t(:,1),me(:,1),'r');grid;
%set(H2,'LineWidth',2);
hx1=XLABEL('f, [Hz]');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=YLABEL('Pfe, [Wt]');
set(hy1,'FontSize',10,'FontWeight','bold');
legend('2-model','1-model',2);
figure(2)
%subplot(1,2,2);
%b=bar(f,T);colormap([1 1 1; 1 0 0]); 
b=bar(f,T);colormap(cool)
%b=bar(f,T);colormap(summer)
hp2=title('Computer time');
set(hp2,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx2=XLABEL('f, [Hz]');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=YLABEL('t, [c]');
set(hy2,'FontSize',10,'FontWeight','bold');
legend('1-model','2-model',2);
%figure(2)
%bar3(f,T);