clc; clear;
R = 0.0030;
L = 0.5;
C = 0.0035;
Valimentacao = 12;


% Condicções iniciais
qi = 0.0000000005; q(1) = qi;% Carga elétrica em Coulomb
i(1) = 0; % Ampers

a = 0;
b = 0.05;
h = 0.0001;
n = (b -a) / h;

% edo's
dq = @(t, q, i) i;
di = @(t, q, i) (1/L) * (Valimentacao - R * i - (1 / C) * q);

% MÉTODO DE HEUN
k1_dq = 0; k2_dq = 0;
k1_di = 0; k1_di = 0;
fprintf("Heun metodo:\n");
t(1) = a;
for j=1:n
   t(j+1) = t(j) + h;
   k1_dq = dq( t(j) , q(j), i(j) );
   k2_dq = dq( t(j) + h /2, q(j) + h * (k1_dq / 2), ...
               i(j) + h * (k1_di / 2)) ;
   
   k1_di = di( t(j), q(j), i(j) );
   k2_di = di( t(j) + h / 2, q(j) + h * (k1_di / 2), ...
                              i(j) + h * (k1_di / 2) );
   
   q(j+1) = q(j) + ( h / 2) * (k1_dq + k2_dq);
   i(j+1) = i(j) + ( h / 2) * (k1_di + k2_di);
   fprintf("%.5f \t %.5f\t %.5f\n", t(j), i(j), q(j));
end

figure(1);
subplot(311);
plot(t, i, '-r');
legend('Método Numérico: Heun');
subtitle('Corrente Elétrica x tempo [A x s] ');
grid on;
