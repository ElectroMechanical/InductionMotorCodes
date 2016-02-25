script; 
% Primer1.m work with time1 and dan1.mat
% Building diagram of magnet,
% Start date;
%===============
clc;
clf;
%whitebg,
load dan1.mat,% zagruzka matrizi X
%X=[tgalfk tgalf0 tgbet tgdel lso lsm e0 ik a];
%==============================================
as=X(5); % 0.08;
asm=X(6); %0.66;
bdl=X(4);% 0.22;
b0=X(2); % 0.192;
a0=1/b0;
ak=X(1);%0.74;
a=X(9);%0.923;
po=X(3);%0.22;
ik=X(8);%0.88;
e0=X(7);%0.72;
hk=(1+ak-sqrt((1+ak)^2-4*a*ak))/(2*a*ak);
bk=hk*ak;
ba1=hk*(po+ak)/(1+b0*po);
ha1=ba1*b0;
%========================
clf,
h=0:-0.1:-1;
b=(1+h)./(1+a.*h); 
bk1=-ak.*h;
bs=as.*h;
bsm=asm.*h;%-
bp=bk+po.*(h+hk);
h0=[0 -b0];
b0=[0 1.0];
%=========================
hpp=plot(h',[b' bk1' bp'],'k');
set(hpp,'LineWidth',2);
ht1=title(' Diagram of permanent magnet');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx1=xlabel('H, F, I [p.u]');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=ylabel('B, Flux, U [p.u]');
set(hy1,'FontSize',10,'FontWeight','bold');
%============================
ht2=text(-ha1-0.06,ba1+0.05,'N0');
set(ht2,'FontSize',10,'FontWeight','bold');
ht3=text(-ha1-0.04,ba1-0.16,'L0');
set(ht3,'FontSize',10,'FontWeight','bold');
ht4=text(-hk,bk+0.07,'K');
set(ht4,'FontSize',10,'FontWeight','bold');
ht5=text(-hk,bk-0.09,'Lk');
set(ht5,'FontSize',10,'FontWeight','bold');
ht6=text(-0.9,-asm+0.048,'Lsm');% asm-0.15
set(ht6,'FontSize',10,'FontWeight','bold');
ht7=text(-0.9,-as+0.01,'Lsa');
set(ht7,'FontSize',10,'FontWeight','bold');
hold on
%=======================================
plot(h',[ bs' bsm'],'k');
hpt=plot([0 -ik],[e0 0],'r');
set(hpt,'LineWidth',2);
plot (h0, b0,'b');
plot(-hk,bk,'or');
plot(-ha1,ba1,'or');grid,
ht8=text(-ik,0.07,'ik');
set(ht8,'FontSize',10,'FontWeight','bold');
%ht9=text(-0.048,e0+0.08,'E0');
ht9=text(0.02,e0-0.02,'E0');
set(ht9,'FontSize',10,'FontWeight','bold');
hold off,
disp('             ===================');
disp('    === Regime  XX  Coordinatinate of point N0 ===');
disp(sprintf( ' abscisa hN0  = %g [o.e]', ha1 ));
disp(sprintf( ' ordinata bN0 = %g [o.e]', ba1));
disp('    === Regime KZ  Coordinatinate of point K ====');
disp(sprintf( ' abscisa hk  = %g [o.e]', hk));
disp(sprintf( ' ordinata bk = %g [o.e]', bk));
disp(' The end program');