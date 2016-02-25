function dy=ad_ab(t,y);% script file AB_ab1.m
global Rs Rr Rmu l1s l2r M pol Jr Mnom w1 Km Kj Un k 
%===================================
% Variable potokosceplenia PSI:
% Potokosceplenia of stator
% y(1)=Psia; y(2)=Psib; 
% Potokosceplenia of rotora
% y(3)=Psid; y(4)=Psiq; 
% Currents Imu of statora
% y(5)=Ima;  y(6)=Imb; 
% y(7)=wr; % speed of rotor
% Paschet tokov Ia,Ib,Id,Iq,Ica,Icb;
%=========================================
M=0.268;
%=========================================
Ia=(y(1)-M*y(5))/l1s;
Ib=(y(2)-M*y(6))/l1s;
Id=(y(3)-M*y(5))/l2r;
Iq=(y(4)-M*y(6))/l2r;
Ica=y(5)-Ia-Id;
Icb=y(6)-Ib-Iq;
%====================================
% Diff. equet. for current statora 
dy(1)=Un*sin(w1*t)-Rs*Ia; 
dy(2)=Un*sin(w1*t-pi/2)-Rs*Ib;
%=====================================
% Diff. equetion for current of rotora
dy(3)=-Rr*Id-y(4)*y(7);
dy(4)=-Rr*Iq+y(3)*y(7);
dy(5)=-Rmu/M*Ica;
dy(6)=-Rmu/M*Icb;
%=====================================
% Equetions of torque,
if t<=0.05
    Mc=0;
else
    Mc=Mnom;
end 
%=======================================================
% Various formuls of torque
mem=3/2*pol*(y(4)*Id-y(3)*Iq);
%mem=3/2*pol*M/(M+l2r)*(y(4)*(Id+Ica)-y(3)*(Iq+Icb));% in dq
%========================================================
dy(7)=Kj*(mem-Mc);
k=k+1;
if k==5000 ;
disp('    < Callculation Diff. Equetion >... N=5000');
end;
if k==15000
  disp('   < Callculation Diff. Equetion > ... N=15000');
end;  
if k==30000
  disp('   < Callculation Diff. Equetion > ... N=30000');
end
  if k==50000
  disp('   < Callculation Diff. Equetion > ... N=60000');
end;  
  dy=[dy(1),dy(2),dy(3),dy(4),dy(5),dy(6),dy(7)]';
return
disp('The  end program')