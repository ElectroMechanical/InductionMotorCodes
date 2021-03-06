%   My supervisor Mr.Yu.A. Mashineskii write it for me :)
%   File - Matriza: Calculation matrix for Diff. Equation of AD
%   Use File M-function <<AD3sim.m>> - diff. equations of AD
%   Nominal date
script,
clc;
clf;
    global A G R pol Jr Mnom w1 Km Kj Un k
    
    disp(' Program Matriza.m     by YU.A. Moshinskii ');
    
%==========================================================================

%   P2n=1700                    %[wt]        rated power
%   y-connected
%   n=697                       %[rev/min]   rated speed of rotor
%   m=3                         %[o.e]       number of phase

    In = 0.67;                   %[A]         rated phase current
    Un  =  220 * sqrt(2);       %[V]         rated input phase voltage 
    f = 50;                     %[Hz]        rated frequency
    pol = 3;                    %[o.e]       number of pole pair
    Mnom = 0 ;              %[N*M]       rated torque(load)
    Jr = 2.8e-4;               %[Kg*m^2]    moment of inertia of rotor
    w1 = 2 * pi * f;            %[1/rad]     frequency of circuit
    k = 0;                      %            timer number of iteration
%==========================================================================
%Parameters of T-basic circuit AD

    
    Rs=0.03545;                    %Resistance of phase stator,[Om]
    Rr=0.03014;                     %Resistance of phase rotor,[Om]
    Xs=0.03898;                    %Leakage reactance of phase stator,[Om]
    Xr=0.1058;                    %Leakage reactance of phase rotor,[Om]
    Xm=1.2252;               %Main mutual reactance of phase stator and rotor,[Om]
    l1s=Xs/w1;                  %X=2*pi*f*L   self inductance stator   
    l2r=Xr/w1;                  %self inductance rotor
    M=Xm/w1;                    %mutual inductance (main)
    Ls=l1s+M;                   %total inductance stator
    Lr=l2r+M;                   %total inductance rotor
    Km=pol*M/sqrt(3);           %coef for moment eq   ????? *M
    Kj=pol/Jr;                  %to find coef for omega equation me-mc=1/kj*dw/dt
    
%==========================================================================
% Formirovanie matrix;

    V1  = Ls * [1 1 1];
    V12 = M  * [1 1 1];
    V2  = Lr * [1 1 1];
    L11 = diag(V1);
    M12 = diag(V12);
    L22 = diag(V2);
    Vsr = [Rs Rs Rs Rr Rr Rr];

%==========================================================================

    U1  = [Un Un Un 0 0 0];
    %Lsr = [Ls 0 0 M 0 0 ; 0 Ls 0 0 M 0  ; 0 0 Ls 0 0 M ; M 0 0 Ls 0 0 ; 0 M 0 0 Ls 0 ; 0 0 M 0 0 Ls ];
    Lsr = [L11 M12 ; M12 L22];
    Rsr = diag(Vsr);
    G0  = zeros(3);
    Gm  = [0 M -M ; -M 0 M ; M -M 0];
    G1  = [0 Lr -Lr ; -Lr 0 Lr ; Lr -Lr 0];
    C0  = [G0 G0 ; Gm G1];
    A   = inv(Lsr);          %coef matrix  |U|     
    KKK=Lsr*A                %TESTING INVERSE
    R   = A * Rsr;           %coef matrix  |i|
    G   = A * C0;            %coef matrix  |i| 

%==========================================================================
% Nachlnie yclovia(initial conditions)
    
    t0 = 0;                    %initial time
    tfinal =0.1;              %final time
    y0=zeros(1,7);             %[0 0 0 0 0 0 0] (row,col) row=1, col=7
