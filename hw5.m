load('hw5.mat');
X = data.X;
Y = data.Y;
Z = data.Z;
[nodes, prob] = qnwnorm(20, 0.1, 1); %%20 is the number of nodes, 0.1 is beta_0 and 1 is sigma_beta.\\
beta = repmat(nodes,1,100); %%Transforms into a k*n matrix, where k is number of nodes.\\
f=ones(20, 100);%Initial values.
value=ones(20, 100);% Initial values.

for i=1:20
   f(i, :)=ind_ll(X,Y,beta(i,:));%% To facilitate term by term multiplication as defined in the function ind_ll.m\\
   value(i, :)=f(i, :).*prob(i, 1);
end

expec=sum(value);



