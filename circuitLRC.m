% Modelo de Circuito LRC de ordem 2
% Alexandre Galdino da Nóbrega
% Métodos Numéricos: Heun e RK-4 
  clc; clear;

% COEFICIENTES
R = 12;  
L = 2; % 4 * 10^-7; %Elemento de Indutância em Henry 10* 10^-2
C = 1; % 5 * 10^-1;
Valimentacao = 10; % 10 volts

% EDO da Tensão. 
EDO = @(t, fluxo_i, tx_fluxo_i, tx2_fluxo_i) ...
      ( ( ( 1 / C) + tx2_fluxo_i ) + (L * tx_fluxo_i) + (R * fluxo_i))  ;% * sin(1000*t);

% EIXO DO TEMPO
h = 10^-5; % passo
a = 0; % valor inicial do intervalo
b = 5; % valor final do intervalo 
n = (b - a) / h; % quantidade de iterações

% VALORES INICIAIS
t(1) = a; fluxo_i(1) = 0; %5 * cos(60*pi*t0); % q é a carga elétrica 
tx_fluxo_i(1) = 0; % tx_ic é a taxa da corrente do condutor
tx2_fluxo_i(1) = 0;  % tx2_ic é a taxa de segunda ordem da corrente do condutor

% MÉTODO DE HEUN
k1 = 0; k2 = 0; 
fprintf("Heun metodo:\n");
for j=1:n
   t(j+1) = t(j) + h;
   k1 = EDO( t(j) , fluxo_i(j), tx_fluxo_i(j), tx2_fluxo_i(j) );
   k2 = EDO( (t(j) + h / 2), fluxo_i(j) + h * (k1 / 2) , tx2_fluxo_i(j) + h * (k1 / 2) , ...
        tx2_fluxo_i(j) + h * ( k1 / 2 ) );
 
   fluxo_i(j+1)    = fluxo_i(j) + ( h / 2 ) * (k1 + k2);
   tx_fluxo_i(j+1) = tx_fluxo_i(j) + (h / 2) * (k1 + k2);
   tx2_fluxo_i(j+1)= tx2_fluxo_i(j) + (h / 2) * (k1 + k2);
   fprintf("%.5f \t %.5f\t\n", t(j), fluxo_i(j));
end

figure(1);
subplot(311);
plot(t, fluxo_i, '-r');
legend('Método Numérico: Heun');
subtitle('Carga elétrica x tempo: Coulomb / s ');
grid on;

%MÉTODO DE RK-4
k1 = 0; k2 = 0; k3 = 0; k4 = 0;
t(1)=0;
tx_fluxo_i(1) = 0; tx2_fluxo_i(1) = 0;
fprintf("RK-4 t(j)  ic(j)\n");
for j=1:n
    t(j+1) = t(j) + h;
    k1 = h * EDO( t(j), fluxo_i(j), tx_fluxo_i(j), tx2_fluxo_i(j) );
    k2 = h * EDO( t(j) + (h / 2), (fluxo(j) + (k1 / 2) ), ...
         tx_fluxo_i(j) + (k1 / 2), tx2_fluxo_i(j) + (k1 / 2) );
    k3 = h * EDO( t(j) + (h / 2), fluxo_i(j) + ( k2 / 2), ...
         tx_fluxo_i(j) + (k2 /2), tx2_fluxo_i(j) + (k2 / 2) );
    k4 = h * EDO( t(j+1), fluxo_i(j) + k3, tx_fluxo_i(j) + k3, tx2_fluxo_i(j) + k3 );
    
    fluxo_i(j+1)   = fluxo_i(j) + (k1 + 2 * k2 + 2 * k3 + k4 ) / 6;
    tx_fluxo_i(j+1)= tx_fluxo_i(j) + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
    tx2_fluxo_i(j+1)=tx2_fluxo_i(j)+ (k1 + 2 * k2 + 2 * k3 + k4) / 6;
    fprintf("%.5f\t %.5f\t\n", t(j), fluxo_i(j));
end;
 
 subplot(312);
 plot(t, fluxo_i, '-b');
 legend('Método: RK-4');
 subtitle('Carga Elétrica x tempo (Coulomb x s)');
 grid on;
