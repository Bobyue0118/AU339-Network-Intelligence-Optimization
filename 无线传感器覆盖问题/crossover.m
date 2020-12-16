function [subGene]=crossover(parent1Gene, parent2Gene, crossoverProbabilty,stateNum)
% 根据两个父本基因和交叉概率求一个子代
    if rand() <= crossoverProbabilty
        [~, length] = size(parent1Gene);
        for i=1:stateNum
            crossPoint1 = randi(100)+(i-1)*100;
            subGene = zeros(1,length);
            subGene((i-1)*100+1:crossPoint1) = parent1Gene((i-1)*100+1:crossPoint1);
            subGene(crossPoint1+1:i*100) = parent2Gene(crossPoint1+1:i*100);
        end
    else 
        subGene = parent1Gene;
    end
        
end