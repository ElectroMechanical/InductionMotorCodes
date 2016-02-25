% This program is to calculate the transformation of parallel and series
% mutual resisteance and inductance to series and vice visa
clc;
clear;
clf;
%Paschet Rmu i Xmu
%Cxema zamechenia -parallenoe vkluchenia Rc i Xm
Rc=1.2461e3;% om 
Xm=82.9;% om
Zm=Rc*i*Xm/(Rc+i*Xm);
Rmu1=real(Zm);Xmu1=imag(Zm);
disp('Posledovatelnoe vkluchenie');
disp('Zm =Rmu+iXmu');
disp([Rmu1,Xmu1]);
%=======================
%Cxema zamechenia c pocledovatelnim bklucheniem Rmu i Xmu
Rmu=5.4965;% om
Xmu=82.53;% om
k=Rmu/Xmu;
Rc1=Rmu*(1+1/k^2);
Xc1=Xmu*(1+k^2);
disp('Paralelnoe vkluchenie');
disp('Gm =Rc+iXm');
disp(['   ','Rc','         ','Xm']);
disp([Rc1,Xc1]);
%==============================================
f=5:5:100;
Xmf=Xmu./50.*f;
Rmf=Rmu.*(f./50).^1.6;
k=Rmf./Xmf;
Rcf=Rmf.*(1+1./k.^2);
Rcf1=Rc.*(f./50).^0.4;
Rmr=[0 Rmf];
Rcf1r=[0 Rcf1];
fr=[0 f];
Rcfr=[0 Rcf];
figure(1);
subplot(1,2,1)
H26=plot(fr,Rcfr,'-b',fr,Rcf1r,'*k'); grid
set(H26,'LineWidth',2);
hx26=XLABEL('f, [Hz]');
set(hx26,'FontSize',10,'FontWeight','bold');
hy52=YLABEL('Rc [Om] ');
set(hy52,'FontSize',10,'FontWeight','bold');
ht26=title(' Rc via frequency');
set(ht26,'FontSize',12,'FontName','Arial','FontWeight','bold');
subplot(1,2,2)
H23=plot(fr,Rmr,'-b'); grid
set(H23,'LineWidth',2);
hx23=XLABEL('f, [Hz]');
set(hx23,'FontSize',10,'FontWeight','bold');
hy53=YLABEL('Rm [Om] ');
set(hy53,'FontSize',10,'FontWeight','bold');
ht23=title(' Rm via frequency');
set(ht23,'FontSize',12,'FontName','Arial','FontWeight','bold');