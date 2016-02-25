% Test voltage for nonsinusoidal U ( firma ABB)
% FOR diplom ORLOV MIXAILA
script;
t=0:0.01:12;
%omega=pi*100;
%tet=3.*omega.*t./pi;
%u1=2/3.*cos(omega.*t);
u1=cos(t);
tet=3.*t./pi;
%x=fix(tet);
x=floor(tet);
u=cos(pi./3.*x);
%================
figure(1);
%subplot(2,1,1)
hp=plot(t,u(:),'k-',t,u1,'r-'); grid,
set(hp,'LineWidth',1.2);
ht1=title('Phase voltage: nonsinus (black), sinus voltage (red) ');
set(ht1,'FontSize',10,'FontAngl','normal','FontWeigh','bold');
hx2=xlabel('                                               time, (o.e) ');
set(hx2,'FontSize',10,'FontAngl','italic','FontWeigh','bold');
hy1=ylabel('Voltage, (o.e)');
set(hy1,'FontSize',10,'FontAngle','italic','FontWeight','bold');
%===============================
%subplot(2,1,2)
%hp1=plot(t,u1(:),'k');grid,
%set(hp1,'LineWidth',1.2);
%ht2=title('Sinus phase voltage ');
%set(ht2,'FontSize',10,'FontAngl','italic','FontWeigh','bold');
%hx2=xlabel('                                                time, (o.e) ');
%set(hx2,'FontSize',10,'FontAngl','italic','FontWeigh','bold');
%hy2=ylabel('Voltage, (o.e)');
%set(hy2,'FontSize',10,'FontAngl','italic','FontWeigh','bold');
disp(' The end callculation');