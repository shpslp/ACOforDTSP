
function model=CreateModel(fix,N)
if fix == 0
%% Geomatric Data

    georand = randi(5000,2,N);
    x=georand(1,1:N);
    y=georand(2,1:N);
    n=numel(x);
    
    D=zeros(n,n);
    
    for i=1:n-1
        for j=i+1:n
            
            D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            
            D(j,i)=D(i,j);
            
        end
    end

%% Home-Probability Data
    HomeProb = zaitakukakuritu(N,4,3);

    % save workspace
    save('./input/input.mat','n','x','y','D','HomeProb');
    
else
    % load workspace
    load('./input/input.mat','n','x','y','D','HomeProb')
end
    
  
  % set each value in structure  
    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;
    model.P=HomeProb;

    
end