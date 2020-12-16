function [ mutatedPath ] = mutate( path, prob )
%对指定的路径利用指定的概率进行更新
    random = rand();
    if random <= prob
        [l,length] = size(path);
        index1 = randi(length);
        index2 = randi(length);
        %交换
        temp = path(l,index1);
        path(l,index1) = path(l,index2);
        path(l,index2)=temp;
    end
        mutatedPath = path; 
end