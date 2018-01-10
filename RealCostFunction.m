function cost = RealCostFunction(tour,model,aL)

    cost = TourLength(tour,model) + aL*(model.n-numel(tour));

end