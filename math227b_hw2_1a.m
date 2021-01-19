clear all; close all; clc;
% 1/17/21 MATH227B HW#2 w/professor Qing Nie
%problem 1a - divided difference function
input1=[1 2 3 4 5 6 7]; % this is x. 
%x is meant to be a list of numbers 
input2=[1 -2 3 -4 5 -6 7]; % this is y.
%y is meant to be a list of numbers of the same size (dimensions) as x.
div_diff(input1,input2)
function a_values = div_diff(x,y)
    mat=size(x); % get size of input
    n=max(mat); %get max size of input regardless of dimension
    f_x = zeros(n, n); %placeholder zeros matrix
    f_x(:,1) = y'; %the first column of f_x will be the transpose of y 
    %because zeroth divided difference is f[xi]=f(xi)
    for j = 2 : n
        for i = 1 : (n - j + 1)
            f_x(i,j) = (f_x(i + 1, j - 1) - f_x(i, j - 1)) / (x(i + j - 1) - x(i));
        end
    end
    V = f_x(1,:); % first row only
    a_values=V ;% flip so it is in the order of a0 1st to an last
end