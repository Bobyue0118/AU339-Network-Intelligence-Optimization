clc;clear;
graph_mat=xlsread('TSP_graph.xls');
s=[graph_mat(:,2);graph_mat(:,6);graph_mat(:,10);graph_mat(:,14)];
t=[graph_mat(:,3);graph_mat(:,7);graph_mat(:,11);graph_mat(:,15)];
weight=[graph_mat(:,4);graph_mat(:,8);graph_mat(:,12);graph_mat(:,16)];
G=graph(s(1:62),t(1:62),weight(1:62));
A=adjacency(G,'weighted');
full_A=full(A);

for i=1:G.numnodes
    for j=i+1:G.numnodes
        [P,d]=shortestpath(G,i,j,'Method','positive');
        full_A(i,j)=d;
        full_A(j,i)=d;        
    end
end
save('new_A.mat','full_A');