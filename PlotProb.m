%% Plot Home Probability
function PlotProb(HP_Log,Tour,model,Dyn)%#ok

HP_Tour = HP_Log(:,Tour);
HP_point = diag(HP_Tour);
n=numel(HP_Tour(1,:));
fHand = figure('Position',[200 200 640 480]);
aHand = axes('parent', fHand);
hold(aHand, 'on');
colorbar
ylabel('Probability')
xlabel('Visited Index')
for j = 1:n
    for i = 1:n
        color = HP_Tour(j,:)./max(max(HP_Tour));
        ind = quantiz(64*color,1:63)+1;
        ind2color = colormap;
        ind2color(ind,:);
        bar(i, HP_Tour(j,i), 'parent', aHand, 'facecolor', ind2color(ind(i),:));
    end
stem(j,HP_point(j),...
    'Marker','+',...
    'LineStyle','none',...
    'MarkerSize',15,...
     'MarkerFaceColor',ind2color(ind(j),:),...
     'MarkerEdgeColor','k')
 frame = getframe(3);
 im{j} = frame2im(frame);
 pause(0.001)

end          
    plot(1:n,HP_point,'r','LineWidth',1.5);
    p=10;
    for i=1:p
    frame = getframe(3);
    im{n+i} = frame2im(frame);
    end
    if Dyn==1
        filename = 'Dynamic_Home_Probability.gif';
    else
        filename = 'Static_Home_Probability.gif';
    end
    for i=1:n+p
        [A,map] = rgb2ind(im{i},256);
        if i==1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.3);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.3);
        end
        
    end

end