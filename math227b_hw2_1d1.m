clear all; close all; clc;
% 1/18/21 MATH227B HW#2 w/professor Qing Nie
%problem 1d #1
syms x ;
%set boundary conditions
a=-1. ;%min
b=1. ;%max

n=3 ;%number of values to test
func_actual= 3*(x^3)+4*(x^2)+2*x+1; %actual function
x_input=linspace(a,b,n);
y_input=zeros(size(x_input)); %placeholder
y_input = subs(func_actual,x,x_input);

my_lapoly(x_input,y_input)

%plots
func=my_lapoly(x_input,y_input); %set my lagrange interpolation 
minx=min(x_input); maxx=max(x_input); %set boundary conditions
fplot(func, [minx maxx]) %plot my lagrange interpolation
hold on;
plot(x_input,y_input,'or') % plot data points that I based interpolation off of
fplot(func_actual, [minx maxx]) %plot the real polynomial
xlim([minx maxx]);
title('Problem part D1, Lagrange polynomial interpolation versus actual function')
hold off;

%calculate error
poly_difs =func_actual-func;
num=300;
k= linspace(a,b,num);
errors= subs(poly_difs,x,k);
max_error=max(errors) %max_error on interval a to b
show_max=double(max_error)
function funct = my_lapoly(x_input,y)
    mat=size(x_input); % get size of input
    n=max(mat); %get max size of input regardless of dimension
    f_x = zeros(n, n); %placeholder zeros matrix
    f_x(:,1) = y'; %the first column of f_x will be the transpose of y 
    %because zeroth divided difference is f[xi]=f(xi)
    for j = 2 : n
        for i = 1 : (n - j + 1)
            f_x(i,j) = (f_x(i + 1, j - 1) - f_x(i, j - 1)) / (x_input(i + j - 1) - x_input(i));
        end
    end
    V = f_x(1,:); % first row only
    a_values=V ;% flip so it is in the order of a0 1st to an last
    
    %below is 1b
    
    syms x;
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