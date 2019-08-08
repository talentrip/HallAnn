function net()
%%
load('data1.mat','feature1');
warning off all

SamNum=15;                  %输入样本数量
HiddenUnitNum=10;            %中间层隐节点数量
ForcastSamNum=1;            %预测样本数量
InDim=400;                  %网络输入维度(xx*yy每场照片特征值数）
OutDim=1;                   %网络输出维度

%%训练样本输入
p=feature1;
%转置
p=p';
%%训练样本输出(手动输入)
t=[9.98 11.16 12.42 13.09 10.93 12.31 13.23 14.62 12.22 13.36 14.94 16.46...
   12.17 13.1 15.04];


 [SamIn,pvalue] = mapminmax(p);  %原始样本（输入和输出）初始化(归一化)
 [SamOut,tvalue] = mapminmax(t); 

 rand('state',sum(100*clock))   %依据系统时钟种子产生随机数，设置rand初始状态

MaxEpochs=20000;                              %训练次数为20000
lr=0.035;                                     %学习速率为0.035
E0=1*10^(-5);                              %目标误差
W1=0.5*rand(HiddenUnitNum,InDim)-0.25;   %初始化输入层与隐含层之间的权值
B1=0.5*rand(HiddenUnitNum,1)-0.25;       %初始化输入层与隐含层之间的阈值
W2=0.5*rand(OutDim,HiddenUnitNum)-0.25; %初始化输出层与隐含层之间的权值
B2=0.5*rand(OutDim,1)-0.25;                %初始化输出层与隐含层之间的阈值

ErrHistory=[];
HistoryW1=[];
HistoryB1=[];
HistorydB1=[];
for i=1:MaxEpochs
    HiddenOut=1./(1+exp(-(W1*SamIn+repmat(B1,1,SamNum)))); % 隐含层网络输出 20*15
    NetworkOut=W2*HiddenOut+repmat(B2,1,SamNum);    % 输出层网络输出 1*15
    Error=SamOut-NetworkOut;                     % 实际输出与网络输出之差
    SSE=sumsqr(Error);                            %能量函数（误差平方和）
    
    ErrHistory=[ErrHistory SSE];
    
    if SSE<E0,break, end
    % 调整权值（阈值）
    Delta2=Error;
    Delta1=W2'*Delta2.*HiddenOut.*(1-HiddenOut);
    dW2=Delta2*HiddenOut';      %1*8                  
    dB2=Delta2*ones(SamNum,1);   %1*1
    dW1=Delta1*SamIn';
    dB1=Delta1*ones(SamNum,1);
    %对输出层与隐含层之间的权值和阈值进行修正
    W2=W2+lr*dW2;
    B2=B2+lr*dB2;
    %对输入层与隐含层之间的权值和阈值进行修正
    W1=W1+lr*dW1;
    HistorydB1=[HistorydB1 dB1];
    HistoryB1=[HistoryB1 B1];
    HistoryW1=[HistoryW1 W1];
    B1=B1+lr*dB1;
    
end
save nets 






