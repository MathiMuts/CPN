function S = samtrap2(f,a,b,k)
%SAMTRAP2 Samengestelde trapeziumregel
% Zelfde als samtrap1, alleen moet het mogelijk zijn om de functie f te
% evalueren in een vector
% Voorbeeld voor f, anonieme functie: f = @(x) x.*exp(-x.^2)
% MERK OP: .* en .^ zorgen ervoor dat de operaties elementgewijs gebeuren
h = (b-a)/k;
S = h*sum(f(a+[1:k-1]*h));
S = S + h/2*(f(a)+f(b));

end