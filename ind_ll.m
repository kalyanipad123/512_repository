function [ind_ll] = ind_ll(X,Y,beta_grid);
F = @(e) (1 + exp(-e))^(-1);
beta = repmat(beta_grid,20,1);
k = ones(20,100);
ind_ll = prod(F(beta.*X).^(Y)).*((1 - F(beta.*X)).^(k - Y)); 
% You never compute likelihood function, that will cause overflow problem.
% use log likelihood always.
end