function dy=ad_dqj(t,y);% script file ABC_dqj.m
global Rs Rr Rmu l1s l2r M pol Jr Mnom w1 Km Kj Un k 
%===================================
% Variable potokosceplenia PSI:
% Potokosceplenia of stator
% y(1)=PsiA; y(2)=PsiB; y(3)=PsiC;
% Potokosceplenia of rotora
% y(4)=Psid; y(5)=Psiq; 
% Currents Imu of statora
% y(6)=Ima;  y(7)=Imb; y(8)=Imc;
% y(9)=wr; % speed of rotor
% Paschet tokov Ia,Ib,Ic,Id,Iq,Ica,Icb,Icc
%=========================================
Im=sqrt(2/3*(y(6)^2+y(7)^2+y(8)^2));
%I0n=3.52;% [A] tok Imn=2.46*sqrt(2)-amplituda
i0=Im/3.52;
%========================================
%Lm0=0.2628;% [Hn] Lbaz
M1=0.268*(0.12+1.077/(sqrt(0.5+i0^2)));
%=========================================
Ia=(y(1)-M1*y(6))/l1s;
Ib=(y(2)-M1*y(7))/l1s;
Ic=(y(3)-M1*y(8))/l1s;
Id=(y(4)-M1*y(6))/l2r;
Iq=(y(5)-M1*(y(7)-y(8))/sqrt(3))/l2r;
Ica=y(6)-Ia-Id;
Icb=y(7)-Ib+Id/2-Iq*sqrt(3)/2;
Icc=y(8)-Ic+Id/2+Iq*sqrt(3)/2;
%===================================
%Ima=(Ia+Id);
%Imb=(Ib-Id/2+Iq*sqrt(3)/2);
%Imc=(Ic-Id/2-Iq*sqrt(3)/2);
%================================================================
% Diff. equet. for current statora 
dy(1)=Un*sin(w1*t)-Rs*Ia; 
dy(2)=Un*sin(w1*t-2*pi/3)-Rs*Ib;
dy(3)=Un*sin(w1*t+2*pi/3)-Rs*Ic;
%=====================================
% Diff. equetion for current of rotora
dy(4)=-Rr*Id-y(5)*y(9);
dy(5)=-Rr*Iq+y(4)*y(9);
dy(6)=-Rmu/M*Ica;
dy(7)=-Rmu/M*Icb;
dy(8)=-Rmu/M*Icc;
%=====================================
% Equetions of torque,
if t<=0.05
    Mc=0;
else
    Mc=Mnom;
end 
%=======================================================
% Various formuls of torque
%mem=Km*(y(1)*(Ib-Ic)+y(2)*(Ic-Ia)+y(3)*(Ia-Ib)); % in abc
%Pmd=y(4)-Id*l2r; Pmq=y(5)-Iq*l2r;
%mem=3/2*pol*(Pmq*Id-Pmd*Iq);% in  coordinate dq Psim*Ir
mem=3/2*pol*(y(5)*Id-y(4)*Iq);% in dq
%========================================================
dy(9)=Kj*(mem-Mc);
k=k+1;
if k==5000 ;
disp('    < Callculation Diff. Equetion >... N=5000');
end;
if k==15000
  disp('   < Callculation Diff. Equetion > ... N=15000');
end;  
if k==30000
  disp('   < Callculation Diff. Equetion > ... N=30000');
end;  
  dy=[dy(1),dy(2),dy(3),dy(4),dy(5),dy(6),dy(7),dy(8),dy(9)]';
return
disp('The  end program')