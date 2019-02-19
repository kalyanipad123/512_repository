function W2 = getW2(Vin, x)
global L M rho kappa l v delta beta CRIT lambda n c transprob0 transprob1;

cont = zeros(L,L);
V = Vin;
cont(1,1:L-1) = V(1,1:L-1)*transprob1(1:L-1,1:L-1) + V(1,2:L)*transprob1(1:L-1,2:L);

cont(1,L) = V(1,L);

cont(2:L,L) = transprob0(2:L,2:L)*V(2:L,L) + transprob0(2:L,1:L-1)*V(1:L-1,L);

cont(2:L,1:L-1) = transprob0(2:L,2:L)*[V(2:L,1:L-1)*transprob1(1:L-1,1:L-1) + V(2:L,2:L)*transprob1(1:L-1,2:L)] + transprob0(2:L,1:L-1)*[V(1:L-1,1:L-1)*transprob1(1:L-1,1:L-1) + V(1:L-1,2:L)*transprob1(1:L-1,2:L)];

W2 = cont;