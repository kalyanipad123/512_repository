function z = solvep(p,v,L,c,W0,W1,W2,beta);

% Globals.
%global c v L beta W0 W1 W2 D0 D1 D2;
global D0 D1 D2;

p2 = p';
v = repmat(v,L,L);
D0 = 1./(1+exp(v-p)+exp(v-p2));
D1 = exp(v-p)./(1+exp(v-p)+exp(v-p2));
D2 = exp(v-p2)./(1+exp(v-p)+exp(v-p2));

z = ones(L,L) - (ones(L,L) - D1)*(p - repmat(c,1,L)) - beta*W1 + beta*D0*W0 + beta*D1*W1 + beta*D2*W2;