clc; clear;
R = 0.0030;
L = 0.5;
C = 0.0035;
Valimentacao = 12;


% Condicções iniciais
qi = 0.0000000005; q(1) = qi;% Coulomb
ii = 1; i(1) = ii; % Ampers

a = 0;
b = 0.05;
h = 0.0001;
n = (b -a) / h;

dq = @(t, q, i) i;
di = @(t, q, i) (1/L) * (Valimentacao - R * i - (1 / C) * q);


%MÉTODO DE RK-4
r1_dq = 0; r2_dq = 0; r3_dq = 0; r4_dq = 0;
r1_di = 0; r2_di = 0; r3_di = 0; r4_di = 0;
t(1)=0;

fprintf("RK-4 t(j)  ic(j)\n");
for j=1:n
    t(j+1) = t(j) + h;
    r1_dq = h * dq( t(j), q(j), i(j) );
    r2_dq = h * dq( t(j) + (h / 2), q(j) + (r1_dq / 2), ...
                                    i(j) + (r1_dq / 2) );
    r3_dq = h * dq( t(j) + (h / 2), q(j) + ( r2_dq / 2), ...
                                    i(j) + (r2_dq /2) );

    r4_dq = h * dq( t(j+1), q(j) + r3_dq, i(j) + r3_dq );
    
    
    r1_di = h * di( t(j), q(j), i(j) );
    r2_di = h * di( t(j) + (h / 2), q(j) + (r1_di / 2), ...
                                    i(j) + (r1_di / 2) );
    r3_di = h * di( t(j) + (h / 2), q(j) + ( r2_di / 2), ...
                                    i(j) + (r2_di /2) );

    r4_di = h * di( t(j+1), q(j) + r3_di, i(j) + r3_di );
    
    q(j+1)= q(j) + (r1_dq + 2 * r2_dq + 2 * r3_dq + r4_dq ) / 6;
    i(j+1)= i(j) + (r1_di + 2 * r2_di + 2 * r3_di + r4_di) / 6;
    fprintf("%.5f\t %.5f\t\n", t(j), q(j));
end;
 
 subplot(312);
 plot(t, i, '-b');
 legend('Método: RK-4');
 subtitle('Corrente Elétrica x tempo [A x s] ');
 grid on;

