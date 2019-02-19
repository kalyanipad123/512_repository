clear;
global L M rho kappa l v delta beta CRIT lambda n c transprob0 transprob1;

%%Parameters%%

L = 30;
M = 5;
rho = 0.85;
kappa = 10;
l = 15;
v = 10;
delta = 0.03;
beta = 1/1.05;
CRIT = 1e-10; 
lambda = 0.75; 
n = log(rho)./log(2);

%Calculating the cost vector for different possible values of the state.
c = zeros(L,1);
c(1:l-1) = kappa.*[1:l-1].^n;
c(l:L) = (kappa.*l).^n;
prob = zeros(L,1);
for i = 1:L
    prob(i,1) = 1 - (1 - delta).^i;
end

%Calculating the transition matrix when q = 0.
transprob0 = zeros(L,L);
transprob0(1,1) = 1;
for i = 2:L
    transprob0(i,i-1) =  prob(i,1);
    transprob0(i,i) = 1 - prob(i,1);
end

%Calculating the transition matrix when q = 1.
transprob1 = zeros(L,L);
transprob1(L,L) = 1;
for i = 1:L-1
    transprob1(i,i) =  prob(i,1);
    transprob1(i,i+1) = 1 - prob(i,1);
end

