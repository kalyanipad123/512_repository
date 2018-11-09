function r = newt(f,a,b,n)
h = (b - a) / n;
r = f(a)/2;
x = a + h;
for i = 1 : n-1
    r = r + f(x);
    x = x + h;
end;
r = r + f(b)/2;
r = r * h;
end