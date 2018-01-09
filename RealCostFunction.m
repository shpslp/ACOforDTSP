function cost = RealCostFunction(tour,model,aL,N)

    cost = TourLength(tour,model) + aL*(N-numel(tour));

end