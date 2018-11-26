%  returns the K value for a particular C/Ca and I 
%  The steady state equation is 
%   C(inf) = ((S/V) + Ca*I) / (I + k) 


function res = eqK(Cratio,I)

    res = (1/Cratio)*I - I;  %K
 
end