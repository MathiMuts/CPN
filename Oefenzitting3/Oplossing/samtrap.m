function integraal = samtrap(f,a,b,k)
%% Samtrap benadert de bepaalde integraal met integrand f en grenzen a,b dmv de trapeziumregel met k deelintervallen
% Samtrap benadert de bepaalde integraal met integrand f over het interval
% [a,b] met de trapeziumregel in k deelintervallen. Deze k deelintervallen
% hebben gelijke lengte h = (b-a)/k, zodat een deelinterval gelijk is aan
% [x_{j},x_{j+1}], met x_{j} = a + j*h, j=0,...,k-1
% INPUT:
%       f = integrand, moet meegegeven worden met een handle, zie opgave
%       a,b = interval waarover integraal word genomen, i.e., [a,b]
%       k = aantal deelintervallen voor de trapeziumregel, dit bepaalt h
% OUTPUT:
%       integraal = benadering van de bepaalde integraal bekomen met
%       trapeziumregel.
integraal = 0;
h = (b-a)/k;

xj = a;
integraal = integraal + f(a)/2;
for j = 1:k-1
    xj = xj + h;
    integraal = integraal + f(xj);
end
integraal = integraal + f(b)/2;
integraal = h*integraal;
end

