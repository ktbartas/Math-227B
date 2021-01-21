clear all; close all; clc;
% 1/19/21 MATH227B HW#2 w/professor Qing Nie
%problem 2
%csape is cubic spline interpolation function. 
% from https://www.mathworks.com/help/curvefit/csape.html
syms x ;
func_actual= sin(x); % function to approximate
bounds='periodic' ;%type of boundary conditions
a=0. ;%min x-value
b=2*pi ;%max x-value
m=30 ;%max number of points in test data set
p_vals=zeros(m-1,1);
for n=2:m ;%number of values to use to make function

x_input=linspace(a,b,n);
y_input = subs(func_actual,x,x_input);
y_input=double(y_input);
%second error where n is doubled
x_input2=linspace(a,b,n*2);
y_input2 = subs(func_actual,x,x_input2);
y_input2=double(y_input2);

s1 = csape(x_input,y_input,bounds);
s2 = csape(x_input2,y_input2,bounds);
x_plot=a:0.01:b ;

func_act=subs(func_actual,x,x_plot);
difs1 =func_act-ppval(s1,x_plot);
dif1=max(abs(difs1));
double(dif1);
difs2 =func_act-ppval(s2,x_plot);
dif2=max(abs(difs2));
double(dif2);
%error between errorh and errorh/2
divi=dif1/dif2;
p=double(log2(divi));
p_vals(n-1)=p;
end

x_axis=2:m
p_vals
plot(x_axis,p_vals)
xlabel('Number of points in training data (n)') 
ylabel('Order of Accuracy (p)')
qc = arrayfun(@char, func_actual, 'uniform', 0);
B = char(qc);
title(sprintf('%s with %s boundary conditions', B, bounds))