function W0 = getW0(Vin, x)
global L M rho kappa l v delta beta CRIT lambda n c transprob0 transprob1;

cont = zeros(L,L);
V = Vin;
cont(1, 1) = V(1, 1);
   
cont(1,L) = V(1, L-1).*transprob0(L,L-1) + V(1,L).*transprob0(L,L);

cont(1, 2:L-1) = V(1,1:L-2)*transprob0(2:L-1,1:L-2) + V(1,2:L-1)*transprob0(2:L-1,2:L-1);

cont(2:L, 1) = transprob0(2:L,1:L-1)*V(1:L-1,1) + transprob0(2:L,2:L)*V(2:L,1);

cont(2:L,2:L) = transprob0(2:L,1:L-1)*[V(1:L-1,2:L)*transprob0(2:L,2:L) + V(1:L-1,1:L-1)*transprob0(2:L,1:L-1)] + transprob0(2:L,2:L)*[V(2:L,2:L)*transprob0(2:L,2:L) + V(2:L,1:L-1)*transprob0(2:L,1:L-1)];

W0 = cont;