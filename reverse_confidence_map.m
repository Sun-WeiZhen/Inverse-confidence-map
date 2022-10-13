clc
clear 
close all
imgUS = imread('C:\Users\DELL\Desktop\Policy Distillation\IM_0018\1.jpg');
imgUS = rgb2gray(imgUS);
sizeimg = size(imgUS);
H = sizeimg(1);
W = sizeimg(2);
cent_img = [fix(H*0.5),fix(W*0.5)];
top_img = [0,fix(W*0.5)];
%imshow(imgUS);
rev_img = [];
alpha = 0.007 ;%声波衰减系数
figure(1);
imshow(imgUS);  % 显示图像
for i = 1:1:H-1
    for j =1:1:W-1
        point = [i,j];
        I0 = imgUS(i,j);
        d_piex=sqrt((point(1)-top_img(1))*(point(1)-top_img(1))+(point(2)-top_img(2))*(point(2)-top_img(2)));
        if I0 == 0
            rev_img(i,j) = 0;
        else
            rev_img(i,j) = I0*exp((-2)*alpha*d_piex);
        end
        %rev_img(i,j) = I0;
    end
end
%rev_img = im2uint8(rev_img);
rev_img = mat2gray(rev_img);
figure(2);
imshow(rev_img,[]);  % 显示图像
%hold on;
%plot(fix(W*0.5),1,'*r');  % 标定相应的点
%imwrite(gr,'C:\Users\DELL\Desktop\ultrasound image intelligibility assessment\confidence_US\abc.jpg')







