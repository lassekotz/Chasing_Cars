function [tout, yout, modeout_str, tin] = run_cars_corr(u, T)
    ts = u(:,1);
    us = u(:,2:end);
    
    tin = 0:0.01:T;
    %tin = ts;
    
    uin = interp1(ts, us, tin, 'previous');
    u = [tin' uin];
    
    assignin('base','u',u);
    assignin('base','T',T);
    
    result = sim('cars_corr', ...
        'StopTime', 'T', ...
        'LoadExternalInput', 'on', 'ExternalInput', 'u', ...
        'SaveTime', 'on', 'TimeSaveName', 'tout', ...
        'SaveOutput', 'on', 'OutputSaveName', 'yout', ...
        'SaveFormat', 'Dataset');
    
    yout = [
        result.yout{1}.Values.Data';
        result.yout{2}.Values.Data';
        result.yout{3}.Values.Data';
        result.yout{4}.Values.Data';
        result.yout{5}.Values.Data'
        ]';
    
    modeout = [
        result.yout{6}.Values.Data';
        result.yout{7}.Values.Data';
        result.yout{8}.Values.Data';
        result.yout{9}.Values.Data'
    ];

    tout = result.tout;
    modeout_str = cellstr(modeout);
    %yout = result.yout;
end