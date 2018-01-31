%% 在宅確率計算プログラム

function P_fam = zaitakukakuritu(NUM,Rx_level,Ry_level)
%% 設定
%人数
% NUM = 80;
num = NUM*6;
% %確率ノイズの最大量[%]（最大9%まで、それ以上は100%を超過する）
% Ry_level = 5;
% %周期ズレ最大値[hour]（最大1.5hまで、それ以上は24時を超過する）
% Rx_level = 4;
% 
% %読み込みファイルフォルダ
% folder_name = 'E:\大学\M1\システム制御プロジェクト\program\';

%グラフ表示の有無(0で表示しない、1で表示)
graph = 0;

%保存の有無(0で保存しない、1で保存)
SAVE = 1;

%% データ読み込み ＆ 曜日ごとの平均
time = 0:0.5:23.5;  %時刻列
Yusyokusya = textread('Yusyokusya.txt');
meanY = mean([Yusyokusya Yusyokusya]);
Syuhu = textread('Syuhu.txt');
meanS = mean([Syuhu Syuhu]);
Musyoku = textread('Musyoku.txt');
meanM = mean([Musyoku Musyoku]);

%% プロット
if(graph == 1)
    figure()
    h = plot(time,meanY,time,meanS,time,meanM);
    xlabel('Time[h]');
    ylabel('在宅確率平均値');
    legend('有職者','主婦','無職');
end
%% 縦方向ノイズRy

Ry_Y = (rand(num,48*2)-0.5)*2*Ry_level;
Ry_S = (rand(num,48*2)-0.5)*2*Ry_level;
Ry_M = (rand(num,48*2)-0.5)*2*Ry_level;

%人数分の配列に拡張してノイズを加算
Y_n1 = ones(num,1)*meanY + Ry_Y;
S_n1 = ones(num,1)*meanS + Ry_S;
M_n1 = ones(num,1)*meanM + Ry_M;

% 0以下の値は強制的に0にする（保険）（ノイズ量10%未満なら100%は超えないので無視）
Y_n2 = Y_n1.*(Y_n1>0);
S_n2 = S_n1.*(S_n1>0);
M_n2 = M_n1.*(M_n1>0);

if(graph == 1)
    figure()
    plot(time,Ry_Y');
    xlabel('Time[h]');
    ylabel('ノイズ量[%]');

    figure()
    plot(time,Y_n2');
    xlabel('Time[h]');
    ylabel('有職者の在宅確率（確率ノイズ含む）');

    figure()
    plot(time,S_n2');
    xlabel('Time[h]');
    ylabel('主婦の在宅確率（確率ノイズ含む）');
    
    figure()
    plot(time,M_n2');
    xlabel('Time[h]');
    ylabel('無職の在宅確率（確率ノイズ含む）');
end

%% 周期ズレRx
num_day = 19:45;        %9~22時にあたる配列の番号
daytime = time(num_day);%9~22時の時刻列

%配列を何個ズラすかの乱数
Rx_Y = randi(4*Rx_level+1,[num,1])-(2*Rx_level+1);
Rx_S = randi(4*Rx_level+1,[num,1])-(2*Rx_level+1);
Rx_M = randi(4*Rx_level+1,[num,1])-(2*Rx_level+1);


%% 周期ズレを考慮して9時～22時までを抜き出し
for k = 1:1:num
    P_Yusyokusya(k,:) = Y_n2(k,num_day+Rx_Y(k));
end

for k = 1:1:num
    P_Syuhu(k,:) = S_n2(k,num_day+Rx_S(k));
end

for k = 1:1:num
    P_Musyoku(k,:) = M_n2(k,num_day+Rx_M(k));
end

%% 表示
if(graph ==1)
    figure()
    plot(daytime,P_Yusyokusya')
    xlabel('Time[h]');
    ylabel('有職者の在宅確率（最終値）');
    figure()
    plot(daytime,P_Syuhu')
    xlabel('Time[h]');
    ylabel('主婦の在宅確率（最終値）');
    figure()
    plot(daytime,P_Musyoku')
    xlabel('Time[h]');
    ylabel('無職の在宅確率（最終値）');
end
%% データの保存
%保存先は読み込みしたフォルダと同じ
if(SAVE==1)
    save('P_Yusyokusya.mat');
    save('P_Syuhu.mat');
    save('P_Musyoku.mat'); 
end

%% 配列まとめる
% 1:有職者　2:主婦　3:無職　4:null
P_parsonal = zeros(27,num,4);
P_parsonal(:,:,1) = P_Yusyokusya'/100;
P_parsonal(:,:,2) = P_Syuhu'/100;
P_parsonal(:,:,3) = P_Musyoku'/100;

P_not = 1-P_parsonal;
%% 家族構成反映
family = [26.9 31.5 20.2 13.9 5.1 2.4]/100;
rand_fam = randsample([1:1:6],NUM,true,family);
job = [56.2 13 16.4]/100;

if(graph ==1)
    figure()
    histogram(rand_fam)
end

Pnot_fam = ones(27,NUM);
job_fam = zeros(NUM,6);
for k = 1:1:NUM
    for m = 1:1:rand_fam(k)
        job_ = randsample([1:1:3],1,true,job);
        Pnot_fam(:,k) =  Pnot_fam(:,k).*P_not(:,(k-1)*6+m,job_);
        job_fam(k,m) = job_;     
    end    
end

if(graph ==1)
    figure()
    histogram(job_fam)
end

P_fam = 1-Pnot_fam;
figure()
plot(daytime,P_fam)
xlabel('TIme [hour]');
ylabel('Probability (someone is at home)');

end