function PlotTimeVaring(BestSol,model,HP_Log,Dyn)
    figure('Position', [200 200 640 480])
    nVar = model.n;
    Weight = [];
    Tour = BestSol.Tour;
    Tour=[Tour Tour(1)];
    S = 1:nVar+1;
    T = [S(2:end) 1];
    for i=1:nVar+1
        Weight(i) = round(model.D(Tour(S(i)),Tour(T(i))));
    end
    G = digraph(S,T,Weight);
    h = plot(G,'EdgeLabel',G.Edges.Weight,'XData',model.x(Tour),'YData',model.y(Tour),'MarkerSize',20);
    colorbar
    for t=1:nVar-1
        for j=1:nVar
            color = HP_Log(t,j)/max(max(HP_Log));
            ind = quantiz(64*color,1:63)+1;
            ind2color = colormap;
            highlight(h,j,'NodeColor',ind2color(ind,:))
        end
        highlight(h,[t,t+1],'EdgeColor','r','LineWidth',3)
        frame = getframe(2);
        im{t} = frame2im(frame);
        pause(0.1)
    end
    highlight(h,[nVar,nVar+1],'EdgeColor','r','LineWidth',3)
    frame = getframe(2);
    im{nVar} = frame2im(frame);
    if Dyn==1
        filename = 'Dynamic_Time_Development.gif';
    else
        filename = 'Static_Time_Development.gif';
    end
    for i=1:nVar
        [A,map] = rgb2ind(im{i},256);
        if i==1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.2);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.2);
        end
    end


end