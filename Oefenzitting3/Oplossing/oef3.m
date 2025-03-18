close all
clear all

%%%%%%%%%%%%%%%%%
%% VRAAG 1 & 2 %%
%%%%%%%%%%%%%%%%%

fprintf('\n');
fprintf('\nVRAAG 1 & 2');
fprintf('\n-------');

grootte = (50:10:500)';
fprintf(strcat(['\nMaximale grootte: ', int2str(grootte(end))]))

fprintf('\nBerekening gestart voor grootte ');
tijd = zeros(length(grootte),1);
for i = 1:length(grootte)    
    % Print vooruitgang
    if mod(i, 15) == 0
       fprintf('\n')
    end
    fprintf(strcat([int2str(grootte(i)), ', ']))
    
    % Timing lineair stelsel
    T = [];
    for k = 1:1
        T = [T, tijd_linsys(grootte(i))];
    end
    tijd(i) = median(T);
end


figure(1);clf;
plot(grootte,tijd,'k*');
hold on
xlabel('grootte van het stelsel'); ylabel('tijd (sec)')

fprintf('\nKlaar.\n');

%%%%%%%%%%%%%%%%%
%% VRAAG 3 & 4 %%
%%%%%%%%%%%%%%%%%

P1 = polyfit(grootte, tijd, 1);
P2 = polyfit(grootte, tijd, 2);
P3 = polyfit(grootte, tijd, 3);

tijd1 = polyval(P1,grootte);
tijd2 = polyval(P2,grootte);
tijd3 = polyval(P3,grootte);

plot(grootte,tijd1,'r');
plot(grootte,tijd2,'g');
plot(grootte,tijd3,'b');
legend('gemeten waarden', 'P1', 'P2', 'P3');

variantie1 = sum((tijd-tijd1).^2)/(length(tijd));
variantie2 = sum((tijd-tijd2).^2)/(length(tijd));
variantie3 = sum((tijd-tijd3).^2)/(length(tijd));

fprintf('\nVRAAG 3 & 4: Bepalen van de optimale graad');
fprintf('\n-------');
fprintf('\nvariantie voor graad 1=%e', variantie1);
fprintf('\nvariantie voor graad 2=%e', variantie2);
fprintf('\nvariantie voor graad 3=%e', variantie3);
fprintf('\n\n');


fprintf('\nDUS: deze test toont dat <tijd> goed benaderd kan worden door een');
fprintf('\n     tweedegraads veelterm. Dit bevestigt wat we al wisten, nl. dat');
fprintf('\n     voorwaartse voor een NxN stelsel O(N^2) rekenwerk/tijd vraagt !');
fprintf('\n\n');


% MERK OP: Graad 2 is optimaal omdat het verschil in variantie van graad 2
% naar graad 3 klein is.
%%%%%%%%%%%%%
%% VRAAG 5 %%
%%%%%%%%%%%%%

fprintf('\nVRAAG 5');
fprintf('\n-------');
fprintf('\nUit de vorige vraag onthouden we dat het rekenwerk voor een stelsel met een driehoeksmatrix');
fprintf('\nO(N^2) is. Concreter:');
fprintf('\n    rekenwerk = a0 + a1*N + a2*N^2');
fprintf('\nEr wordt nu gevraagd een ruwe schatting te geven van de rekentijd.');
fprintf('\nHet volstaat dan om enkel naar de dominante term te kijken, en');
fprintf('\nrekenwerk te benaderen door:');
fprintf('\n    rekenwerk ~= a2*N^2');
fprintf('\nMerk op dat deze formule geen onmogelijk resultaat geeft voor kleine');
fprintf('\nstelsels: ');
fprintf('\n    rekenwerk(0) = 0');
fprintf('\nNu moeten we de constante a2 nog bepalen. Daartoe gebruiken we het');
fprintf('\ngegeven dat rekenwerk(1000) = 10');
fprintf('\n   a2*(1e3)^2 = 10  ==>  a2 = 1e-5');
fprintf('\nDus, het rekenwerk om een stelsel van grootte 1e4 op te lossen, bedraagt:');
fprintf('\n   rekenwerk = 1e-5 * (1e4)^2 = 1e3 sec = 16.66 minuten');
fprintf('\n\n');

