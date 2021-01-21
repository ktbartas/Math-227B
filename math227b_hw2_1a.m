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
        a_vals(i)=recur(list,y,x);
    end
    a_values=a_vals;
end