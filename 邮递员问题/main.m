clear;
clc;
tStart = tic; % 算法计时器

load('new_A.mat');
G=graph(full_A);
%%%%%%%%%%%%自定义参数%%%%%%%%%%%%%
rng(2);
maxGEN = 3000;
popSize = 1000; % 遗传算法种群大小
crossoverProbabilty = 0.7; %交叉概率
mutationProbabilty1 = 0.1; %变异概率
mutationProbabilty2 = 0.5;
mPChange=0.0002;
cPChange=0.0001;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gbest = Inf;

pop = zeros(popSize, G.numnodes-1);
for i=1:popSize
    pop(i,:) = randperm(G.numnodes-1); 
    pop(i,:) = pop(i,:)+1;
end
offspring = zeros(popSize,G.numnodes-1);
%保存每代的最小路径便于画图
minDists = zeros(maxGEN,1);
minPaths = zeros(maxGEN,G.numnodes-1);
% GA算法
for  gen=1:maxGEN
% 
%     % 计算适应度的值，即路径总距离
     [fval, sumDistance, minDist, maxPath] = fitness(full_A, pop);
% 
    % 轮盘赌选择
    tournamentSize=4; %设置大小
    for k=1:popSize
        % 选择父代进行交叉
        tourPopDistances=zeros( tournamentSize,1);
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end

        % 选择最好的，即距离最小的
        parent1  = min(tourPopDistances);
        [parent1X,parent1Y] = find(sumDistance==parent1,1, 'first');
        parent1Path = pop(parent1X(1,1),:);
        
%         if gen>4000
%             random = rand();
%             if random<=databaseProbability
%                 parent1Path = geneDatabase(randperm(databaseSize,1),:);               
%             end
%         end
        
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
        parent2  = min(tourPopDistances);
        [parent2X,parent2Y] = find(sumDistance==parent2,1, 'first');
        parent2Path = pop(parent2X(1,1),:);

        subPath = crossover(parent1Path, parent2Path, crossoverProbabilty);%交叉
        
        if mod(gen,1000)<800 && mod(gen,1000)>500
            subPath = mutate(subPath, mutationProbabilty2);%变异
        else
            subPath = mutate(subPath, mutationProbabilty1);
        end

        offspring(k,:) = subPath(1,:);

    end
    minDists(gen,1) = minDist; 
    fprintf('代数:%d   最短路径:%.2f \n', gen,minDist);
    % 更新
    pop = offspring;
    % 画出当前状态下的最短路径
    if minDist < gbest
        gbest = minDist;
        [minX,minY] = find(sumDistance==minDist,1, 'first');
        minPath=pop(minX,:);
%         paint(cities, pop, gbest, sumDistance,gen);
    end
    minPaths(gen,:) = minPath;
    
%     if gen>1000
%         mutationProbabilty=mutationProbabilty+mPChange;    
%         crossoverProbabilty=crossoverProbabilty-cPChange;
%     end
    
end
 
figure 
plot(minDists, 'MarkerFaceColor', 'red','LineWidth',1);
title('收敛曲线图（每一代的最短路径）');
set(gca,'ytick',10000:5000:50000);
ylabel('路径长度');
xlabel('迭代次数');
grid on
tEnd = toc(tStart);
fprintf('时间:%d 分  %f 秒.\n', floor(tEnd/60), rem(tEnd,60));