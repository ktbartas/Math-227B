clear all; close all; clc;
% 1/18/21 MATH227B HW#2 w/professor Qing Nie
%problem 1c - combine 1a and 1b into 1 module

% test data
input1=[1 2 3 4 5 6 7]; % this is x. 
%x is meant to be a list of numbers 
input2=[1 -2 3 -4 5 -6 7]; % this is y.
%y is meant to be a list of numbers of the same size (dimensions) as x.
my_lapoly(input1,input2)

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