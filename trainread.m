function [] = trainread()
clc,clear;
%%
%��ȡ��Ƭ�飬ת��Ϊ�Ҷ�ͼ����ȡ����,�˴���ȡ1-1��15-1��Ƭ
for i=1:15
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
        M1(:,:,i)=double(Pho(501:2800,501:4500));%��ȡ��Ƭ����ߴ�1500*4000
    end
end
save('trainphoto','M1');