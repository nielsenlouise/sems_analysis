function res = CvT(T,S,V,C,Ca,I,K,dt)    
    
    %run the equation loop
    for i = 2:length(T)
       temp = C(i-1) + dt*( S/V + Ca*I - C(i-1)*I - K*C(i-1));
       if temp<= 0 
          temp = 0;
       end
       C(i) = temp;
    end
    
    res = C;
    
end