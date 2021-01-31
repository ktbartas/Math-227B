clear all; close all; clc;
% 1/30/21 MATH227B HW#3 w/professor Qing Nie
%part a
syms x y  % declare the system
eq1= x+y^3-2  ;   %put in first equation
eq2= x^3-y  ; %put in second equation
guesx=9  ;      %take a guess for x
guesy=8  ;     %take a guess for y
num_it=10  ;     %set how many iterations you want 

solution=newt_method(eq1,eq2,guesx,guesy,num_it)
double(solution) %view solution as decimal
%problem: my method only finds one solution
%test - check my answer with matlab solve function answers
test1=eq1==0;
test2=eq2==0;
testsol=solve([test1,test2],[x y]);
actx=testsol.x(1,1) %only display first answer (what newtons finds)
acty=testsol.y(1,1) %only display first answer (what newtons finds)
%function takes 5 inputs:
%1) e1=equation 1
%2) e2=equation 2
%3) guessx= initial guess for x_0
%4) guessy= intial guess for y_0
%5) number of iterations (more should be better)
function x_n = newt_method(e1,e2,guessx,guessy,iter)
    syms x y  % declare the system
    guess=[guessx;guessy] ;%put guess into matrix
    jmat=jacobian([e1,e2],[x,y]) ;%calculate the jacobian
    invjmat = inv(jmat) ;%take inverse of the jacobian
    invmat1=subs(invjmat,[x,y],[guessx,guessy]);
    f1=subs(e1,[x,y],[guessx,guessy]);
    f2=subs(e2,[x,y],[guessx,guessy]);
    finit=[f1;f2];
    result=guess-invmat1*finit;
    for i=1:iter
        j=1;
        while j<i
            in1=double(result(1,1)); %convert to double for speed
            in2=double(result(2,1));
            injmatii=subs(invjmat,[x,y],[in1,in2]);
            temp1=subs(e1,[x,y],[in1,in2]);
            temp2=subs(e2,[x,y],[in1,in2]);
            temp3=[temp1;temp2];
            result=result-injmatii*temp3
            j=j+1
        end
    end
    x_n=result;
end