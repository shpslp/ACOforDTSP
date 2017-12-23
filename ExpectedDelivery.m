function y = ExpectedDelivery(HP_Log,Tour)
   HP_swap = HP_Log(:,Tour);
    y = sum(diag(HP_swap));
end