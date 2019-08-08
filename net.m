function net()
%%
load('data1.mat','feature1');
warning off all

SamNum=15;                  %������������
HiddenUnitNum=10;            %�м�����ڵ�����
ForcastSamNum=1;            %Ԥ����������
InDim=400;                  %��������ά��(xx*yyÿ����Ƭ����ֵ����
OutDim=1;                   %�������ά��

%%ѵ����������
p=feature1;
%ת��
p=p';
%%ѵ���������(�ֶ�����)
t=[9.98 11.16 12.42 13.09 10.93 12.31 13.23 14.62 12.22 13.36 14.94 16.46...
   12.17 13.1 15.04];


 [SamIn,pvalue] = mapminmax(p);  %ԭʼ������������������ʼ��(��һ��)
 [SamOut,tvalue] = mapminmax(t); 

 rand('state',sum(100*clock))   %����ϵͳʱ�����Ӳ��������������rand��ʼ״̬

MaxEpochs=20000;                              %ѵ������Ϊ20000
lr=0.035;                                     %ѧϰ����Ϊ0.035
E0=1*10^(-5);                              %Ŀ�����
W1=0.5*rand(HiddenUnitNum,InDim)-0.25;   %��ʼ���������������֮���Ȩֵ
B1=0.5*rand(HiddenUnitNum,1)-0.25;       %��ʼ���������������֮�����ֵ
W2=0.5*rand(OutDim,HiddenUnitNum)-0.25; %��ʼ���������������֮���Ȩֵ
B2=0.5*rand(OutDim,1)-0.25;                %��ʼ���������������֮�����ֵ

ErrHistory=[];
HistoryW1=[];
HistoryB1=[];
HistorydB1=[];
for i=1:MaxEpochs
    HiddenOut=1./(1+exp(-(W1*SamIn+repmat(B1,1,SamNum)))); % ������������� 20*15
    NetworkOut=W2*HiddenOut+repmat(B2,1,SamNum);    % ������������ 1*15
    Error=SamOut-NetworkOut;                     % ʵ��������������֮��
    SSE=sumsqr(Error);                            %�������������ƽ���ͣ�
    
    ErrHistory=[ErrHistory SSE];
    
    if SSE<E0,break, end
    % ����Ȩֵ����ֵ��
    Delta2=Error;
    Delta1=W2'*Delta2.*HiddenOut.*(1-HiddenOut);
    dW2=Delta2*HiddenOut';      %1*8                  
    dB2=Delta2*ones(SamNum,1);   %1*1
    dW1=Delta1*SamIn';
    dB1=Delta1*ones(SamNum,1);
    %���������������֮���Ȩֵ����ֵ��������
    W2=W2+lr*dW2;
    B2=B2+lr*dB2;
    %���������������֮���Ȩֵ����ֵ��������
    W1=W1+lr*dW1;
    HistorydB1=[HistorydB1 dB1];
    HistoryB1=[HistoryB1 B1];
    HistoryW1=[HistoryW1 W1];
    B1=B1+lr*dB1;
    
end
save nets 