%==========================================================================

    [t,y] = ode45('ad3sim',[t0,tfinal],y0');       %' ma kyan say ne. (2025*7)
    n     = length(t);         %for 0.1    n=313   for 0.2 n=2025
    me    = zeros(n,1);        %row =2025 col=1 (col array with all zeros)
%==========================================================================
%Moment
    me(:) = Km .* ( y(:,4) .* ( y(:,2) - y(:,3) ) + y(:,5) .* ( y(:,3) - y(:,1) )+...
            y(:,6) .* ( y(:,1) -y(:,2) ));
    
    Mmax  = max( me(:) );            %Max Monent
    Km    = Mmax/Mnom;               %kratnoc Moment
    Imax  = max( y(:,1) );           %Max Phase Current Stator
    Ki    = Imax/In;                 %kratnoc current
    disp(['      ','Km','       ','Ki']);
    disp([Km , Ki]);                 %output results
%==========================================================================
    figure(1),
    
%   subplot(3,1,1);

    subplot(3,4,[1,2]);
    H1 = plot(t(:),y(:,1),'r');  grid;
    set(H1,'LineWidth',2);
    
%   hx1 = XLABEL('t, [c]');
%   set(hx1,'FontSize',10,'FontWeight','bold');

    hy1 = YLABEL('IA [A]');
    set(hy1,'FontSize',10,'FontWeight','bold');
    ht1 = title('Current IA,IB,IC vs time ');
    set(ht1,'FontSize',12,'FontName','Arial','FontWeight','bold');
%==========================================================================
    subplot(3,4,[5,6]);
    H3 = plot(t(:),y(:,2),'b');  grid;
    set(H3,'LineWidth',2);
    hy3 = YLABEL('IB [A]');
    set(hy3,'FontSize',10,'FontWeight','bold');
%==========================================================================
    subplot(3,4,[9,10]);
    H4 = plot(t(:),y(:,2),'k');  grid;
    set(H4,'LineWidth',2);
    hx4 = XLABEL('t ,[c]');
    set(hx4,'FontSize',10,'FontWeight','bold');
    hy4 = YLABEL('IC [A]');
    set(hy4,'FontSize',10,'FontWeight','bold');
%==========================================================================
%figure(2),
    subplot(3,4,[3,4,7,8,11,12]);
    H2 = plot(t(:),me(:),'k');  grid;
    set(H2,'LineWidth',2);
    hx2 = XLABEL('t ,[c]');
    set(hx2,'FontSize',10,'FontWeight','bold');
%   hy2 = YLABEL('Me,[N*m]');
%   set(hy2,'FontSize',10,'FontWeight','bold');
    ht2 = title('  Torque [Nm] vs time    ');
    set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
    disp([k]);  %how many iteration?(exact value)
    
    
    figure(2),
    
    H2 = plot(t(:),y(:,7),'k');  grid;
    set(H2,'LineWidth',2);
    hx2 = XLABEL('t ,[c]');
    set(hx2,'FontSize',10,'FontWeight','bold');
%   hy2 = YLABEL('Me,[N*m]');
%   set(hy2,'FontSize',10,'FontWeight','bold');
    ht2 = title('  Omega [rad/s] vs time    ');
    set(ht2,'FontSize',12,'FontName','Arial','FontWeight','bold');
    disp([k]);  %how many iteration?(exact value)
    
    
    
        A(1,1)
        R(1,1)
        R(1,4)
        G(1,2)
        G(1,3)
        G(1,5)
        G(1,6)
        A(2,2)
        R(2,2)
        R(2,5)
        G(2,1)
        G(2,3)
        G(2,4)
        G(2,6)
        A(3,3)
        R(3,3)
        R(3,6)
        G(3,1)
        G(3,2)
        G(3,4)
        G(3,5)
        A(4,1)
        R(4,1)
        R(4,4)
        G(4,2)
        G(4,3)
        G(4,5)
        G(4,6)
        A(5,2)
        R(5,2)
        R(5,5)
        G(5,1)
        G(5,3)
        G(5,4)
        G(5,6)
        A(6,3)
        R(6,3)
        R(6,6)
        G(6,1)
        G(6,2)
        G(6,4)
        G(6,5)
    
    
    
    disp('    The end of program     ');
    





    
    
