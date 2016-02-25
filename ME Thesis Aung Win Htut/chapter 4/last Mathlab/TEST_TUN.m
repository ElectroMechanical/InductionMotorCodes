% Rashet parametrov AKD (a1...a16)   for LABA 4
Pn=1700; % WT
Rsa=3.57*2; X1sa=4.99*2; Xma=82.52*3; Rra=3.8*2; X1ra=8.28*2;
Rsb=3.57; X1sb=4.99; 
J=0.0148; k=0.577;
%===========================
Un=380; In=4.3; 
f=50; p=3; m=2;
%===========================
C=31*1e-6;% Mikrofarad
Wb=2*pi*f;% rad/cek
Mb=m*Un*In*p/Wb;
Zb=Un/In; Jb=p*Mb/Wb^2;
%========================
Xsa=X1sa+Xma; Xra=X1ra+Xma;
Xsb=X1sb+k^2*Xma;
%========================
d=Xsa*Xra-Xma^2;
a1=Rsa*Xra/d;
a2=Rsa*Xma/d;
a3=Rsb*Xra/(Xsb*Xra-k^2*Xma^2);
a4=Rsb*k*Xma/(Xsb*Xra-k^2*Xma^2);
a5=a2*Rra/Rsa;
a6=a5*Xsa/Xma;
a7=a4*Rra/Rsb;
a8=a7*Xsb/(k*Xma);
a9=1/(Wb*C*Zb);
a10=Jb/J;
a11=k;a12=1/k;
a13=Zb*a1/Rsa; 
a14=Zb*a2/Rsa;
a15=Zb*a3/Rsb;
a16=Zb*a4/Rsb;
disp('      Parametrs of model DU AKD ');
disp('      ===============================');
disp('     a1         a2        a3      a4');
disp([a1 a2 a3 a4]);
disp('     a5         a6        a7      a8'); 
disp([a5 a6 a7 a8]);
disp('     a9         a10       a11      a12'); 
disp([a9 a10 a11 a12]);
disp('     a13        a14       a15      a16'); 
disp([a13 a14 a15 a16]);
disp('      =========================');
disp('        The end')