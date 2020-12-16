function [fitnessValue,detailedFval] = fitness(distances, pop, stateNum)
%%%%%%%%%%%%参数说明%%%%%%%%%%%%%
% distances：传感器与目标之间的距离，100*100
% pop：种群，包含所有序列，种群大小*（100*stateNum）
% stateNum：单位周期传感器状态数
% fitnessValue：各序列适应度值，越大越优，种群大小*1
% detailedFval：各序列分项适应度值，种群大小*3，3项包括：
%               周期内各状态目标成功检测率的平均值；
%               周期内所有传感器检测目标总数平均值；
%               周期内所有传感器检测目标总数的方差。
%               以上三项组合（加权求和、乘除...）得到fitnessValue
% popSize = 1000 遗传算法种群大小
%%%%%%%%%%%%参数说明%%%%%%%%%%%%%
%% 一个周期求三个适应度值
    popSize=size(pop,1);
    detailedFval = zeros(popSize,3);
    avg_successful_rate = zeros(1,stateNum);
    fitnessValue = zeros(popSize,1);
    
    for i=1:popSize
        for j=1:stateNum
            targetDetected=check_targets(pop(i,(j*100-99):j*100),distances);
            avg_successful_rate(j) = mean2(targetDetected);     % 第j状态目标成功检测率；
        end
        detailedFval(i,1) = mean(avg_successful_rate);          % 周期内各状态目标成功检测率的平均值；
        detailedFval(i,2) = mean(pop(i,:))/5;                     % 周期内所有传感器检测目标总数平均值；
        pop_r=reshape(pop(i,:),stateNum,100);
        detailedFval(i,3) = var(sum(pop_r,1))/100;              % 周期内所有传感器检测目标总数的方差

        fitnessValue(i)=detailedFval(i,1)/sqrt(detailedFval(i,2)*(detailedFval(i,3)+1)+0.00001);       
        %fitnessValue(i)=detailedFval(i,1);
    end
end