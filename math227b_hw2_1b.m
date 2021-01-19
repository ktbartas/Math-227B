clear all; close all; clc;
% 1/17/21 MATH227B HW#2 w/professor Qing Nie
%problem 1b - nested multiplication to make polynomial function
input1=[1.0000   -3.0000    4.0000   -3.3333    2.0000   -0.9333    0.3556] ;%a values
input2=[1 2 3 4 5 6 7] ;%input should be a list of numbers (x)
nest_multi(input1,input2)
function funct = nest_multi(input_a,input_x)
    syms x
    mat=size(input_a); 
    n=max(mat);%get max size of input regardless of dimension
    result=0;
    for i = 1:n
        j=1;
        multiplier=1 ;
        while j<i
            multiplier=multiplier*(x-input_x(j));
            j=j+1;
        end
        result=result+input_a(i)*multiplier;
    end
    funct=result;
end