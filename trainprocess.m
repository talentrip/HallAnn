function [] = trainprocess()
%第i组的第jj张照片，分为xx*yy个小矩阵,提取特征值
load('trainphoto.mat','M1');
xx=20;
yy=20;
for i=1:15
    for jj=1
        %提取特征值
        num=1;
        for j=1:xx
            for k=1:yy             
                %将图片的灰度矩阵划分成400块小矩阵
                temp_num1=size(M1,1)./xx;
                temp_num2=size(M1,2)./yy;
                temp=M1((j-1)*temp_num1+1:j*temp_num1,(k-1)*temp_num2+1:k*temp_num2,i);
                %对每个小矩阵进行SVD变换
                [u,temp1,v]=svd(temp);
                %提取最大的SVD系数作为特征值
                temp2=temp1(num,num);
                %第i组第jj张照片的特征行向量 1*400
                feature1((i-1)+jj,(j-1)*yy+k)=temp2;
            end
        end        
    end
end
save('data1','feature1');
%得出结果为特征值矩阵，每行代表一张照片，每列元素代表当前照片某一位置小矩阵的特征值
