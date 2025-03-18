% Dit scriptje bevat enkele kwalitatieve testen om na te gaan of samtrap
% correct geimplementeerd is.
close all
clear all

succes = 0;
total = 0;



%% Test 1
% Deze test kijkt na of je invoerargument correct zijn gedefinieerd.
f = @(x) x; % integrand
a = 0; 
b = 1; % a,b vormen de grenzen voor integratie [a,b]
k = 1; % aantal intervallen

try 
    samtrap(f,a,b,k);
    disp('Test 1 geslaagd')
    succes = succes + 1;
catch exc
    disp('--------------------------------------')
    disp('Test 1 gefaald')
    if strcmp(exc.identifier, 'MATLAB:UndefinedFunction') && contains(exc.message, 'samtrap')
	   disp('Hint: Ofwel is het bestand samtrap.m niet te vinden in het huidige pad (meest waarschijnlijk), ofwel kan de functie samtrap niet worden opgeroepen met vier argumenten zoals gevraagd.')
    else
	   disp('Hint: De functie werd gevonden maar de volgende foutmelding werd gegenereerd bij het oproepen van samtrap:')
	   disp('======')
	   disp(getReport(exc))
	   disp('======')
    end
   disp('--------------------------------------')
end
total = total + 1;
    
%% Test 2
% Deze test kijkt na of je uitvoerargument correct gedefinieerd is.
f = @(x) x; % integrand
a = 0; 
b = 1; % a,b vormen de grenzen voor integratie [a,b]
k = 1; % aantal intervallen

try
    fp  = samtrap(f,a,b,k);
    if isnumeric(fp) && length(fp)==1
        disp('Test 2 geslaagd')
        succes = succes + 1;
    else
        error
    end
    
catch
    disp('--------------------------------------')
    disp('Test 2 gefaald')
    disp('Hint: Jouw uitvoerargument is geen getal.')
    disp('--------------------------------------')
end
total = total + 1;

%% Test 3a (eerste en laatste term -> k = 1) 
% De trapeziumregel is correct voor veeltermen van eerste graad.
% Ga dus na of de absolute fout klein is wanneer de integrand de vorm c*x+d
% heeft.
c = 5;
d = 3;
f = @(x) c*x+d; % Je kan hier ook andere veeltermen proberen van de vorm c*x+d
a = 0; 
b = 1; % a,b vormen de grenzen voor integratie [a,b]
k = 1;

try
    benadering = samtrap(f,a,b,k);
    exact = (c/2*b^2+d*b)-(c/2*a^2+d*a);
    
    absolute_fout = abs(exact - benadering); % absolute fout moet klein zijn (i.e., rond 10^-15)
    
    % In deze if-test wordt een bovengrens gebruikt voor de absolute fout.
    % Deze bovengrens gaat echter wel uit van redelijke waardes vor c,d,a,b,k.
    % Dus als je deze waarden verandert naar zeer grote of kleine waarden, dan
    % kunnen numerieke fouten ertoe leiden dat deze test faalt.
    if absolute_fout > eps*100*10^max([1,log10(c),log10(d)])
        disp('--------------------------------------')
        disp('Test 3a gefaald')
        disp('Hint: kijk na of je de eerste en laatste term hebt gedeeld door 2.')
        disp('--------------------------------------')
    else
        disp('Test 3a geslaagd')
        succes = succes + 1;
    end
catch
    
end
total = total + 1;

%% Test 3b (tussenliggende termen -> k>1)
% Zelfde als Test 1a, maar voor de for-lus/ while-lus
k = 2;


try
    benadering = samtrap(f,a,b,k);
    exact = (c/2*b^2+d*b)-(c/2*a^2+d*a);
    absolute_fout = abs(exact - benadering); % absolute fout moet klein zijn (i.e., rond 10^-15)
    
    % In deze if-test wordt een bovengrens gebruikt voor de absolute fout.
    % Deze bovengrens gaat echter wel uit van redelijke waardes vor c,d,a,b,k.
    % Dus als je deze waarden verandert naar zeer grote of kleine waarden, dan
    % kunnen numerieke fouten ertoe leiden dat deze test faalt.
    if absolute_fout > eps*100*10^max([1,log10(c),log10(d)])
        disp('-------------------------------------')
        disp('Test 3b gefaald')
        disp('Hint 1: Kijk na of je de term h niet bent vergeten/correct berekend.')
        disp('Hint 2: Kijk je for-lus/while-lus na.')
        disp('--------------------------------------')
    else
        disp('Test 3b geslaagd')
        succes = succes + 1;
    end
catch
end
total = total + 1;

%% Verslaggeving
disp("geslaagde testen: "+num2str(succes)+"/"+num2str(total))
