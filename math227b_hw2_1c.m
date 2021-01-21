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