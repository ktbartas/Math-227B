clear all; close all; clc;
% 2/4/21 MATH227B Exam w/professor Qing Nie
%part 2
%fig 2b
%how many days do you want to graph =Tmax
Tmax=40;
%below values from table s2
%initial conditions - zero for PCs and TDCs, non-zero for CSC

tau=2;%time delay parameter
lags = [tau tau tau];
tspan = [0 Tmax];
%type i and ii feedback solution
sol3 = dde23(@ddefun3, lags, @history, tspan);
allcells4=sol3.y;
%tot4=allcells4(1,:)+allcells4(2,:)+allcells4(3,:);%all cells
tot4=allcells4(1,:)+allcells4(3,:);%all cells
allplot4=allcells4(3,:); %TDC only 
CSC4=allcells4(1,:)./tot4 ;%CSC frac

figure(1); hold on;
plot(sol3.x,CSC4,'-b') % blue for type i and ii
legend('Type I and II feedback')
ylabel('Fraction of CSCs')
xlabel('Time (days)')
ylim([0 0.8])
title('Figure 2b simulation recreation')
hold off
function dydt = ddefun3(t,y,Z)
%probability of division
p0=.5;
q0=.2  ;
p1=.5;
q1=.1  ;
%synthesis rates
v0=4; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5
%other parameters (for feedback)
beta0=7*10^(-18) ;%feedback strength parameter
beta1=3*10^(-18);%feedback strength parameter
gamma01=2*10^-17;
gamma02=6*10^-15;
gamma11=1*10^-15;
gamma12=2*10^-14;
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
ei1= 8*10^5 ; %CSC initial (this is a guess as it is not given in paper that I could find
ei2= 6*10^5 ; %PC initial
ei3= 2*10^5 ; %TDC initial
  s = [ei1,ei2,ei3];
end