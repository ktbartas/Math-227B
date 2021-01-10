clear all; close all; clc;
% 1/9/21 MATH227B HW#1 w/professor Qing Nie

%problem 1 - machine epsilon
x=1
my_epsilon=0;
for n=0:100
    if x+2^(-n)==x
        my_epsilon=2^-(n-1)
        break
    end
end

%check
matlab_epsilon=eps(x)