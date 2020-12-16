function [subGene] = mutate(orgGene, mutationProbabilty, stateNum)
% 根据概率变异
    if rand()<=mutationProbabilty
        subGene = orgGene;
        for i=1:stateNum
            randIndex1 = randi(100,5,1)+(i-1)*100;
            subGene(randIndex1) = randi(6,1,5)-1;
        end
    else
        subGene = orgGene;
    end
end