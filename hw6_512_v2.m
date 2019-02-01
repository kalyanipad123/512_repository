% Divide sections by douible percent! I showed you multiple times how
clear all;
%% %%%%%Question 2%%%%%
[prob,grid,invdist]=tauchen(21,0.5,0.5,0.1); %mu = 0.5 because of the intercept.

%%%%%%%Question 3%%%%%
%%%Value Function Iteration%%%
delta = 0.95;
rho = 0.5;
sigma_u = 0.1;
p = grid';
nprice = length(p); 

VF = [];
policy = [];

for K = 1:100 %initial stock of lumber
    control_grid = 0:1:K; %%Interpretation: choosing how much to leave for the future. Has to be less than or equal to K.
    profit = zeros(nprice,length(control_grid));
    for i = 1:nprice
        for j = 1:length(control_grid)
            profit(i,j) = p(i,1)*[K - control_grid(1,j)] - 0.2*(K - control_grid(1,j)).^(1.5); %%Profit = Revenue - cost, where we calculate price for each price and for each potential value of the control variable.
        end
    end
    V = zeros(nprice,length(control_grid)); %%initial guess of the value function.
    for iter = 1:1e6
        r = profit + delta*prob*V;
        V_new = max(r'); %%maximum for each p, across all potential values of the control variable. 
        V_new_update = repmat(V_new',1,length(control_grid)); 
%         this is not the right update proceedure. take a look at the
%         answer key.
        if (abs(V-V_new_update))>1e-6
            V = V_new_update;
        else
            disp('converged')
            break
        end
    end
    [Vt,decision] = max(r'); %%This yields the value function and policy function.
    VF = [VF,Vt'];
    policy = [policy,decision'];
end

K = 1:100;
plot(K,VF);
ylabel('Optimal value');xlabel('Initial stock of lumber');
% the result is wrong since you miscoded the update, all the rest is also
% wrong

%% %%%%%Extacting the VF for p = 0.9,1 and 1.1%%%%%%
index = zeros(nprice,1);
for f = 1:nprice
   if p(f,1)<= 0.9 & p(f+1,1)> 0.9 %%Looking at the appropriate grid points within which p = 0.9 falls.
       index(f,1)= [1];
   elseif p(f,1)<= 1.1 & p(f+1,1)> 1.1 %%Looking at the appropriate grid points within which p = 1.1 falls.
       index(f,1)= [1];
   elseif p(f,1)<= 1 & p(f+1,1)> 1 %%Looking at the appropriate grid points within which p = 1 falls.
       index(f,1)= [1];
   else
       index(f,1)= [0];
   end
end
index = find(index); %%Row numbers in which p=0.9,p=1,p=1.1

p1 = VF(index(1,1),:); %VF for p=0.9 across all possible values of the control variable.
p2 = VF(index(2,1),:); %VF for p=1 across all possible values of the control variable.
p3 = VF(index(3,1),:); %VF for p=1.1 across all possible values of the control variable.
plot(K,p1);
hold on
plot(K,p2);
hold on
plot(K,p3);
legend('p=0.9','p=1','p=1.1');ylabel('Optimal value');xlabel('Initial stock of lumber');
hold off

%% %%%%%%%Question 4%%%%%%%%
VF2 = [];
policy2 = [];
for K = 1:1:max(max(policy)) %initial stock of lumber
    control_grid = 0:1:K; %%Interpretation: choosing how much to leave for the future. Has to be less than or equal to K.
    profit2 = zeros(nprice,length(control_grid));
    for i = 1:nprice
        for j = 1:length(control_grid)
            profit2(i,j) = delta*prob(i,:)*[p.*[repmat(K - control_grid(1,j),nprice,1)] - 0.2*repmat((K - control_grid(1,j)).^(1.5),nprice,1)]; %%Profit function here represents the discounted expected value of profits in period (t+1), where expectation is calculated from period t.
        end
    end
    V = zeros(nprice,length(control_grid)); %%initial guess
    for iter = 1:1e6
        r = profit2 + delta*prob*V;
        V_new = max(r');
        V_new_update = repmat(V_new',1,length(control_grid)); 
        if (abs(V-V_new_update))>1e-6
            V = V_new_update;
        else
            disp('converged')
            break
        end
    end
    [Vt2,decision2] = max(r');
    VF2 = [VF2,Vt2'];
    policy2 = [policy2,decision2'];
end

plot(p,policy2); ylabel('Stock of timber in period t+2'); xlabel('Price in period t');

%% %%%%%%%%%%Question 6%%%%%%%%%%%%%
clear all;
%Repeating Q2 for Q6%
[prob,grid,invdist]=tauchen(5,0.5,0.5,0.1); %mu = 0.5 because of the intercept.

%Repeating Q3 for Q6%
%%%VFI%%%
delta = 0.95;
rho = 0.5;
sigma_u = 0.1;
p = grid';
nprice = length(p); 

VF = [];
policy = [];

for K = 1:100 %initial stock of lumber
    control_grid = 0:1:K; %%Interpretation: choosing how much to leave for the future. Has to be less than or equal to K.
    profit = zeros(nprice,length(control_grid));
    for i = 1:nprice
        for j = 1:length(control_grid)
            profit(i,j) = p(i,1)*[K - control_grid(1,j)] - 0.2*(K - control_grid(1,j)).^(1.5); %%Profit = Revenue - cost, where we calculate price for each price and for each potential value of the control variable.
        end
    end
    V = zeros(nprice,length(control_grid)); %%initial guess of the value function.
    for iter = 1:1e6
        r = profit + delta*prob*V;
        V_new = max(r'); %%maximum for each p, across all potential values of the control variable. 
        V_new_update = repmat(V_new',1,length(control_grid)); 
        if (abs(V-V_new_update))>1e-6
            V = V_new_update;
        else
            disp('converged')
            break
        end
    end
    [Vt,decision] = max(r'); %%This yields the value function and policy function.
    VF = [VF,Vt'];
    policy = [policy,decision'];
end

K = 1:100;
plot(K,VF);
ylabel('Optimal value');xlabel('Initial stock of lumber');

%VF for p = 0.9,1 and 1.1%
index = zeros(nprice,1);
for f = 1:nprice
   if p(f,1)<= 0.9 & p(f+1,1)> 0.9 %%Looking at the appropriate grid points within which p = 0.9 falls.
       index(f,1)= [1];
   elseif p(f,1)<= 1.1 & p(f+1,1)> 1.1 %%Looking at the appropriate grid points within which p = 1.1 falls.
       index(f,1)= [1];
   elseif p(f,1)<= 1 & p(f+1,1)> 1 %%Looking at the appropriate grid points within which p = 1 falls.
       index(f,1)= [1];
   else
       index(f,1)= [0];
   end
end
index = find(index); %%Row numbers in which p=0.9,p=1,p=1.1

p1 = VF(index(1,1),:); %VF for p=0.9 across all possible values of the control variable.
p2 = VF(index(2,1),:); %VF for p=1 across all possible values of the control variable.
%p3 = VF(index(3,1),:); %VF for p=1.1 across all possible values of the control variable.
plot(K,p1);
hold on
plot(K,p2);
%hold on
%plot(K,p3);
legend('p=0.9','p=1 & p=1.1');ylabel('Optimal value');xlabel('Initial stock of lumber');
hold off

%Repeating Q4 for Q6%
VF2 = [];
policy2 = [];
for K = 1:1:max(max(policy)) %initial stock of lumber
    control_grid = 0:1:K; %%Interpretation: choosing how much to leave for the future. Has to be less than or equal to K.
    profit2 = zeros(nprice,length(control_grid));
    for i = 1:nprice
        for j = 1:length(control_grid)
            profit2(i,j) = delta*prob(i,:)*[p.*[repmat(K - control_grid(1,j),nprice,1)] - 0.2*repmat((K - control_grid(1,j)).^(1.5),nprice,1)]; %%Profit function here represents the discounted expected value of profits in period (t+1), where expectation is calculated from period t.
        end
    end
    V = zeros(nprice,length(control_grid)); %%initial guess
    for iter = 1:1e6
        r = profit2 + delta*prob*V;
        V_new = max(r');
        V_new_update = repmat(V_new',1,length(control_grid)); 
        if (abs(V-V_new_update))>1e-6
            V = V_new_update;
        else
            disp('converged')
            break
        end
    end
    [Vt2,decision2] = max(r');
    VF2 = [VF2,Vt2'];
    policy2 = [policy2,decision2'];
end

plot(p,policy2);
