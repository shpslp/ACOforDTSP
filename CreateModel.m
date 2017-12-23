%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA103
% Project Title: Ant Colony Optimization for Traveling Salesman Problem
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function model=CreateModel()

    addpath('./pseudo_data');
    data=load('data.dat'); %pseudo_data/
    offset = 0.01;

    x=[82 91 92 63  9 28 55 96 97 98 96 49 80 14 42 92 80 43 64 67 56 74 56 31  7  4 98 35 71];
    
    y=[66  3 94 68 76 75 39 66 17  3 27  4  9 83 70 32 95  7 43 12 47 60 98 36  2 46 50 52 34];
    
    n=numel(x);
    
    D=zeros(n,n);
    
    for i=1:n-1
        for j=i+1:n
            
            D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            
            D(j,i)=D(i,j);
            
        end
    end
    
    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;
    model.P=data + offset;

end