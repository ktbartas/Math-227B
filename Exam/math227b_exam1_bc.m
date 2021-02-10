clear all; close all; clc;
% 2/10/21 MATH227B Exam w/professor Qing Nie
%part 1b- equations and init conditions, t range, h
cond1 =52.59; %y1(0) 
cond2 =83.82; %y2(0) 
eq1 =@(y1,y2) -5*y1 + 3*y2   ;
eq2 =@(y1,y2) 100*y1 - 301*y2  ;
Tmin=0;%min t
Tmax=10^-2;%max t
h=10^-4; %step size
t_vals=Tmin:h:Tmax;
% 'real' solution using ode45
[exact_t, exact_y] = ode45(@(t,b)[eq1(b(1),b(2));eq2(b(1),b(2))], [Tmin,Tmax], [cond1,cond2] );
y1_exact=exact_y(:,1);
y2_exact=exact_y(:,2);
% 'real' solution using Dsolve
syms u(t) v(t)
ode1 = diff(u) == -5*u + 3*v; %u is y1
ode2 = diff(v) == 100*u -301*v; %v is y2
odes = [ode1; ode2];
condi1 = u(0) == cond1;
condi2 = v(0) == cond2;
conds = [condi1; condi2];
[uSol, vSol] = dsolve(odes,conds);
yone=subs(uSol,t,t_vals); %y1
ytwo=subs(vSol,t,t_vals); %y2
true_points=[yone' ytwo'];

%implement my solutions
syms y1 y2 %define system
fun1 = -5*y1 + 3*y2  ; %define function y1
fun2 =100*y1 - 301*y2  ; %define function y2
est_sol=temp_scheme(fun1,fun2,Tmin,Tmax,[cond1,cond2],h)
est_t= est_sol(:,1);
y1_est=est_sol(:,2) ;
y2_est=est_sol(:,3) ;

%plot real solution
figure(1); hold on;
%plot(exact_t,y1_exact) % y_1 exact (ode45)
%plot(exact_t,y2_exact) % y_1 exact (ode45)
fplot(uSol,[Tmin Tmax])
fplot(vSol,[Tmin Tmax])
%plot estimated solution 
plot(est_t,y1_est,'--') % y_1 est (AM)
plot(est_t,y2_est,'--') % y_2 est (AM)
legend('y_1 exact','y_2 exact','y_1 estimate','y_2 estimate')
ylabel('y_1 and y_2')
xlabel('t')
title('y_1 and y_2 over time');hold off

function ans = temp_scheme(fun1,fun2,tmin,tmax,init_cond,h)
steps=(tmax-tmin)/h;
t_vals=tmin:h:tmax;
syms y1 y2 t %define system
Y=zeros(2,steps+1); %make placeholder array
Y(1,1)=init_cond(1,1); %assign init cond y1
Y(2,1)=init_cond(1,2); %assign init cond y2
for i=1   %Euler's method for 1st step
    in1=Y(1,1);
    in2=Y(2,1);
    temp1=subs(fun1,[y1,y2],[in1,in2]);
    temp2=subs(fun2,[y1,y2],[in1,in2]);
    Y(1,i+1)=in1+h*temp1;
    Y(2,i+1)=in2+h*temp2;
end %need this for 2nd step for temporal scheme
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
    Y(1,i+1)=in1+(h/2)*(temp1+fakeY1);
    Y(2,i+1)=in2+(h/2)*(temp2+fakeY2);
end
ans=[t_vals' Y'];
end