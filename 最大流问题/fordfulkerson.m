%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% This program solves a sample max-flow-min-cut 
% problem by the Ford-Fulkerson Algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fordfulkerson
%% Input Network as Adjacency Matrix
    clc; clear;
    s = 1; t = 6; f = 0;
    cap = [  0  6 10 10  0  0;
             6  0  0  4  7  0;
            10  0  0  1 14  0;
            10  4  1  0  0  5;
             0  7 14  0  0 21;
             0  0  0  5 21  0  ];
    origin = cap;
    
    
    len = length(cap);
        
%% Ford-Fulkerson Algorithm
    while true
        p = findPath(cap);
        if p(1) == 0, break; end
        flow = max(max(cap));
        for j = 2:length(p)
            flow = min(flow,cap(p(j),p(j-1)));
        end
        for j = 2:length(p)
            a = p(j); b = p(j-1);
            cap(a,b) = cap(a,b) - flow;
            cap(b,a) = cap(b,a) + flow;
        end
        f = f + flow;
        disp(['Intermediate max flow is ' num2str(f)]);
        disp('Intermediate residual graph:');
        disp(cap);
        disp('Intermediate network flow:');
        disp((origin-cap));
    end
    disp(['Max flow is ' num2str(f)]);
    disp('Residual graph:');
    disp(cap);
    disp('Network flow:');
    disp((origin-cap));
    
%% Find an Augmenting Path
    function F = findPath(A)            % BFS (Breadth-first Search)
        q = zeros(1,len);               % queue
        pred = zeros(1,len);            % predecessor array
        front = 1; back = 2;
        pred(s) = s; q(front) = s;
        while front ~= back
            v = q(front);
            front = front + 1;
            for i = 1:len
                if pred(i) == 0 && A(v,i) > 0
                    q(back) = i;
                    back = back + 1;
                    pred(i) = v;
                end
            end
        end
        path = zeros(1,len);
        if pred(t) ~= 0
            i = t; c = 1;
            while pred(i) ~= i
                path(c) = i;
                c = c + 1;
                i = pred(i);
            end
            path(c) = s;
            path(c+1:len) = [];
        end
        F = path;
    end
end