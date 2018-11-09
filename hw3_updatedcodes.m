load hw3.mat
%%
beta_init = ones(6,1) %Specifying the initial value

%%Specifying options for fminsearch in questions 1,2 and 4%%
options = optimset('MaxFunEvals',10000,'TolFun',1e-16);   

%%Specifying options for lsqnonlin in Q3%%
options2 = optimoptions(@lsqnonlin,'MaxFunctionEvaluations',10000, 'MaxIterations', 10000, 'TolFun',1e-16,'StepTolerance', 1e-16, 'Algorithm','levenberg-marquardt'); 

%%Question 1%%
tic
[sol1_base,fval,exitflag,output] = fminsearch(@(beta) -sum(-exp(X*beta) + X*beta.*y - log(factorial(y))),beta_init,options)
toc

%%Question 2%%
tic
[sol2_base,fval2,exitflag2,output2] = fminunc(@(beta) -sum(-exp(X*beta) + X*beta.*y - log(factorial(y))),beta_init,options)
toc

%%Question 3%%
tic
[sol3_base] = lsqnonlin(@(beta) y - exp(X*beta),beta_init,[],[],options2)
toc

%%Question 4%%
tic
[sol4_base,fval4,exitflag4,output4] = fminsearch(@(beta) sum((y - exp(X*beta)).^2),beta_init,options)
toc

% all these 4 different methods give very different anser. does that not
% ring any alarm in your mind? they are all approximatign the same process,
% they should not be too much different. 
%%Question 5%%

%%Specifying a 6 X 10 matrix of numbers randomly drawn from [0,10].
r = (10)*rand(6,10); 

x = zeros(1,10);
w = zeros(1,10);
z = zeros(1,10);
a = zeros(1,10);

for i = 1:10
    beta0= r(:,i) %%Taking the i th column of matrix r, which will serve as the initial set of values.
    [sol1,fval,exitflag,output] = fminsearch(@(beta) -sum(-exp(X*beta) + X*beta.*y - log(factorial(y))),beta0) %%Repeating Q1 for beta0
    diff_1 = sol1 - sol1_base; %% Taking the diff between the solution from beta0 as the initial value and the solution from beta_init as the initial value.
    x_i = norm(diff_1); %%Taking the norm of the difference between the two vectors.
    x(1,i) = x_i %% Appending the above norm to the i'th column of x.

    [sol2,fval2,exitflag2,output2] = fminunc(@(beta) -sum(-exp(X*beta) + X*beta.*y - log(factorial(y))),beta0) %% Repeating Q2 for beta0
    diff_2 = sol2 - sol2_base; %% Same reasoning as above
    w_i = norm(diff_2); 
    w(1,i) = w_i %% Appending the above norm to the i'th column of w.
    
    [sol3,exitflag3,output3] = lsqnonlin(@(beta) y - exp(X*beta),beta0,[],[],options2) %%Repeating Q3 for beta0
    diff_3 = sol3 - sol3_base;
    z_i = norm(diff_3);
    z(1,i) = z_i %% Appending the above norm to the i'th column of z.
    
    [sol4,fval4,exitflag4,output4] = fminsearch(@(beta) sum((y - exp(X*beta)).^2),beta0)
    diff_4 = sol4 - sol4_base;
    a_i = norm(diff_4);
    a(1,i) = a_i %% Appending the above norm to the i'th column of a.
end

x_avg = mean(x)
w_avg = mean(w)
z_avg = mean(z)
a_avg = mean(a)

%%Consider matrix x. The element in the first row, first column tells us by
%%how much the new estimated beta vector (under the new set of initial
%%values - say first column of r) is different from the estimated beta vector (when the initial
%%value was as per Q1). Similarly, matrices w,z and a represent the
%%differences between the newly estimated beta vectors and the estimated
%%beta vectors in questions 2,3 and 4.