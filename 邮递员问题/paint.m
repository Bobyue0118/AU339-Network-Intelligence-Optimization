function [ output_args ] = paint( cities, pop, minPath, totalDistances,gen)
    gNumber=gen;
    [~, length] = size(cities);
    xDots = cities(1,:);
    yDots = cities(2,:);
    %figure(1);
    title('GA TSP');
    plot(xDots,yDots, 'p', 'MarkerSize', 14, 'MarkerFaceColor', 'blue');
    xlabel('经度');
    ylabel('纬度');
    axis equal
    hold on
    [minPathX,~] = find(totalDistances==minPath,1, 'first');
    bestPopPath = pop(minPathX, :);
    bestX = zeros(1,length);
    bestY = zeros(1,length);
    for j=1:length
       bestX(1,j) = cities(1,bestPopPath(1,j));
       bestY(1,j) = cities(2,bestPopPath(1,j));
    end
    title('GA TSP');
    plot(bestX(1,:),bestY(1,:), 'red', 'LineWidth', 1.25);
    legend('城市', '路径');
    axis equal
    grid on
    %text(5,0,sprintf('迭代次数: %d 总路径长度: %.2f',gNumber, minPath),'FontSize',10);
    drawnow
    hold off
end