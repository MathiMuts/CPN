function time = tijd_linsys( m )
%TIJD_LINSYS - Uitvoeringstijd voor het oplossen van een driehoekig mxm-stelsel.
%
%   Deze routine meet de tijd nodig voor het oplossen van een driehoekig stelsel van 
%   orde m. De routine lost eventueel verschillende stelsels van de zelfde
%   grootte na elkaar op om een nauwkeurige meting te bekomen. Dit aantal
%   wordt automatisch zo gekozen, dat er altijd minimaal 1 seconde gerekend
%   wordt.
%
%   Invoerargument:
%     + m: grootte van het stelsel.
%
%   Uitvoerargument:
%     + time: uitvoeringstijd.
%

% Geschreven door Kurt Lust.
% Aangepast door Niel Van Buggenhout.


A = tril(randn( m )); % benedendriehoeksmatrix
b = randn( m, 1 );

stop = 0;
aantal = 1;

while ~stop
   
   tic; for t1 = 1 : aantal; x = A\b; end; el = toc;
   
   if ( el >= 1 )
      stop = 1; 
   elseif ( el == 0 )
      aantal = aantal * 10;
   else
      aantal = ceil( 1.2 * aantal / el );
   end
   
end

time = el / aantal;
