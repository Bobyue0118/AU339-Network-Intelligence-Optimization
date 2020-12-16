function [parentGene]=tournament_selection(pop,popSize,fitnessValue,tournamentSize)

    tourPopFVal=zeros(tournamentSize,1);
    tourIndex=zeros(tournamentSize,1);
    for i=1:tournamentSize
        tourIndex(i,1)=randi(popSize);
        tourPopFVal(i,1) = fitnessValue(tourIndex(i,1),1);
    end

    % 选择最好的，即适应度最大的
    [parentFVal,parentIndex]= max(tourPopFVal);
    parentGene = pop(tourIndex(parentIndex,1),:);
end