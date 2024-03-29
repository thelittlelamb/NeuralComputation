%% Program to demonstrate perceptron learning rule
%
rng(50);                 % Seed random number generator for reproducibility
m1=1000;                 % number of samples in set 1
m2=m1;                	 % number of samples in set 2
m=m1+m2;				 % total number of samples
%
a=4;					 % Cluster 1 centered at position (4,4) 
b=0;					 % Cluster 2 centered at position (0,0) 
c1=repmat([a ; a], 1, m1);    % center of cluster 1 (4,4)
c2=repmat([b ; b], 1, m2);    % center of cluster 2 (0,0)
%
x1=c1+randn(2, m1);      % set 1 is a Gaussian cluster centered at c1
x2=c2+randn(2, m2);      % set 2 is a Gaussian cluster centered at c2

T1=ones(1, m1) ;         % Classes coded as 1 and 0
T2=zeros(1,m2);

T=cat(2,T1,T2);% Class labels
x=cat(2,x1,x2); % data points
%

fg =figure(1);
plot(x1(1,:), x1(2,:), 'ob')
hold on
plot(x2(1,:), x2(2,:), 'or')
% Setting axes with center in origin (0,0) in plotted variables.
ax = gca;
ax.XAxisLocation='origin';
ax.YAxisLocation='origin';
ax.LineWidth=2;
ax.FontSize=14;
box off
fg.Color='w';

%% Preceptron
j=randperm(m);% Random permutation of the data points
T=T(j);
x=x(:,j);

theta=1;% Threshold
eta=0.05;% learning rate
%
w=[.75;-.5];                % initial guess for weight vector



% Main for loop
% Visit the data points in random sequence to learn the weights
for i=1:m
   
    %%% follow instructions to complete for loop %%%
   proj = sum(x(:,i).*w);   
    % project the ith data point onto w and compute the output of the
    % perceptron
   if (proj - theta) >= 0
       fr = 1;
   else
       fr = 0;
   end
    % compute the update (delta w) to the weight vector under these two
    % conditions:
   if fr == T(i)
       % if the classification was correct:
       continue;
   else
       % if the classification was incorrect:
       if T(i) == 1
           w = w + eta * x(:,i);
       else
           w = w - eta * x(:,i);
       end
    % update the weight vector 
   end 
end

%% Your code to add  the decision boundary to figure (1) goes here%%

xmax = max( x(1,:));
xmin = min( x(1,:));

x = xmin : 0.5 : xmax;
y = ( 1 - w(1)*x ) / w(2); % W*U = Theta therefore w1x1 + w2x2 = theta

plot(x,y,'green','LineWidth', 2);

hold off

hold off


