function PlotSolution_g(tour,model)

    tour=[tour tour(1)];
    
    plot(model.x(tour),model.y(tour),'o',...
        'MarkerSize',15,...
        'MarkerFaceColor','g',...
        'LineWidth',1.5);  
    
end