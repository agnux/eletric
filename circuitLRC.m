% Modelo de Circuito LRC de ordem 2
% Alexandre Galdino da Nóbrega
% Métodos Numéricos: Heun e RK-4 
  crc; clear;

% COEFICIENTES
R = 345 * 10^-5; Elemento de Resistência em Ohm
L =  10 * 10^-2; Elemento de Indutância em Henry
C =  10 * -1; Elemento de Capacitância em Coulomb

% EDO da Tensão. Lei de Kitchkoff
EDO = @(t, ic, tx_ic, tx2_ic) ...
      ( ( 1 / C) + tx2_ic ) + (L * tx_ic) + (R * ic);

% EIXO DO TEMPO
h = 0.0000015; % passo
a = 0; % valor inicial do intervalo
b = 3; % valor final do intervalo 
n = (b - a) / h; % quantidade de iterações

% VALORES INICIAIS
h = 0.0000015;
tn= 3;
n = (tn - t0) / 3;
t(1) = a; ic(1) = 0; % ic é a corrente do condutor elétrico
tx_ic(1) = 0; % tx_ic é a taxa da corrente do condutor
tx2_ic(1) = 0;  % tx2_ic é a taxa de segunda ordem da corrente do condutor

% MÉTODO DE HEUN
k1 = 0; k2 = 0; 
for j=1:n
   t(j+1) = t(j) + h;
   k1 = EDO( t(j) , ic(j), tx_ic(j), tx2_ic(j) );
   k2 = EDO( (t(j) + h / 2), ic(j) + h * (k1 / 2) , tx_ic(j) + h * (k1 / 2) , ...
        tx2_ic(j) + h * ( k1 / 2 ) );
 
   ic(i+1)    = ic(i) + ( h / 2 ) * (k1 + k2);
   tx_ic(i+1) = tx_ic(i) + (h / 2) * (k1 + k2);
   tx2_ic(i+1)= tx2_ic(i) + (h / 2) * (k1 + k2);
end;

figure(1);
subplot(311);
plot(t, ic, '-r');
grid on;

%MÉTODO DE RK-4
k1 = 0; k2 = 0; k3 = 0; k4 = 0;
ic(1) = 0; tx_ic(1) = 0; tx2_ic(1) = 0;

for i=1:n
    t(i+1) = t(i) + h;
    k1 = h * EDO(
