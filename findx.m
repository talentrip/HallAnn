clc
clear;
loopnum=1;
TarErrHistory=[];
if 'bestnets'
    load('bestnets','SetErr')
else
    SetErr = 1000;
end
while loopnum<=100
    net();
    test();
    load('thrust.mat','anew','ThrustErr');
    load nets;
    TarErrHistory=[TarErrHistory ThrustErr];
    if ThrustErr<=SetErr
        SetErr=ThrustErr;
        save('bestnets.mat','pvalue','tvalue','W1','B1','W2','B2',...
            'ForcastSamNum','MaxEpochs','lr','E0','ErrHistory','HistoryB1'...
            ,'HistorydB1','SetErr');
    end
    loopnum=loopnum+1;
end
save('History','TarErrHistory')
