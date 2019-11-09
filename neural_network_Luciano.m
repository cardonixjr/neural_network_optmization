%---------------------------------------------------%
%  Devido ao número de iteracoes necessarias para   %
%  se chagar na precisao desejada, a execucao do    %
%  algoritmo demora alguns segundos.                %
%---------------------------------------------------%

f = @(x,y) 3*x + y;
% Os limites da funcao, tanto para x quanto para y sao -3 e 3

% Cria o grupo de treino com "num_ind" individuos
num_ind = 10;

for i=1:num_ind
  x(i,1) = -2 + rand()*4;
  x(i,2) = -2 + rand()*4;
  x(i,3) = f(x(i,1), x(i,2));
end

disp("Pontos iniciais");
disp(x)

% Cria os pesos iniciais, entre 0 e 0.1
for i=1:6
  w(i) = rand()/10; 
end

new_w = w;  % Auxiliar

disp("\n\nPesos iniciais:")
disp(w)

step = 0.0001;

tolerancia = 0.01;

erro_med = 10000000;
cont = 0;

while erro_med >= tolerancia  
erro_total = 0;
  for i=1:num_ind
    % Cria a hiden layer
    h(i,1) = x(i,1)*w(1) + x(i,2)*w(2);
    h(i,2) = x(i,1)*w(3) + x(i,2)*w(4);
  
    % Calcula o output
    y(i) = h(i,1)*w(5) + h(i,2)*w(6);
    
    erro_total = erro_total + 0.5*(y(i) - x(i,3))^2;  
  end
  
  erro_med = erro_total/num_ind;
  
  for i=num_ind:-1:1
    delta = (y(i) - x(i,3));
    
    new_w(6) = w(6) - step*(h(i,2)*delta);
    new_w(5) = w(5) - step*(h(i,1)*delta);
    new_w(4) = w(4) - step*(x(i,2)*delta*w(6));
    new_w(3) = w(3) - step*(x(i,1)*delta*w(6));
    new_w(2) = w(2) - step*(x(i,2)*delta*w(5));
    new_w(1) = w(1) - step*(x(i,1)*delta*w(5));
    
  end
  
  w = new_w
  
  cont = cont +1; 

  % Pega outros pontos
  for i=1:num_ind
    x(i,1) = -2 + rand()*4;
    x(i,2) = -2 + rand()*4;
    x(i,3) = f(x(i,1), x(i,2));
  end  
end

% -------------------------------------------------------- %
% Testa a rede treinada para o ponto (1,1), com f(1,1) = 4 %


test = [1, 1, f(1,1)];
h1 = test(1)*w(1) + test(2)*w(2);
h2 = test(1)*w(3) + test(2)*w(4);

disp("------ Actual -------")
yf = h1*w(5) + h2*w(6)

disp("------ Prediction -------")
disp(test(3));

disp("----------------")
disp("Pesos finais")
disp(w);
disp("Outputs finais")
disp(y);

