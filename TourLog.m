function [T_Log HP_Log] = TourLog(Tour,model,v)
    N =numel(Tour);
    T_Log = [0];
    for i=1:N-1
        T_Log(i+1) = model.D(Tour(i),Tour(i+1))/v;
    end
    T_Log = cumsum(T_Log);
    T_index = quantiz(T_Log,1:1:47) + 1;    % Quantization RÅ®[1,48]
    HP_Log=model.P(T_index,1:model.n);     % Home Probability (+0.01 Offset)
end