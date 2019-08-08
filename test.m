function [] = test()
%导入矩阵归一化变量
load('nets.mat');
% load('bestnets.mat');
warning off all
xx=20;
yy=20;
%%
%批量测试
anew=zeros(1,6);
for i=16:21
    for jj=1
        s1='FlowPhoto\';
        s2=int2str(i);s22='_';s222=int2str(jj);
        s3='.jpg';
        str=strcat(s1,s2);
        str=strcat(str,s22);
        str=strcat(str,s222);
        str=strcat(str,s3);
        I=imread(str);
        Pho=rgb2gray(I);
        M2=double(Pho(501:2800,501:4500));
        num=1;
        for j=1:xx
            for k=1:yy                
                temp_num1=size(M2,1)./xx;
                temp_num2=size(M2,2)./yy;
                temp=M2((j-1)*temp_num1+1:j*temp_num1,(k-1)*temp_num2+1:k*temp_num2);
                [u,temp1,v]=svd(temp);
                temp2=temp1(num,num);
                pnew(1,(j-1)*yy+k)=temp2;
            end
        end
        pnew=pnew'; 
        pnewn=tramnmx(pnew,pvalue.xmin,pvalue.xmax);        
        HiddenOut=1./(1+exp(-(W1*pnewn+repmat(B1,1,ForcastSamNum))));
        anewn=W2*HiddenOut+repmat(B2,1,ForcastSamNum);     
        anew(i-15)= postmnmx(anewn,tvalue.xmin,tvalue.xmax);
        pnew=pnew'; %循环还会用到pnew恢复转置
    end
end
truethrust=[10.95 12.66 12.29 13.67 13.42 15.29];
% truethrust=[981.49 1134.76 1022.28 1137.07 1033.59 1177.61];
ThrustErr = sqrt(sum((anew-truethrust).^2));
save('thrust.mat','anew','ThrustErr','truethrust')
%%
% %单张测试
% I=imread('FlowPhoto\2_1.jpg');
% % I=imread('F:\羽流照片\2019.01.22\第二组测试样本\16_1.jpg');
% Pho=rgb2gray(I);
% M2=double(Pho(501:2800,501:4500));
% num=1;
% for j=1:xx
%     for k=1:yy                
%         %将图片的灰度矩阵划分成400块小矩阵
%         temp_num1=size(M2,1)./xx;
%         temp_num2=size(M2,2)./yy;
%         temp=M2((j-1)*temp_num1+1:j*temp_num1,(k-1)*temp_num2+1:k*temp_num2);
%         %对每个小矩阵进行SVD变换
%         [u,temp1,v]=svd(temp);
%         %提取最大的SVD系数作为特征值
%         temp2=temp1(num,num);
%         %第i组第jj张照片的特征值 1*400
%         pnew(1,(j-1)*yy+k)=temp2;
%     end
% end
% pnew=pnew'; 
% pnewn=tramnmx(pnew,pvalue.xmin,pvalue.xmax);         %预测样本输入归一化
% HiddenOut=1./(1+exp(-(W1*pnewn+repmat(B1,1,ForcastSamNum))));%隐藏层输出
% anewn=W2*HiddenOut+repmat(B2,1,ForcastSamNum);           % 输出层输出预测结果
% 
% %把网络预测得到的数据还原为原始的数量级；
% anew = postmnmx(anewn,tvalue.xmin,tvalue.xmax) %输出归一化还原
