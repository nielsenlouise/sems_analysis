%returns the equilibrium concentration 
%  The steady state equation is 
%   C(inf) = ((S/V) + Ca*I) / (I + k) 


function res = eqC(S,V,Ca,I,K)

    res= (Ca*I)/(I + K);  %steady state concentration
 
 
end