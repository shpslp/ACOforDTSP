function HP_Log = TourLog(Tour,model,v) 
    A=model.D(Tour,Tour);
    D_Log=spdiags(A,1); % Pick the distance log
    T_Log = cumsum(D_Log)/v; % Convert length to time
    T_index = quantiz(T_Log,1:numel(model.P(:,1))-1) + 1;    % Quantization
    HP_Log=model.P(T_index,1:model.n);     % Home Probability (+0.01 Offset)
end