function [L, U, P, Q, rho] = gevp(A)
%GEVP - Gaussian eliminatie met volledige pivotering.
%
%   [L, U, P, Q, RHO] = GEVP(A) berekent de factorisatie P*A*Q = L*U,
%   waarbij L een benedendriehoeksmatrix is met enen op de hoofddiagonaal.
%   U is een bovendriehoeksmatirx en P en Q zijn twee permutatiematrices.
%   RHO is de groeifactor.
%   Zonder uitvoerargumenten of met 1 uitvoerargument geeft GEVP(A)
%   de gereduceerde matrix van het eliminatieproces met zowel L (de
%   elementen onder de hoofddiagonaal) als U (alle elementen op en boven
%   de hoofdiagonaal.) De informatie over de permutaties gaat hierbij 
%   verloren.
%
%   Genomen uit de test matrix toolbox (N. Higham.)

%2345678901234567890123456789012345678901234567890123456789012345678901234567890

[n, n] = size(A);
pp = 1:n; qq = 1:n;
if nargout == 5
   maxA = norm(A(:), inf);
   rho = maxA;
end

for k = 1:n-1

    % Find largest element in remaining square submatrix.
    % Note: when tie for max, no guarantee which element is chosen.
    [colmaxima, rowindices] = max( abs(A(k:n, k:n)) );
    [biggest, colindex] = max(colmaxima);
    row = rowindices(colindex)+k-1; col = colindex+k-1;

    % Permute largest element into pivot position.
    A( [k, row], : ) = A( [row, k], : );
    A( :, [k, col] ) = A( :, [col, k] );
    pp( [k, row] ) = pp( [row, k] ); qq( [k, col] ) = qq( [col, k] );

    if A(k,k) == 0
      break
    end

    A(k+1:n,k) = A(k+1:n,k)/A(k,k);          % Multipliers.

    % Elimination
    i = k+1:n;
    A(i,i) = A(i,i) - A(i,k) * A(k,i);
    if nargout == 5, rho = max( rho, max(max(abs(A(i,i)))) ); end

end

if nargout <= 1
   L = A;
   return
end

L = tril(A,-1) + eye(n);
U = triu(A);

if nargout >= 3, P = eye(n); P = P(pp,:); end
if nargout >= 4, Q = eye(n); Q = Q(:,qq); end
if nargout == 5, rho = rho/maxA; end
