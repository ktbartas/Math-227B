clear all; close all; clc;
% 2/4/21 MATH227B Exam w/professor Qing Nie
%part 2
%fig 1c - EXTRA CREDIT
%how many days do you want to graph =Tmax
Tmax=11;
%below values from table s2
%initial conditions - zero for PCs and TDCs, non-zero for CSC
ei1= 7.5*10^3 ; %CSC initial (this is a guess as it is not given in paper that I could find
ei2= 0 ; %PC initial
ei3= 0 ; %TDC initial

%probability of division
pno0=.25  ; %p0 for no  feedback
p0=.5;
q0=.2  ;
pno1=.3  ; %p1 for no  feedback
p1=.5;
q1=.1  ;
%synthesis rates
v0=.7 ;% v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5
%exact values of v0-1,d0-2 are not given but my values match the ratios
%given.

%other parameters (for feedback)
tau=2;%time delay parameter

%equations - no feedback
eq1 =@(x0,x1,x2) (pno0-q0)*v0*x0-d0*x0   ;
eq2 =@(x0,x1,x2) (1-pno0+q0)*v0*x0+(pno1-q1)*v1*x1-d1*x1  ;
eq3 =@(x0,x1,x2) (1-pno1+q1)*v1*x1-d2*x2   ;

%no feedback solution
[time, ex1] = ode45(@(t,b)[eq1(b(1),b(2),b(3));eq2(b(1),b(2),b(3));eq3(b(1),b(2),b(3))], [0,Tmax], [ei1,ei2,ei3] );
tot1=ex1(:,1)+ex1(:,2)+ex1(:,3); %all cells
allcells=ex1(:,3); %TDC only 
CSC1=ex1(:,1);%./tot1

%type i feedback solution
lags = [tau tau tau];
tspan = [0 Tmax];
sol = dde23(@ddefun, lags, @history, tspan);
allcells2=sol.y;
tot2=allcells2(1,:)+allcells2(2,:)+allcells2(3,:);%all cells
allplot2=allcells2(3,:);%TDC only 
CSC2=allcells2(1,:);%./tot2 %CSC frac

%type ii feedback solution
sol2 = dde23(@ddefun2, lags, @history, tspan);
allcells3=sol2.y;
tot3=allcells3(1,:)+allcells3(2,:)+allcells3(3,:);%all cells
allplot3=allcells3(3,:); %TDC only 
CSC3=allcells3(1,:);%./tot3 %CSC frac

%type i and ii feedback solution
sol3 = dde23(@ddefun3, lags, @history, tspan);
allcells4=sol3.y;
tot4=allcells4(1,:)+allcells4(2,:)+allcells4(3,:);%all cells
allplot4=allcells4(3,:); %TDC only 
CSC4=allcells4(1,:);%./tot3 %CSC frac

%youn et al data
younx=[10/24 35/24 60/24 85/24 110/24 135/24 160/24 185/24];
youny=[.2*10^5 .5*10^5 1*10^5 2*10^5 5*10^5 6.5*10^5 7*10^5 5.8*10^5 ];
younx2=[10/24 35/24 60/24 85/24 110/24 135/24 160/24 185/24];
youny2=[.5*10^5 1.6*10^5 2.6*10^5 4*10^5 6.5*10^5 6.8*10^5 5*10^5 2.3*10^5 ];
figure(1); hold on;
plot(time,tot1,'--g') % dash green for no feedback
plot(sol.x,tot2,'-g') % green for type i feedback
plot(sol2.x,tot3,'-y') % yellow for type ii
plot(sol3.x,tot4,'-b') % blue for type i and ii
scatter(younx,youny,'r','filled')
scatter(younx2,youny2,'c','filled')
legend('No feedback','Type I feedback','Type II feedback','Type I and II feedback','Youn et al. Low Inoculation Data','Youn et al. High Inoculation Data')
ylabel('Cell number')
xlabel('Time (days)')
title('Figure 1c simulation and Youn et al comparison')
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
v0=.99; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5

%other parameters (for feedback)
beta0=8*10^(-9) ;%feedback strength parameter
beta1=4*10^(-10);%feedback strength parameter
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
p0=.5;
q0=.2  ;
p1=.5;
q1=.1  ;
%synthesis rates
v0=.5%  ; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5
%other parameters (for feedback)
beta0=8*10^(-11) ;%feedback strength parameter
beta1=4*10^(-10);%feedback strength parameter
gamma01=10^-15;
gamma02=10^-14;
gamma11=10^-15;
gamma12=10^-14;
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
v0=1.1%  ; % v0/v1 must be 0.5
v1=v0/0.5;
%degradation rates
d2=.05*v1 ;%for TDC, d2/v1 must be 0.05
d0=.1*d2;%for CSC ("small or negligible compared to TDC"), d0/d2 must be 0.1
d1=d2*0.5 ;%for PC ("small or negligible compared to TDC"), d1/d2 must be 0.5
%other parameters (for feedback)
beta0=8*10^(-10) ;%feedback strength parameter
beta1=4*10^(-10);%feedback strength parameter
gamma01=10^-14;
gamma02=10^-14;
gamma11=10^-15;
gamma12=10^-15;
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
ei1= 7.5*10^3 ; %CSC initial (this is a guess as it is not given in paper that I could find
ei2= 0 ; %PC initial
ei3= 0 ; %TDC initial
  s = [ei1,ei2,ei3];
end