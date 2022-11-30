% Modelo de Circuito LRC de ordem 2
% Alexandre Galdino da Nóbrega
% Métodos Numéricos: Heun e RK-4 
  clc; clear;

% COEFICIENTES
R = 127 * 10^-6; %Elemento de Resistência em Ohm 345 * 10^5
L =  1 * 10^-7; %Elemento de Indutância em Henry 10* 10^-2
C = 133 * 10^-3; % Elemento de Capacitância em Far 1 ^10^-1

% EDO da Tensão. Lei de Kitchkoff com fator seno 
EDO = @(t, q, tx_ic, tx2_ic) ...
      ( ( ( 1 / C) + tx2_ic ) + (L * tx_ic) + (R * q)) % * sin(1000*t);

% EIXO DO TEMPO
h = 0.0001; % passo
a = 0; % valor inicial do intervalo
b = 5; % valor final do intervalo 
n = (b - a) / h; % quantidade de iterações

% VALORES INICIAIS
t(1) = a; q(1) = 0; % q é a carga elétrica 
tx_ic(1) = 0; % tx_ic é a taxa da corrente do condutor
tx2_ic(1) = 0;  % tx2_ic é a taxa de segunda ordem da corrente do condutor

% MÉTODO DE HEUN
k1 = 0; k2 = 0; 
fprintf("Heun metodo:\n");
for j=1:n
   t(j+1) = t(j) + h;
   k1 = EDO( t(j) , q(j), tx_ic(j), tx2_ic(j) );
   k2 = EDO( (t(j) + h / 2), q(j) + h * (k1 / 2) , tx2_ic(j) + h * (k1 / 2) , ...
        tx2_ic(j) + h * ( k1 / 2 ) );
 
   q(j+1)    = q(j) + ( h / 2 ) * (k1 + k2);
   tx_ic(j+1) = tx_ic(j) + (h / 2) * (k1 + k2);
   tx2_ic(j+1)= tx2_ic(j) + (h / 2) * (k1 + k2);
   fprintf("%.5f \t %.5f\t\n", t(j), q(j));
end

figure(1);
subplot(311);
plot(t, q, '-r');
legend('Método Numérico: Heun');
subtitle('Carga elétrica x tempo: Coulomb / s ');
grid on;

%MÉTODO DE RK-4
k1 = 0; k2 = 0; k3 = 0; k4 = 0;
t(1)=0;
q(1) = 0; tx_ic(1) = 0; tx2_ic(1) = 0;
fprintf("RK-4 t(j)  ic(j)\n");
for j=1:n
    t(j+1) = t(j) + h;
    k1 = h * EDO( t(j), q(j), tx_ic(j), tx2_ic(j) );
    k2 = h * EDO( t(j) + (h / 2), (q(j) + (k1 / 2) ), ...
         tx_ic(j) + (k1 / 2), tx2_ic(j) + (k1 / 2) );
    k3 = h * EDO( t(j) + (h / 2), q(j) + ( k2 / 2), ...
         tx_ic(j) + (k2 /2), tx2_ic(j) + (k2 / 2) );
    k4 = h * EDO( t(j+1), q(j) + k3, tx_ic(j) + k3, tx2_ic(j) + k3 );
    
    ic(j+1)   = q(j) + (k1 + 2 * k2 + 2 * k3 + k4 ) / 6;
    tx_ic(j+1)= tx_ic(j) + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
    tx2_ic(j+1)=tx2_ic(j)+ (k1 + 2 * k2 + 2 * k3 + k4) / 6;
    fprintf("%.5f\t %.5f\t\n", t(j), ic(j));
end;
 
 subplot(312);
 plot(t, q, '-b');
 legend('Método: RK-4');
 subtitle('Carga Elétrica x tempo (Coulomb x s)');
 grid on;
