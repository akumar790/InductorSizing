clear all
close all

vm=100;
%vo=[80:0.1: 120];
E=0.7;
% i have used values of exmple 4.5
f=60;
w=2*pi*f;
L=5*10^-3; %inductor
%R=9.4248;
R=2:5:1000; % vary step size of R to get more values of R, use R=1

%R=2;
%%%%

counter=0;
for j=1:length(R)
    i=0;
    vo=40; % initial value
while(1)
%step 1
i=i+1
j
syms x
a(i)=asin(vo/vm);
%setep 2
b(i) = vpasolve(vm*(cos(a(i))-cos(x))-vo*(x-a(i))==0, x,pi);
if isempty(b)
    b(i) = (vpasolve(vm*(cos(a(i))-cos(x))-vo*(x-a(i))==0, x));
end
b=double(b);

%step 3

fun = @(q) (1/(w*L))*(vm*(cos(a(i))-cos(q))-vo*(q-a(i)));

q = (1/pi)*(integral(fun,a(i),b(i)));

%step 4
Vonew(j,i)=q*R(j);

if (abs(Vonew(j,i)-vo)<=E)
    %fprintf('Soution is : %f\n', Vonew(j,i),'Vo is', vo); 
    %disp('Solution is');
    %disp(Vonew(i));
    counter=counter+1;
    plot_project(j,1)=Vonew(j,i); % Caclulated Vo
    plot_project(j,2)=vo; % Estimated Vo
    break;
else
    vo=vo+0.02; %0.1 %0.05
end
end
clear b;
end


xval=3.*w*L./R(1,:); % 3wL/R

xval(end+1)=0;
yval=plot_project(:,2)./vm; % Vo/Vm

yval(end+1)=1;
plot(xval,yval)

grid on 
xlim([0 1.4])
ylim([0 1])
xticks(0:0.05:1.4)
%yticks(0:0.05:1)
yticks(0:0.05:1)
xlabel('3wl/r')
ylabel('Vo/Vin')
