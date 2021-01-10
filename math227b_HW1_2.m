clear all; close all; clc;
% 1/9/21 MATH227B HW#1 w/professor Qing Nie

%Number 2 - Maclaurin series 
syms x
f = -1+sin(x)/x;
T7 = taylor(f, x, 'Order', 7)
T8 = taylor(f, x, 'Order', 8)

%useless 9
T9 = taylor(f, x, 'Order', 9); %oh odds are same bc every other term is zero
%piece of trash 9 - ignore it same as 10

T10 = taylor(f, x, 'Order', 10);
T12 = taylor(f, x, 'Order', 12);

T20 = taylor(f, x, 'Order', 20)

rel_err_4terms = 0;
for n= 0:0.1:1
  toot = abs(n^4/120-n^2/6-(-1+sin(n)/n))/abs(-1+sin(n)/n);
  if toot>rel_err_4terms
      rel_err_4terms=toot;
  end
  n
  toot
end
rel_err_4terms

rel_err_8terms = 0;
for n= 0:0.0001:1
  toot = abs(-n^6/5040+n^4/120-n^2/6-(-1+sin(n)/n))/abs(-1+sin(n)/n);
  if toot>rel_err_8terms
      rel_err_8terms=toot;
  end
end
rel_err_8terms

rel_err_10terms = 0;
for n= 0:0.0001:1
  toot = abs(n^8/362880 -n^6/5040 +n^4/120 -n^2/6-(-1+sin(n)/n))/abs(-1+sin(n)/n);
  if toot>rel_err_10terms
      rel_err_10terms=toot;
  end
end
rel_err_10terms

rel_err_12terms = 0;
for n= 0:0.0001:1
  toot = abs(- n^10/39916800. + n^8/362880. - n^6/5040 + n^4/120 - n^2/6-(-1+sin(n)/n))/abs(-1+sin(n)/n);
  if toot>rel_err_12terms
      rel_err_12terms=toot;
  end
end
rel_err_12terms
%starting to get INCORRECT errors......

rel_err_14terms = 0;
for n= 0:.0001:1
  hoot = abs(n^12/6227020800-n^10/39916800+n^8/362880-n^6/5040 + n^4/120 - n^2/6-(-1+sin(n)/n))/abs(-1+sin(n)/n);
  if hoot>rel_err_14terms
      rel_err_14terms=hoot;
  end
end
rel_err_14terms
%ERROR LEVELS OUT WHEN IT SHOULD NOT 
%MATLAB ISN'T GOOD ENOUGH
rel_err_20terms = 0;
for n= 0:.0001:1
  poot = abs(- n^18./121645100408832000.0+n^16/355687428096000.-n^14/1307674368000+n^12/6227020800-n^10/39916800+n^8/362880-n^6/5040 + n^4/120 - n^2/6-(-1+sin(n)/n))/abs(-1+sin(n)/n);
  if poot>rel_err_20terms
      rel_err_20terms=poot;
  end
end
rel_err_20terms

eps(1)