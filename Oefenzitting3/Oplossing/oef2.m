%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Oplossing van oefenzitting 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
exact = (1-exp(-1))/2; % exacte oplossing
integrand = @(x) x.*exp(-x.^2); % definitie integrand met anonieme functie
maxn = 5;
for n = 1:maxn
    k = 10^n;
%    y(n) = samtrap(@integrand,0,1,k); % oproep m.b.v function handle
%    naar integrand geimplementeerd in het bestand integrand.m    
    y(n) = samtrap(integrand,0,1,k) % oproep m.b.v anonieme functie
end

    
relfout = abs(exact-y)/abs(exact) % relatieve fouten

figure(1);clf;
loglog(10.^(1:maxn),relfout,'*-'); % plot met logaritmische y-schaal
xlabel('k = 10^n')
ylabel('relatieve fout t.o.v. $\frac{1}{2}(1 + e^{-1})$', 'Interpreter', 'latex')
title('Numerieke berekening van $\int_0^1 xe^{-x^2} \mathrm{d}x$', 'Interpreter', 'latex')

% Afleiding orde van de fout: 
% h is evenredig met 1/k. Als de orde O(h^2) is, is de relatieve fout
%   rel_fout = O(h^2) = O(k^{-2}) voor k groot (of h klein)
% Volgens de definitie van O-notatie
%   rel_fout <= Ak^{-2} voor een zekere constante A als k groot genoeg.
% Dus
% log(rel_fout) <= -2 log k + log(A) = -2 n + log(A)
% Als we de relatieve fout uitzetten in functie van n voor een
% methode van O(h^2) = O(k^{-2}), is de relatieve fout begrensd door een
% rechte met richtingscoefficient -2, en dit voor voldoende grote n.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%
%% EXTRA %%
%%%%%%%%%%%

% OPGELET: in MATLAB is log(...) de NATUURLIJKE logaritme, 
%          niet de 10-log !!!

figure(2);clf;
for i = 1:100
    k = 10*i;
    x(i) = k; 
    y(i) = samtrap(integrand,0,1,k); % oproep m.b.v anonieme functie
end
relfout= abs(exact-y)/abs(exact); % relatieve fouten
semilogy(x,relfout,'k'); % plot met logaritmische schaal
hold on;

P1 = polyfit(x,log10(relfout),1); % Bereken coefficienten van veelterm p(n) zodat relfout(n) = 10^(p(n))
semilogy(x,10.^(polyval(P1,x)),'r');

P2 = polyfit(x,log10(relfout),2);
semilogy(x,10.^(polyval(P2,x)),'g');

P3 = polyfit(x,log10(relfout),3);
semilogy(x,10.^(polyval(P3,x)),'c');

legend('fout', 'P1', 'P2', 'P3');

%%%%%%%%%%%%%%%%%
%% WAT MERK JE %%
%%%%%%%%%%%%%%%%%

% De grafieken lijken helemaal niet op veeltermen. Dat is geen fout: in een
% logaritmische grafiek zien veeltermen er immers helemaal anders uit dan in
% een gewone grafiek.

% Probeer zelf eens de benaderende veeltermen te plotten in
% een niet-logaritmische grafiek (via plot(x,relfout)). Naarmate de fout kleiner wordt,
% komt de grafiek nu meer en meer horizontaal te liggen. Visueel lijkt het 
% alsof de fout niet meer kleiner wordt, alhoewel ze nog steeds gereduceerd
% wordt als O(h^2). Een logaritmische figuur is hier dus visueel veel duidelijker !
figure(3);clf;
plot(x,relfout,'k');
hold on;
plot(x,10.^(polyval(P1,x)),'r');
plot(x,10.^(polyval(P2,x)),'g');
plot(x,10.^(polyval(P3,x)),'c');

legend('fout', 'P1', 'P2', 'P3');

%%%%%%%%%%%%%%%%%
%% WAT MERK JE %%
%%%%%%%%%%%%%%%%%

% Het oscillerend gedrag van de kleinste kwadratenveeltermen is hier
% bijzonder storend ! Immers, we verwachten dat de fout steeds kleiner is
% voor een kleinere h (grotere n), en door de oscillatie van de veeltermen
% lijkt het alsof dat niet het geval is ...
% DUS: een kleinste kwadratenbenadering is hier GEEN GOEDE KEUZE
