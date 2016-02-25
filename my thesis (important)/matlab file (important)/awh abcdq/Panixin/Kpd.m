function y=Kpd(P2nom,p);
% m-function file  KPD_COS1.m use in files Iden1d Idenic.
% esli neizvestni kpd and cos(fi) pri P2=0.25*P2nom.
% Paschet KPD, Cos(fi)= f(P2nom) 
% for various values P2nom and p-number par polusov AD;
% Used dates of seria 4A;
%==============================================
%     Massiv of P2nom  [Kwt];
P2n=[0.25 0.55 1.1 2.2 4 7.5 15 22 37 55 75 90];
%===============================================
%                  KPD = f(P2nom)
% n1=3000 [ob/min]; p=1-chislo par polusov AD;
f1=[0.57 0.69 0.76 0.77 0.80 0.78 0.80 0.79 0.81 0.825 0.81 0.84];
%==================================================================
% n1=1500 [ob/min]; p=2-chislo par polusov;
f2=[0.49 0.55 0.64 0.74 0.795 0.775 0.86 0.855 0.87 0.885 0.885 0.89];
%======================================================================
% n1=1000 [ob/min]; p=3-chislo par polusov;
f3=[0.395 0.525 0.53 0.74 0.77 0.76 0.85 0.875 0.875 0.88 0.90 0.93];
%====================================================================
% n1=750 [ob/min]; p=4-chislo par polusov;
f4=[0.365 0.46 0.55 0.64 0.71 0.795 0.825 0.875 0.865 0.90 0.905 0.93];
%======================================================================
%                  COS(fi) = f (P2nom)
% n1=3000 [ob/min]; p=1-chislo par polusov;
fs1=[0.35 0.57 0.5 0.51 0.6 0.56 0.68 0.68 0.67 0.78 0.71 0.71];
%===============================================================
% n1=1500 [ob/min]; p=2-chislo par polusov;
fs2=[0.26 0.29 0.38 0.42 0.46 0.53 0.63 0.65 0.67 0.69 0.69 0.73];  
%=================================================================
% n1=1000 ob/min]; p=3-chislo par polusov;
fs3=[0.24 0.3 0.33 0.32 0.4 0.4 0.55 0.68 0.63 0.69 0.7 0.67];
%==============================================================
% n1=750 [ob/min]; p=4-chislo par polusov;
fs4=[0.29 0.28 0.3 0.3 0.27 0.35 0.46 0.54 0.5 0.57 0.58 0.57];
%=============================================================
if p==1
    kpdr=interp1(P2n,f1,P2nom);
elseif p==2,
    kpdr=interp1(P2n,f2,P2nom);
elseif p==3,
    kpdr=interp1(P2n,f3,P2nom);
else p==4,
    kpdr=interp1(P2n,f4,P2nom);
end
%===============================
if p==1
    cosr=interp1(P2n,fs1,P2nom);
elseif p==2,
    cosr=interp1(P2n,fs2,P2nom);
elseif p==3,
    cosr=interp1(P2n,fs3,P2nom);
else p==4,
    cosr=interp1(P2n,fs4,P2nom);
end
y=[kpdr cosr];
% End  program
