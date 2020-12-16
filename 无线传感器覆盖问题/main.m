for ind=1:10
clear;
clc;
tStart = tic; % 算法计时器

%%%%%%%%%%%%环境设置与参数%%%%%%%%%%%%%
%rng('default');
targets=400*rand(100,2);                % 目标
%sensors=400*rand(100,2);                % 传感器
sensors=distribute(targets);
distances=pdist2(sensors,targets);      % 距离矩阵100*100，(i,j)返回传感器i,目标j距离
stateNum=3;                             % 单位周期状态数
maxGEN = 2000;                         % 迭代轮数
popSize = 1000;                         % 遗传算法种群大小
geneLength = 100*stateNum;              % 序列长度
crossoverProbabilty = 0.7; %交叉概率
mutationProbabilty = 0.1; %变异概率
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pop = zeros(popSize,geneLength);
for i=1:popSize
    % pop(i,:) = 5*(randi(2,1,geneLength)-1);         % 不考虑目标数，0-5二值
    pop(i,:) = randi(6,1,geneLength)-1;               % 考虑目标数，0~5六值
end
offspring = zeros(popSize,geneLength);

%保存每代的最优
optFVals = zeros(maxGEN,1);                
optDetailedFVals = zeros(maxGEN,3);
% optGenes = zeros(maxGEN,geneLength);

%保存总体最优
bestGene = zeros(1,geneLength);
bestFVal = -Inf;
bestDFVal = zeros(1,3);

% GA算法
for  gen=1:maxGEN
    
   % 计算适应度的值
    [fitnessValue,detailedFval] = fitness(distances, pop, stateNum);
    
    % 轮盘赌选择
    tournamentSize=4; %设置大小
    for k=1:popSize
        % 选择父代进行交叉
        parent1Gene=tournament_selection(pop,popSize,fitnessValue,tournamentSize);
        parent2Gene=tournament_selection(pop,popSize,fitnessValue,tournamentSize);

        subGene = crossover(parent1Gene, parent2Gene, crossoverProbabilty, stateNum);%交叉
        subGene = mutate(subGene, mutationProbabilty, stateNum);%变异

        offspring(k,:) = subGene(1,:);
    end
    
    [optFVal,optIndex]=max(fitnessValue);
    optFVals(gen,1)=optFVal;
    optDetailedFVals(gen,:)=detailedFval(optIndex,:);
    % optGenes(gen,:)=pop(optimIndex,:);
    fprintf('代数:%d \n 最优适应函数:%.2f 感知率:%.2f\n 能耗率:%.2f\n'...
            ,gen, optFVal,detailedFval(optIndex,1),detailedFval(optIndex,2));
    
    % 更新
    if optFVal > bestFVal
        bestFVal = optFVal;
        bestDFVal = optDetailedFVals(gen,:);
        bestGene = pop(optIndex,:);
    end    
    pop = offspring;
end
tEnd = toc(tStart);
%%%%%%%%%%最高能耗%%%%%%%%%%
g_full=5*ones(1,100);
[fullFValue,fullDetailedFval]=fitness(distances,g_full,1);
fprintf('最高能耗 适应函数:%.2f 感知率:%.2f\n 能耗率:%.2f\n'...
            ,fullFValue,fullDetailedFval(1),fullDetailedFval(2));
%%%%%%%%%%最高能耗%%%%%%%%%%

folder=num2str(fix(datevec(now)));
folder=strrep(folder, ' ', '');
folder=['d_results/',folder];
mkdir(folder);
save([folder,'/targets.mat'],'targets')
save([folder,'/sensors.mat'],'sensors')
save([folder,'/optFVals.mat'],'optFVals')
save([folder,'/optDetailedFVals.mat'],'optDetailedFVals')
save([folder,'/bestGene.mat'],'bestGene')
save([folder,'/bestDFVal.mat'],'bestDFVal')
save([folder,'/tEnd.mat'],'tEnd')
save([folder,'/fullDetailedFval.mat'],'fullDetailedFval')

end
% figure 
% plot(optimFVals, 'MarkerFaceColor', 'red','LineWidth',1);
% title('收敛曲线图（每一代的最短路径）');
% set(gca,'ytick',5000:5000:50000);
% ylabel('路径长度');
% xlabel('迭代次数');
% grid on
% tEnd = toc(tStart);
% fprintf('时间:%d 分  %f 秒.\n', floor(tEnd/60), rem(tEnd,60));