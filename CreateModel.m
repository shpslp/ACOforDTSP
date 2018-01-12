
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
    
    WorkerData    = [12 10 6  5 4 3 2 2 3 5  9 19 37 50 55 45 34 25 22 18 16 14 14 15 21 20 18 16 15 15 15 16 18 20 23 30 38 47 54 59 63 67 70 70 65 60 42 29];
    HousewifeData = [8  7  4  3 2 2 2 2 2 4 11 27 49 69 83 87 87 84 77 71 60 57 56 58 70 72 68 64 59 61 64 62 64 67 77 83 84 87 90 90 87 88 86 85 69 67 44 27];
    NeetData      = [8  5  3  3 2 1 3 2 4 7 14 22 40 56 70 76 79 74 68 64 60 55 59 63 72 73 65 61 56 57 60 60 66 71 78 83 86 88 88 88 86 84 69 63 49 38 21 13];
    
%     make time series with random noise, random people selection and random +-1 hour offset around 9:00~22:00

    WD =@(k) WorkerData(18+k:44+k)/100;
    HD =@(k) HousewifeData(18+k:44+k)/100;
    ND =@(k) NeetData(18+k:44+k)/100;
    Data =@(k) [WD(k); HD(k); ND(k)];
     %rate of job
    NWD=56;
    NHD=13;
    NND=16;
    Data =@(k) [repmat(WD(k),NWD,1); repmat(HD(k),NHD,1); repmat(ND(k),NND,1)];
    
    ind=randi(NWD+NHD+NND,n,1);  
    offset=randi(9,n,1)-5;
    gain = 0.9+0.2*rand(n,numel(WD));
    for i=1:n
        tmp1=Data(offset(i));
        tmp2=tmp1(ind(i),:);
        HomeProb(i,:)=tmp2.*gain(i,:);
    end
    %     save workspace
    save('./input/input.mat','n','x','y','D','HomeProb');
    
else
    
    load('./input/input.mat','n','x','y','D','HomeProb')
end
    
  
  % set each value in structure  
    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;
    model.P=HomeProb';

end