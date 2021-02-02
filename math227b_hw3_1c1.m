clear all; close all; clc;
% 1/30/21 MATH227B HW#3 w/professor Qing Nie
%part c
syms x y      % declare the system
eq1=sin(2*x)-y*x;   %put in first equation
eq2=(x-2)^3-y-5;  %put in second equation
guesx=100 ;      %take a guess for x
guesy=100 ;     %take a guess for y
num_it=20;     %set how many iterations you want 
solution=zeros(2,num_it);
for k=1:num_it
solution(:,k)=newt_method(eq1,eq2,guesx,guesy,k);
end
double(solution)
%calc real answer
actx=3.7378610792717002813768378229747698088083398423079400885065331;
acty=0.2486204824288995168280048956051209120739412395093968992070134729;
actsol=[actx ;acty];
error=zeros(1,num_it);
for k=1:num_it
solution1=solution(:,k);
error(:,k)=norm(solution1-actsol);
end
error
xaxis=2:num_it;
erkn1=log(error(1:end-1));
erknplus1=log(error(2:end));
px=abs(erknplus1./erkn1)
figure(1)
plot(xaxis,px)
%xlim([2 10])
ylim([0 3])
title('Problem part c, Example 1, P converges to 2')
xlabel('Iteration') 
ylabel('P') 


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
            in1=vpa(result(1,1),64) ;%convert to double because it so slow
            in2=vpa(result(2,1),64);
            injmatii=subs(invjmat,[x,y],[in1,in2]);
            temp1=subs(e1,[x,y],[in1,in2]);
            temp2=subs(e2,[x,y],[in1,in2]);
            temp3=[temp1;temp2];
            result=result-injmatii*temp3;
            j=j+1;
        end
    end
    x_n=result;
end