function [] = trainprocess()
%��i��ĵ�jj����Ƭ����Ϊxx*yy��С����,��ȡ����ֵ
load('trainphoto.mat','M1');
xx=20;
yy=20;
for i=1:15
    for jj=1
        %��ȡ����ֵ
        num=1;
        for j=1:xx
            for k=1:yy             
                %��ͼƬ�ĻҶȾ��󻮷ֳ�400��С����
                temp_num1=size(M1,1)./xx;
                temp_num2=size(M1,2)./yy;
                temp=M1((j-1)*temp_num1+1:j*temp_num1,(k-1)*temp_num2+1:k*temp_num2,i);
                %��ÿ��С�������SVD�任
                [u,temp1,v]=svd(temp);
                %��ȡ����SVDϵ����Ϊ����ֵ
                temp2=temp1(num,num);
                %��i���jj����Ƭ������������ 1*400
                feature1((i-1)+jj,(j-1)*yy+k)=temp2;
            end
        end        
    end
end
save('data1','feature1');
%�ó����Ϊ����ֵ����ÿ�д���һ����Ƭ��ÿ��Ԫ�ش���ǰ��Ƭĳһλ��С���������ֵ
