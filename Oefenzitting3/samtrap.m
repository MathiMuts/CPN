function integraal = samtrap(f, a, b ,k)
integraal = 0;
h = (b-a)/k;

xj = a;
integraal = integraal + f(a)/2;
integraal = integraal + f(b)/2;

for j = 1:k-1
    xj = xj + h;
    integraal = integraal + f(xj);
end
integraal = h*integraal;

end