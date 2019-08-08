function [] = trainread()
clc,clear;
%%
%读取照片组，转化为灰度图，截取区域,此处读取1-1到15-1照片
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
        M1(:,:,i)=double(Pho(501:2800,501:4500));%截取照片区域尺寸1500*4000
    end
end
save('trainphoto','M1');