clear all; close all; clc;
% code from:
% https://www.mathworks.com/matlabcentral/fileexchange/13151-lagrange-interpolator-polynomial

X = [1 2 3 4 5 6 7];  Y = [1 -2 3 -4 5 -6 7];
P = lagrangepoly(X,Y)
xx = -1:.01:9;
plot(xx,polyval(P,xx),X,Y,'or');
xlim([0 8]);
ylim([-7 8]);
lagrangepoly(X,Y)
hold on

input1=[1 2 3 4 5 6 7]; % this is x. 
%x is meant to be a list of numbers 
input2=[1 -2 3 -4 5 -6 7]; % this is y.
func2=my_lapoly(input1,input2)
fplot(func2, [0 8],'LineStyle','--') %plot my lagrange interpolation
legend('Dan Ellis interpolation function','Training data points','My interpolation function')
hold off
function [P,R,S] = lagrangepoly(X,Y,XX)
if size(X,1) > 1;  X = X'; end
if size(Y,1) > 1;  Y = Y'; end
if size(X,1) > 1 || size(Y,1) > 1 || size(X,2) ~= size(Y,2)
  error('both inputs must be equal-length vectors')
end
N = length(X);
pvals = zeros(N,N);
% Calculate the polynomial weights for each order
for i = 1:N
  % the polynomial whose roots are all the values of X except this one
  pp = poly(X( (1:N) ~= i));
  % scale so its value is exactly 1 at this X point (and zero
  % at others, of course)
  pvals(i,:) = pp ./ polyval(pp, X(i));
end
% Each row gives the polynomial that is 1 at the corresponding X 
% point and zero everywhere else, so weighting each row by the 
% desired row and summing (in this case the polycoeffs) gives 
% the final polynomial
P = Y*pvals;
if nargin==3
  % output is YY corresponding to input XX
  YY = polyval(P,XX);
  % assign to output
  P = YY;
end
if nargout > 1
  % Extra return arguments are values where dy/dx is zero
  % Solve for x s.t. dy/dx is zero i.e. roots of derivative polynomial
  % derivative of polynomial P scales each power by its power, downshifts
  R = roots( ((N-1):-1:1) .* P(1:(N-1)) );
  if nargout > 2
    % calculate the actual values at the points of zero derivative
    S = polyval(P,R);
  end
end
end

function funct = my_lapoly(x_input,y)
    x = sym('x');
    mat=size(x_input); % get size of input
    n=max(mat); %get max size of input
    function div_diff = recur(nums,y_in,x_in)
        if length(nums)==1
            div_diff=y_in(nums(1));
        else
            div_diff=(recur(nums(2:end),y_in,x_in)-recur(nums(1:end-1),y_in,x_in))/((x_in(nums(end)))-x_in(nums(1)));
        end
    end
    a_vals=zeros(1,n);
    for i=1:n
        list=1:i;
        a_vals(i)=recur(list,y,x_input);
    end
    a_values=a_vals;
    
    %below is 1b
    
    
    mat1=size(a_values); 
    n1=max(mat1);%get max size of input regardless of dimension
    result=0;
    for i = 1:n1
        j=1;
        multiplier=1 ;
        while j<i
            multiplier=multiplier*(x-x_input(j));
            j=j+1;
        end
        result=result+a_values(i)*multiplier;
    end
    funct=result;
end