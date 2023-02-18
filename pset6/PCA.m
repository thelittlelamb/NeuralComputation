%% PCA
load("ReachData.mat");
% size(R); -> (143, 158), 143 neural and 158 trials

%% corvariance matrix
[n, trials] = size(R) ;
Rt = R';
n_mean = mean(Rt, 1); % (A, dim), dim:沿其运算的维度
n_means = repmat(n_mean, trials, 1);
centered = Rt - n_means; %(158, 143)
covar = cov(centered);

%% eigenvectors and eigenvalues
[F,V] = eig(covar);
[values, index] = sort(diag(V));
values = flip(values);
index = flip(index);
cum_val = cumsum(values);

figure(1);
x = 1:143;
subplot(2, 1, 1);
scatter(x, values, 'filled');
ylabel('Eigenvalues');
title('Eigenvalues')
subplot(2, 1, 2);
scatter(x, cum_val/cum_val(end), 'filled');
ylabel('Percentage');
title('Percentage');

%% Neuron 6 & 7
c = jet(8);
co = zeros(n, 3);
for i = 1:length(centered)
    col = c(direction(i),:); % 直接c(1)取第一个数
    co(i,:) = col;
end
figure(2);
scatter(centered(:,7), centered(:,8), 50, co, "filled");
title("Neuron 7 and 8 Check");
xlabel("Neuron 7");
ylabel("Neuron 8");
colormap(c);
colorbar('Ticks',[0.05 0.175 0.3 0.425 0.55 0.69 0.82 0.94],...
    'TickLabels',["0 deg" "45 deg" "90 deg" "135 deg" "180 deg" "225 deg" "270 deg" "315 deg"])

%% PCA
eig_sort = F(:, index);
eig12 = eig_sort(:, 1:2);
proj = centered * eig12;
scatter(proj(:,1),proj(:,2),50,co,'filled');
title("PCA on Motor Neurons");
colormap(c);
colorbar('Ticks',[0.05 0.175 0.3 0.425 0.55 0.69 0.82 0.94],...
    'TickLabels',["0 deg" "45 deg" "90 deg" "135 deg" "180 deg" "225 deg" "270 deg" "315 deg"])

%% Motor Arm, Only A, Move up
up = [];
for i=1:length(direction)
    if direction(i,:) == 3
        up = [up i];
    end
end

Va=[];
for i =1:length(up)
    Va = [Va; eig12(:,1)'*centered(up(i),:)'];
end
disp("The mean and standard deviation of Voltage at A is");
disp(mean(Va));
disp(std(Va));