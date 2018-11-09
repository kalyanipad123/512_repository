%%%Question 3%%%%%
rng default
p=haltonset(1);
x0=net(p,1000);    %%%%Generating quasi-random numbers for integration.
n = size(x0);
y = [];
%f = [];
for i = 1:n
    y(i,1) = (sqrt(1 - x0(i,1).^2)).*4;     %%%%%Evaluating the function and appending each value to the empty y array.
    %f(i,1) = y.*4;
end

q3 = sum(y)./1000   %%%%%%Analog of the sample average.

%%%%%Question 4%%%%%
q4=newt(@(x) (sqrt(1 - x.^2)).*4,0,1,1000);

%%%%%Question 1%%%%%
rng default
p=haltonset(2);
x0=net(p,1000);         %%%%%Generating quasi-random numbers.
a = [x0(:,1) x0(:,2)];
d = [];
for i = 1:1000
    b_i = x0(i,1).^2 + x0(i,2).^2;     %%%%%Evaluating the term inside the indicator function for each pair of values. If the term yields value less than 1, d takes value 1, otherwise 0.
    if b_i<=1
        d(1,i) = 1;
    else
        d(1,i) = 0;
    end
end

q1 = sum(d)/1000 %%%Area of the quarter circle




