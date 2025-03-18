function integraal = samtrap1(f,a,b,k)
%SAMTRAP1 Samengestelde trapeziumregel
% De samengestelde trapeziumregel, zoals gegeven in de opgave
% INPUT:
%       f = functie, moet evalueerbaar zijn in een gegeven punt
% Voorbeeld voor f, anonieme functie: f = @(x) x*exp(-x^2)
%       a,b = bepalen het interval waarover we integreren, namelijk [a,b]
%       k = aantal deelintervallen

h = (b-a)/k; % Lengte van elk deelinterval
integraal = h/2*(f(a)+f(b));
for j = 1:k-1
    integraal = integraal + h*f(a+j*h);
end
end
