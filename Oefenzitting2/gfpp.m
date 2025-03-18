function A = gfpp(T, c)
%GFPP - Matrix met maximale groeifactor rho voor Gauss eliminatie met rijpivotering.
%
%   GFPP(T) is een NxN-matrix waarvoor de groeifactor rho voor Gauss 
%   eliminatie met rijpivotering maximaal is, d.i., rho = 2^(N-1).
%   T is een willekeurige niet-singuliere bovendriehoeksmatrix van
%   orde N-1. 
%   GFPP(T, C) zorgt ervoor dat alle vermenigvuldigers C zijn (0 <= C <= 1)
%   en resulteert in een groeifactor rho = (1+C)^(N-1).
%   GFPP(N,C) (een speciaal geval) is hetzelfde als GFPP(EYE(N-1), C).
%   Dit is het bekende voorbeeld van Wilkinson.
%
%   Genomen uit de test matrix toolbox (N. Higham.)
%
%   Referentie:
%     N.J. Higham and D.J. Higham, Large growth factors in
%     Gaussian elimination with pivoting, SIAM J. Matrix Analysis and
%     Appl., 10 (1989), pp. 155-164.

%2345678901234567890123456789012345678901234567890123456789012345678901234567890

if norm(T-triu(T),1) | any(~diag(T))
   error('First argument must be a nonsingular upper triangular matrix.')
end

if nargin == 1, c = 1; end

if c < 0 | c > 1
   error('Second parameter must be a scalar between 0 and 1 inclusive.')
end

[m, m] = size(T);
if m == 1    % Handle the special case T = scalar
   n = T;
   m = n-1;
   T = eye(n-1);
else
   n = m+1;
end

d = 1+c;
L =  eye(n) - c*tril(ones(n), -1);
U = [T  (d.^[0:n-2])'; zeros(1,m) d^(n-1)];
A = L*U;
theta = max(abs(A(:)));
A(:,n) = (theta/norm(A(:,n),inf)) * A(:,n);
