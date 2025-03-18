function [L, U, rho] = gezp(A)
%GEZP - Gaussian eliminatie zonder pivotering.
%
%   [L, U, RHO] = GEZP(A) berekent de factorisatie A = L*U, waarbij L
%   een benedendriehoeksmatrix is met enen op de diagonaal en waarbij U
%   een bovendriehoeksmatrix is. RHO is de groeifactor.
%   Zonder uitvoerargumenten of met 1 uitvoerargument geeft GEZP(A)
%   de gereduceerde matrix van het eliminatieproces met zowel L (de
%   elementen onder de hoofddiagonaal) als U (alle elementen op en boven
%   de hoofdiagonaal.)
%
%   Genomen uit de test matrix toolbox (N. Higham.)

%2345678901234567890123456789012345678901234567890123456789012345678901234567890

[n, n] = size(A);
if nargout == 3
   maxA = norm(A(:), inf);
   rho = maxA;
end

for k = 1:n-1

    if A(k,k) == 0
      error('Elimination breaks down with zero pivot.  Quitting...')
    end

    A(k+1:n,k) = A(k+1:n,k)/A(k,k);          % Multipliers.

    % Elimination
    i = k+1:n;
    A(i,i) = A(i,i) - A(i,k) * A(k,i);
    if nargout == 3, rho = max( rho, max(max(abs(A(i,i)))) ); end

end

if nargout <= 1
   L = A;
   return
end

L = tril(A,-1) + eye(n);
U = triu(A);
if nargout == 3, rho = rho/maxA; end
