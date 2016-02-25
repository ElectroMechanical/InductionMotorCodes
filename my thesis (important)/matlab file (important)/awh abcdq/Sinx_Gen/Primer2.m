script; 
% Primer2.m work with file time2 and dan2.mat
% Building diagram of magnet KC37A-SmCo
% Start date;
%==========================
clc;
clf;
%whitebg,
load dan2.mat,% % zagruzka matrizi X
%X=[tgalfk tgalf0 tgbet tgdel lso lsm e0 ik a] - input massive 
%================================
as=X(5);% lso=2.94
asm=X(6); %lsm=2.85
adl=X(4);%tgdel=29
a0=X(2);% tgalf0=0.031
ak=X(1);% tgalfk=5.49
po=X(3);% a=1
ik=-X(8);% ik=0.138;
e0=X(7);% e0=0.79;
%=================
bsa=1/as;
bsm=1/asm;
bdl=1/adl;
bk=1/ak;
%=================
clf,
b=0:0.05:1;
h=-1+b;
hk=-bk.*b;
hsa=-bsa.*b;
hsm=-bsm.*b;
h0=-a0.*b;
%=========================================
hpp=plot(h',b,'k',hk,b,'k',hsa,b,'b',hsm,b,'r',h0,b,'g');grid
set(hpp,'LineWidth',2);
ht1=title(' Diagram of Permanent Magnet-SmCO5');
set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
hx1=xlabel('H, F, I [p.u]');
set(hx1,'FontSize',10,'FontWeight','bold');
hy1=ylabel('B, Flux, U [p.u]');
set(hy1,'FontSize',10,'FontWeight','bold');
legend('B(H)','Lk','Lsa','Lsm','L0');
%=============== TEXT =====================
bN0=1/(a0+1);
hN0=-a0*bN0;
%===============
bkk=1/(bk+1);
hkk=-bk*bkk;
%===============
ht2=text(-hN0-0.12,bN0,'N0');
set(ht2,'FontSize',10,'FontWeight','bold');
ht4=text(hkk+0.03,bkk,'K');
set(ht4,'FontSize',10,'FontWeight','bold');
ht3=text(hN0-0.04,bN0-0.14,'L0');
set(ht3,'FontSize',10,'FontWeight','bold');
ht5=text(hkk-0.03,bkk-0.09,'Lk');
set(ht5,'FontSize',10,'FontWeight','bold');
ht6=text(-0.32,b(17)-0.15,'Lsm');
set(ht6,'FontSize',10,'FontWeight','bold');
ht7=text(-0.29,b(19)+0.03,'Lsa');
set(ht7,'FontSize',10,'FontWeight','bold');
ht10=text(-0.7,0.42,'B=f(H)');
set(ht10,'FontSize',10,'FontWeight','bold');
%=====================================
hold on
hpt=plot([0 ik],[e0 0],'k');
set(hpt,'LineWidth',2);
ht8=text(ik-0.04,0.05,'ik');
set(ht8,'FontSize',10,'FontWeight','bold');
ht9=text(0.02,e0,'E0');
set(ht9,'FontSize',10,'FontWeight','bold');
hold off,
disp('             ===================');
disp('    === Regime  XX  Coordinatinate of point N0 ===');
disp(sprintf( ' Abscisa  hN0  = %g [o.e]', hN0 ));
disp(sprintf( ' Ordinata bN0  = %g [o.e]', bN0));
%=======================
disp('    === Regime KZ  Coordinatinate of point K ====');
disp(sprintf( ' Abscisa  hk  = %g [o.e]', hkk));
disp(sprintf( ' Ordinata bk  = %g [o.e]', bkk));
disp(' The End Program');