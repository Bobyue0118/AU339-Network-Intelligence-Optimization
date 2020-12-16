function [ fitnessvar, sumDistances,minPath, maxPath ] = fitness( A, pop )
% 计算整个种群的适应度值
    [popSize, col] = size(pop);
    sumDistances = zeros(popSize,1);
    fitnessvar = zeros(popSize,1);
    for i=1:popSize
       sumDistances(i)= sumDistances(i)+A(1,pop(i,1));
       for j=1:col-1
          sumDistances(i) = sumDistances(i) + A(pop(i,j),pop(i,j+1));
       end 
       sumDistances(i)= sumDistances(i)+A(pop(i,col),1);
    end
    minPath = min(sumDistances);
    maxPath = max(sumDistances);
    for i=1:length(sumDistances)
        fitnessvar(i,1)=(maxPath - sumDistances(i,1)+0.000001) / (maxPath-minPath+0.00000001);
    end
end