function HPReal=RouletteChoice(HPTour)

a=[1 0];

for i=1:numel(HPTour)
    w(i,:)=[HPTour(i) 1-HPTour(i)];
    HPReal(1,i) = a( sum( (rand(1) >= cumsum(w(i,:)./sum(w(i,:))))) + 1 );
end

end