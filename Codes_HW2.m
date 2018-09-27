%%%%%%%%%% Question 1**************
function [DA,DB,D0] = demand(vA,vB,pA,pB)
DA = exp(vA - pA)/(1 + exp(vA - pA)+ exp(vB - pB));
DB = exp(vB - pB)/(1 + exp(vA - pA)+ exp(vB - pB));
D0 = 1/(1 + exp(vA - pA)+ exp(vB - pB));
end

[DA DB D0] = demand(2,2,1,1);

%%%%%%%%%% Question 2**************
function [FOCs] = foc(vA,vB,p)
DA = exp(vA - p1)/(1 + exp(vA - p1)+ exp(vB - p2));
DB = exp(vB - p2)/(1 + exp(vA - p1)+ exp(vB - p2));
FOCs = [DA*(1-p(1)) + p(1)*DA^2;
       DB*(1-p(2)) + p(2)*DB^2]
end

handle = @(p) foc(2,2,p);
p_initial = [1;1];
p = broyden(handle,p_initial);

%%%%%%%%%% Question 5**************
clear
vA = 2;
vB = [0:.2:3]';
n = size(vB,1);
final = ones(2,n);
for i = 1:n 
    handle = @(p) foc(vA,vB(i),p)
    p_init = [1;1]
    p = broyden(handle,p_init)
    final(:,i) = p 
end

pA = final(1,:);
pB = final(2,:);
plot (vB,pA,'-.r*');
hold on
plot(vB,pB,':bs')
legend('pA','pB')

%%%%%%%%%% Question 4**************
function [FOC_A,FOC_B] = trial(vA,vB,p1,p2)
DA = exp(vA - p1)/(1 + exp(vA - p1)+ exp(vB - p2));
DB = exp(vB - p2)/(1 + exp(vA - p1)+ exp(vB - p2));
FOC_A = DA*(1-p1) + p1*DA^2;
FOC_B = DB*(1-p2) + p2*DB^2
end

p1 = 1;
p2 = 2;
err = inf;
tol = 1e-10;
while abs(err) > 1e-10
    [FOC_A,FOC_B] = trial(2,2,p1,p2)
    err = max(FOC_A,FOC_B)
    [DA, DB] = demand(2,2,p1,p2)
    p1 = inv(1- DA)
    p2 = inv(1 -DB)
end





    
    


