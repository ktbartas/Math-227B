clear all; close all; clc;
% 1/18/21 MATH227B HW#2 w/professor Qing Nie
%problem 1d #3
syms x ;
%set boundary conditions
a=-1. ;%min
b=1. ;%max

n=9 ;%number of values to test
func_actual= 1/(1+25*x^2); %actual function
x_input=linspace(a,b,n);
y_input=zeros(size(x_input)); %placeholder
y_input = subs(func_actual,x,x_input);

my_lapoly(x_input,y_input);

%plots
func=my_lapoly(x_input,y_input) %set my lagrange interpolation 
minx=min(x_input); maxx=max(x_input); %set boundary conditions
fplot(func, [minx maxx]) %plot my lagrange interpolation
hold on;
plot(x_input,y_input,'or') % plot data points that I based interpolation off of
fplot(func_actual, [minx maxx]) %plot the real polynomial
xlim([minx maxx]);
title('Problem part D1, Lagrange polynomial interpolation versus actual function')
legend('Lagrange polynomial interpolation function','Training data points','Real function')
hold off;

%calculate error
poly_difs =func_actual-func;
num=300;
k= linspace(a,b,num);
errors= subs(poly_difs,x,k);
max_error=max(errors); %max_error on interval a to b
show_max=double(max_error)

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