script,
clc,
clf,
% Callculation dinamich. inductivnostei Lpo and Lto
% –асчет динамических индуктивностей,
% lm0=xm/omega1; imn=5.6;
% l1s=xs/omega1; l2r=xr/omega1;
lm0=0.2628; 
imn=3.5;
im=0:1:10;;
i0=im./imn;
lt0=(0.12+1.077./(sqrt(0.5+i0.^2)));
lt=(0.12+1.077./(sqrt(0.5+i0.^2)))*lm0;
lp0=lt-i0.^2.*(1.077./sqrt((0.5+i0.^2).^3));
lp=lt-i0.^2.*(1.077./sqrt((0.5+i0.^2).^3))*lm0;;
figure(1);
H=plot(i0,lt,'-k',i0,lp,'-r');grid on
set(H,'LineWidth',2);
legend('Lt0','Lp0',1);
title('Inductivn. Lt0, Lp0=f(Imu)','FontSize', 12,'FontAngle','italic','FontWeight','bold');
xlabel('im0 [o.e]','FontSize', 12,'FontWeight','bold'),
ylabel('Lt0 (o.e), Lp0 (o.e)','FontSize', 12,'FontWeight','bold'),
%===================================
figure(2);
H1=plot(im,lt,'-k',im,lp,'-r');grid on
set(H1,'LineWidth',2);
legend('Lt','Lp',1);
title('Inductivn. Lt, Lp=f(Imu)','FontSize', 12,'FontAngle','italic','FontWeight','bold');
xlabel('im [A]','FontSize', 12,'FontWeight','bold'),
ylabel('Lt (Hn), Lp (Hn)','FontSize', 12,'FontWeight','bold'),
% The End Program