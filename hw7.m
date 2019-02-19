clear;
tic;
parm_q7; %%% Extracting the model parameters.

V0 = 5*ones(L,L); %%Initial guesses
x0 = 10*ones(L,L);
epsilon = 1e-1; %%Tolerance
% this is a really bad stopping tolerance. Even with this bad tolerance I
% could not have estimated on my computer within 10 minutes. Solver keep
% stopping prematurely, meaning it is not really solving the problem. 
iter = 1; %% Iteration count
%check = 1;
for iter = 1:1e4
    W0 = getW0(V0,x0); %%%Calculating the W matrices as in the notes.
    W1 = getW1(V0,x0);
    W2 = getW2(V0,x0);

    fun = @(p) solvep(p,v,L,c,W0,W1,W2,beta);
    [p_star,fval] = fsolve(fun, ones(L,L)*10); 
    p2 = x0';
    V_next = (exp(v-p_star)./(1+exp(v-p_star)+exp(v-p2))).*(p_star - repmat(c,1,L)) + beta*(1./(1+exp(v-p_star)+exp(v-p2))).*W0 + beta*(exp(v-p_star)./(1+exp(v-p_star)+exp(v-p2))).*W1 + beta*(exp(v-p2)./(1+exp(v-p_star)+exp(v-p2))).*W2;
    check = max( max(max(abs((V_next-V0)./V0))),  max(max(abs((p_star-x0)./x0))));
    if check < epsilon
        break;
    else
        V0 = lambda * V_next + (1-lambda)*V0;
        x0 = lambda * p_star + (1-lambda)*x0;
        iter = iter+1;
    end
end

elapsed = toc./60;
disp(sprintf('Elapsed time: %12.4f minutes', elapsed));

%figure(1);
%mesh(V0);
%title('Value Function');

