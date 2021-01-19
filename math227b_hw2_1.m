clear all; close all; clc;
% 1/17/21 MATH227B HW#2 w/professor Qing Nie
%problem 1 - divided difference function
input1=[0 1 2 3 4 5 6 7 8 9];
input2=[0 1 2 3 4 5 6 7 8 9];
div_diff(input1,input2)
function f_x = div_diff(x,y)
    f_x = x+y;
end