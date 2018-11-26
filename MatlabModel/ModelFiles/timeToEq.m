%returns a time 
%  The steady state equation is 
%   C(inf) = ((S/V) + Ca*I) / (I + k) 


function res = timeToEq(T,S,V,C,Ca,I,K,dt)

t2Eq = zeros(1,length(I));

 for i = 1:length(I)
    eq = (Ca*I(i))/(I(i) + K);  %steady state concentration
    
    % finds time to steady state by running the normal diff eq
    % stops at .99 of the value of the steady state concentration because
    % it's asymptotic
    
    for j = 2:length(T)
       temp = C(j-1) + dt*( S/V + Ca*I(i) - C(j-1)*I(i) - K*C(j-1));
       if temp<= 0 
          temp = 0;
       end
       if temp >= .99*eq
           t2Eq(i) = T(j);
           break;
       end
       C(j) = temp;
    end
 end
 
 res= t2Eq;
end