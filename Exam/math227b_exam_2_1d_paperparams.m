clear all; close all; clc;
% 2/4/21 MATH227B Exam w/professor Qing Nie
%part 2
%fig 1d
%how many days do you want to graph =Tmax
Tmax=120;
%below values from table s2
%initial conditions - zero for PCs and TDCs, non-zero for CSC

tau=2;%time delay parameter
lags = [tau tau tau];
tspan = [0 Tmax];
%type i and ii feedback solution
sol3 = dde23(@ddefun3, lags, @history, tspan);
allcells4=sol3.y;
tot4=allcells4(1,:)+allcells4(2,:)+allcells4(3,:);%all cells
allplot4=allcells4(3,:); %TDC only 
CSC4=allcells4(1,:)./tot4 ;%CSC frac

figure(1); hold on;
plot(sol3.x,tot4,'-b') % blue for type i and ii
legend('Type I and II feedback')
ylabel('Cell number')
xlabel('Time (days)')
title('Figure 1d simulation recreation')
hold off
function dydt = ddefun(t,y,Z)
%probability of division
pno0=.25  ; %p0 for no  feedback
p0=.5;
q0=.2  ;
pno1=.3  ; %p1 for no  feedback
p1=.5;
q1=.1  ;
%synthesis rates
v0=-4; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5

%other parameters (for feedback)
beta0=2*10^(-11) ;%feedback strength parameter
beta1=3*10^(-12);%feedback strength parameter
tau=2;%time delay parameter
  ylag1 = Z(:,1); % this is x0(t-tau)
  ylag2 = Z(:,2); % this is x1(t-tau)
  ylag3 = Z(:,3); % this is x2(t-tau)

  dydt = [(p0-q0)*v0*y(1)/(1+beta0*(ylag3(3))^2)-d0*y(1); 
          (1-p0+q0)*v0*y(1)/(1+beta0*(ylag3(3))^2)+((p1-q1)*v1*y(2)/(1+beta1*(ylag3(3))^2))-d1*y(2); 
          (1-p1+q1)*v1*y(2)/(1+beta1*(ylag3(3))^2)-d2*y(3)];
end
function dydt = ddefun2(t,y,Z)
%probability of division
pno0=.25  ; %p0 for no  feedback
p0=.5;
q0=.2  ;
pno1=.3  ; %p1 for no  feedback
p1=.5;
q1=.1  ;
%synthesis rates
v0=.6; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5
%other parameters (for feedback)
beta0=2*10^(-11) ;%feedback strength parameter
beta1=3*10^(-12);%feedback strength parameter
gamma01=5*10^-14;
gamma02=7*10^-15;
gamma11=6*10^-13;
gamma12=2*10^-15;
tau=2;%time delay parameter
  ylag1 = Z(:,1); % this is x0(t-tau)
  ylag2 = Z(:,2); % this is x1(t-tau)
  ylag3 = Z(:,3); % this is x2(t-tau)
%x0=y(1), etc
  dydt = [((p0/(1+gamma01*ylag3(3)^2))-(q0/(1+gamma02*ylag3(3)^3)))*v0*y(1)-d0*y(1); 
          (1-(p0/(1+gamma01*ylag3(3)^2))+(q0/(1+gamma02*ylag3(3)^3)))*v0*y(1)+((p1/(1+gamma11*ylag3(3)^2))-(q1/(1+gamma12*ylag3(3)^3)))*v1*y(2)-d1*y(2); 
          (1-(p1/(1+gamma11*ylag3(3)^2))+(q1/(1+gamma12*ylag3(3)^3)))*v1*y(2)-d2*y(3)];
end
function dydt = ddefun3(t,y,Z)
%probability of division
p0=.5;
q0=.2  ;
p1=.5;
q1=.1  ;
%synthesis rates
v0=.18; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5
%other parameters (for feedback)
beta0=8*10^(-27) ;%feedback strength parameter
beta1=4*10^(-27);%feedback strength parameter
gamma01=10^-23;
gamma02=2*10^-24;
gamma11=4*10^-22;
gamma12=5*10^-23;
tau=2;%time delay parameter
  ylag1 = Z(:,1); % this is x0(t-tau)
  ylag2 = Z(:,2); % this is x1(t-tau)
  ylag3 = Z(:,3); % this is x2(t-tau)
%x0=y(1), etc
  dydt = [((p0/(1+gamma01*ylag3(3)^2))-(q0/(1+gamma02*ylag3(3)^3)))*v0*y(1)/(1+beta0*(ylag3(3))^2)-d0*y(1); 
          (1-(p0/(1+gamma01*ylag3(3)^2))+(q0/(1+gamma02*ylag3(3)^3)))*v0*y(1)/(1+beta0*(ylag3(3))^2)+((p1/(1+gamma11*ylag3(3)^2))-(q1/(1+gamma12*ylag3(3)^3)))*v1*y(2)/(1+beta1*(ylag3(3))^2)-d1*y(2); 
          (1-(p1/(1+gamma11*ylag3(3)^2))+(q1/(1+gamma12*ylag3(3)^3)))*v1*y(2)/(1+beta1*(ylag3(3))^2)-d2*y(3)];
end
function s = history(t)
ei1= 1.5*10^5 ; %CSC initial (this is a guess as it is not given in paper that I could find
ei2= 0 ; %PC initial
ei3= 0 ; %TDC initial
  s = [ei1,ei2,ei3];
end