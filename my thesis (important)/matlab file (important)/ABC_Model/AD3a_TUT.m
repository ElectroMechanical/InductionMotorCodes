%script,
% Sistems of differensial equestions of 3-phases symmetrical AD  
%               for potokoceplenii
% Used program function VpkYUT.m
%=========================================
clc, clf,
global aa1 aa2 aa3 aa4  a4 a5 Mc Un w1,
disp('   <<  BEGIN CALCULATION >>'),
%=========================
% Initial data
%=========================
Unom=220;  % nominal voltage
f=50;      % nominal frequensy of seti [Hz]
p=3;       % Number of  par poles [o.e]
rs=3.57;   % Resistanse of stator,[Om]
x1=5.2;    % Inductanse of statora X1 [Om]
x2=8.28;   % Inductanse of rotora X2 [Om] 
rr=3.8;    % Resistance of rotor,[Om]
xm=82.5;   % Mutual inductance of stator and rotor [Om] 
jr=1.52e-2;% Moment of inertia,[Kg*mm^2)]
Mc=10.45;  % 17.45 Moment nagruzki, [N*M]; Mnom =17.45 {N*M]
%===========================
w1=2*pi*f;
Un=Unom*sqrt(2);
m=xm/w1; l1=x1/w1; l2=x2/w1;
ls=l1+m; lr=l2+m;
%============================
% Callculation coefficients
%============================
a1=lr/(ls*lr-m^2);
a2=ls/(ls*lr-m^2);
a3=m/(ls*lr-m^2);
a4=3/2*p*m/(ls*lr-m^2);
a5=p/jr;
aa1=rs*a1;
aa2=rs*a3;
aa3=rr*a3;
aa4=rr*a2;
%disp([aa1 aa2 aa3 aa4 a4 a5]');
%===============================
% Program of calculation
%===============================
t0=0;% Start time 
tfinal=0.5;% 0.4 Finish time
%=================================
y0=[0 0 0 0 0];% Start data
%tol=1.e-6;% accuracy of calculation 
%trace=0;
tspan = [t0 tfinal]; 
%options = odeset('RelTol',1e-3,'AbsTol',1e-6);
[t,y]=ode45(@VpkTUT,tspan,y0);%- TUT TORMOZENIE
n=max(size(t));
m=zeros(1,n);
i1=zeros(n,2);
i2=zeros(n,2);
%===========================================
m(:)=a4.*(y(:,2).*y(:,3)-y(:,1).*y(:,4));
i1(:,1)=a1.*y(:,1)-a3.*y(:,3);
i1(:,2)=a1.*y(:,2)-a3.*y(:,4);
i2(:,1)=a2.*y(:,3)-a3.*y(:,1);
i2(:,2)=a2.*y(:,4)-a3.*y(:,2);
[a,j]=min(y(:,5));
j=j+20;
IntPel=3*trapz(t(1:j,1),i1(1:j,1).^2).*rs/t(j,1);
disp(['  ','Pcu', '[Wt]']);
disp(IntPel);
%=================================
figure(1);
subplot(2,1,1)
H1=plot(t(:),m(:),'r'); grid,
set(H1,'LineWidth',2);
ht1=title('Torque of AD Mem(t)');
set(ht1,'FontSize',10,'FontWeight','bold');
%xlabel('time,[C]'),
hy1=ylabel('M_e_m, [N*M]');
set(hy1,'FontSize',10,'FontWeight','bold');
%text(0.03,3.5,'Mmax'),
%=======================================
subplot(2,1,2)
H2=plot(t(:),y(:,5),'-k'); grid,
set(H2,'LineWidth',2);
ht2=title('Frequency of rotor, Wr(t)');
set(ht2,'FontSize',10,'FontWeight','bold');
hx2=xlabel('time, [c]');
set(hx2,'FontSize',10,'FontWeight','bold');
hy2=ylabel(' W_r, [1/c]');
set(hy2,'FontSize',10,'FontWeight','bold');
%===========================================
figure(2);
H3=plot(t,i1(:,1),'b');grid,
set(H3,'LineWidth',2);
ht3=title('Phases current of stator, Is(t)');
set(ht3,'FontSize',10,'FontWeight','bold');
hx3=xlabel('time, [c]');
set(hx3,'FontSize',10,'FontWeight','bold');
hy3=ylabel('I_s_a, [A]');
set(hy3,'FontSize',10,'FontWeight','bold');
%text(0.026,22,'Imax');
disp(' << END CALCULATION >>');
%====================================