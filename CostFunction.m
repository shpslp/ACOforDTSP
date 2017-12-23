function cost = CostFunction(hp_log,tour,model,aL,Dyn)
   cost = TourLength(tour,model) ...
            + Dyn*aL*(model.n-ExpectedDelivery(hp_log,tour));
end