clc; clear;
R = 1; %80; %3 * 10^-1;
L = 1; %0.4;%5 * 10^-1;
C =  0.25; %0.0020; %1 / 4 * pi^2 + 1; %35 * 10^-4;
Valimentacao = 24; %40; %10^3; %12;


% Condicções iniciais
qi = 1; q(1) = qi; % carga elétrica em Coulomb
i(1) = Valimentacao / (R + L); % Ampers

a = 0;
b = 5;
h = 10^-5;
n = (b -a) / h;

% edo's
dq = @(t, q, i) i;
di = @(t, q, i)  1 / L  * (Valimentacao - R * i - (1 / C) * q);
% di = @(t, q, i) (R * i) + (L * q) + (1/C + i);
% MÉTODO DE HEUN
k1_dq = 0; k2_dq = 0;
k1_di = 0; k1_di = 0;
fprintf("Heun metodo:\n");
% vt(1) = i(1) / R;
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
   % vt(j+1)= i(j+1) / R ;
   fprintf("%.5f \t %.5f\t %.5f\n", t(j), i(j), q(j));
end

figure(1);
subplot(311);
plot(t, i, '-r');
legend('Método Numérico: Heun');
subtitle('Corrente Elétrica x tempo [A x s] ');
grid on;
