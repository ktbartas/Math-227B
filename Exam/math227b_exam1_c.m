clear all; close all; clc;
% 2/10/21 MATH227B Exam w/professor Qing Nie
%part c- equations and init conditions, t range, h
cond1 =52.59; %y1(0) 
cond2 =83.82; %y2(0) 
Tmin=0;%min t
Tmax=10^-3;%max t
h=10^-4; %step size
t_vals=Tmin:h:Tmax;

% 'real' solution using Dsolve
syms u(t) v(t)
ode1 = diff(u) == -5*u + 3*v;
ode2 = diff(v) == 100*u -301*v;
odes = [ode1; ode2];
condi1 = u(0) == cond1;
condi2 = v(0) == cond2;
conds = [condi1; condi2];
[uSol, vSol] = dsolve(odes,conds)
true_points=zeros(11,20);
%real solutions for varying h
for h_val =1:10
    tempTmax=10^-h_val;
    h_v=10^-(h_val+1); %temp h
    tempt_vals=Tmin:h_v:tempTmax;
    yone=subs(uSol,t,tempt_vals); %y1
    ytwo=subs(vSol,t,tempt_vals); %y2
    true_points(:,h_val)=yone'; 
    true_points(:,h_val+10)=ytwo';
end
%implement my solution for varying h
bad_points=zeros(11,20);
syms y1 y2 %define system
fun1 = -5*y1 + 3*y2  ; %define function y1
fun2 =100*y1 - 301*y2  ; %define function y2
for h_val =1:10
    tempTmax=10^-h_val;
    h_v=10^-(h_val+1); %temp h
    est_sol=temp_scheme(fun1,fun2,Tmin,tempTmax,[cond1,cond2],h_v);
    yone=est_sol(:,2); %y1
    ytwo=est_sol(:,3); %y2
    bad_points(:,h_val)=yone'; 
    bad_points(:,h_val+10)=ytwo';
end
%calculate error
norm_error=zeros(1,10);
for i=1:10
    est_point=[bad_points(:,i) bad_points(:,i+10)];
    true_point=[true_points(:,i) true_points(:,i+10)];
    norm_error(i)=mean(abs(double(norm(est_point-true_point))));
end
norm_error
hes=[10^-1 10^-2 10^-3 10^-4 10^-5 10^-6 10^-7 10^-8 10^-9 10^-10]; %h values used
%plot h on x-axis and error on y-axis
figure(1); 
set(gca, 'XScale', 'log', 'YScale', 'log');
plot(hes,norm_error)
set(gca, 'XScale', 'log', 'YScale', 'log');
hold on;
syms h
fplot(10000*h^3,[10^-10 10^-1],'--')
fplot(100*h^2,[10^-10 10^-1],'--')
fplot(h^1,[10^-10 10^-1],'--')
legend('error','h^3','h^2','h')
ylabel('error')
xlabel('h')
xlim([10^-6 10^-2])
title('error as h varies'); hold off;

function ans = temp_scheme(fun1,fun2,tmin,tmax,init_cond,h)
steps=(tmax-tmin)/h;
t_vals=tmin:h:tmax;
siz=length(t_vals);
syms y1 y2 t %define system
Y=zeros(2,siz); %make placeholder array
Y(1,1)=init_cond(1,1); %assign init cond y1
Y(2,1)=init_cond(1,2); %assign init cond y2
for i=1   %not Euler's method for 1st step
    t1=t_vals(2);
    t2=t_vals(2);
    temp1=subs(- exp(t*(2*5551^(1/2) - 153))*(5551^(1/2)/50 + 37/25)*((13743*5551^(1/2))/42700 - 4191/100) - (3*5551^(1/2)*exp(-t*(2*5551^(1/2) + 153))*(5551^(1/2)/50 - 37/25)*(1397*5551^(1/2) + 59553))/555100,[t],[t1]);
    temp2=subs((3*5551^(1/2)*exp(-t*(2*5551^(1/2) + 153))*(1397*5551^(1/2) + 59553))/555100 - exp(t*(2*5551^(1/2) - 153))*((13743*5551^(1/2))/42700 - 4191/100),[t],[t2]);
    Y(1,i+1)=temp1;
    Y(2,i+1)=temp2;
end %need more precise guess
for i=2:steps
    in1=double(Y(1,i)); %y_n for y1
    in2=double(Y(2,i)); %y_n for y2
    in3=double(Y(1,i-1)); %y_n-1 for y1
    in4=double(Y(2,i-1)); %y_n-1 for y2
    temp1=subs(fun1,[y1,y2],[in1,in2]); %f(yn1)
    temp2=subs(fun2,[y1,y2],[in1,in2]); %f(yn2)
    temp3=subs(fun1,[y1,y2],[in3,in4]); %f(yn-1 1)
    temp4=subs(fun2,[y1,y2],[in3,in4]); %f(yn-1 2)
    fakeY1=in1+(h/2)*(3*temp1-temp3);
    fakeY2=in2+(h/2)*(3*temp2-temp4);
    fakestar1=subs(fun1,[y1,y2],[fakeY1,fakeY2]);
    fakestar2=subs(fun2,[y1,y2],[fakeY1,fakeY2]); 
    Y(1,i+1)=in1+(h/2)*(temp1+fakestar1);
    Y(2,i+1)=in2+(h/2)*(temp2+fakestar2);
end
ans=[t_vals' Y'];
end