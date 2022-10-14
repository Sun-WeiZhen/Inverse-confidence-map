clc
clear 
close all
imgUS = imread('C:\Users\DELL\Desktop\Policy Distillation\IM_0018\1.jpg');
imgUSK = rgb2gray(imgUS);
imgUS = rgb2gray(imgUS);
sizeimg = size(imgUS);
% figure(2);
% imshow(imgUS);  % 显示图像
% hold on;
% plot(705,411,'*r');  % 标定相应的点

% 
% imgUS = rgb2gray(imgUS);
% sizeimg = size(imgUS);
% H = sizeimg(1);
% W = sizeimg(2);
% for i = 1:1:H
%     for j = 1:1:W
%         x = j;
%         y = i;
%         yl = line_l(x);
%         yr = line_r(x);
%         e1 = yl-y;
%         e2 = yr-y;
%     end
% end


alpha = 0.00005;
for k = 1:1:40
    alpha = alpha+0.000005;
    %rev_img = shandow_invers_con_mao(alpha,imgUS);
    rev_img = invers_conf_map(alpha,imgUS);
    imwrite(mat2gray(rev_img),['C:/Users/DELL/Desktop/Policy Distillation/confidence_US/',num2str(k),'.jpg']);
    imgUS = rev_img;
end

function yl = line_l(x)
xl1 = 280;
yl1 = 15;
xl2 = 9;
yl2 = 408;
A = yl2 - yl1;
B = xl1 - xl2;
C = xl2*yl1 - xl1*yl2;
kl = -1*(A/B);
bl = -1*(C/B);
yl = kl*x+bl;
end
function yr = line_r(x)
xr1 = 437;
yr1 = 14;
xr2 = 704;
yr2 = 410;
A = yr2 - yr1;
B = xr1 - xr2;
C = xr2*yr1 - xr1*yr2;
kr = -1*(A/B);
br = -1*(C/B);
yr = kr*x+br;
end 

function yl = line_l9(x)
xl1 = 280;
yl1 = 15;
xl2 = 9;
yl2 = 408;
A = yl2 - yl1;
B = xl1 - xl2;
C = xl2*yl1 - xl1*yl2;
kl = -1*(A/B);
bl = -1*(C/B);
yl = kl*x+bl;
end
function yr = line_r9(x)
xr1 = 437;
yr1 = 14;
xr2 = 704;
yr2 = 410;
A = yr2 - yr1;
B = xr1 - xr2;
C = xr2*yr1 - xr1*yr2;
kr = -1*(A/B);
br = -1*(C/B);
yr = kr*x+br;
end 


function img = shandow_invers_con_mao(alpha,imgUS)
rev_img = [];
sizeimg = size(imgUS);
H = sizeimg(1);
W = sizeimg(2);
cent_img = [fix(H*0.5),fix(W*0.5)];
top_img = [0,fix(W*0.5)];
for i = 1:1:H
    for j =1:1:W
        point = [i,j];
        I0 = imgUS(i,j);
        d_piex=sqrt((point(1)-top_img(1))*(point(1)-top_img(1))+(point(2)-top_img(2))*(point(2)-top_img(2)));
        x = j;
        y = i;
        yl = line_l(x);
        yr = line_r(x);
        yl9 = line_l9(x);
        yr9 = line_r9(x);
        e1 = yl-y;
        e2 = yr-y;
        e19 = yl9-y;
        e29 = yr9-y;
        
        if e1>0 && e2>0
            rev_img(i,j) = 0;
        elseif i>45 && i<H-9 && j>9 && j<W-9 && e19<0 && e29<0
            win_img = imgUS(i-7:i+7,j-7:j+7);
            pi_zero = sum(sum(win_img<=10));
            if pi_zero >= 110
                rev_img(i-9:i+9,j-5:j+5) = I0*0.1;
            else
                I0 = I0*1;
            end
        else
            rev_img(i,j) = (I0)*exp((-1.5)*alpha*d_piex);
        end
    end
end
img = rev_img;
%img = mat2gray(rev_img);
%inver_img = rev_img;
end


function img = invers_conf_map(alpha,imgUS)
rev_img = [];
sizeimg = size(imgUS);
H = sizeimg(1);
W = sizeimg(2);
cent_img = [fix(H*0.5),fix(W*0.5)];
top_img = [0,fix(W*0.5)];
for i = 1:1:H
    for j =1:1:W
        point = [i,j];
        I0 = imgUS(i,j);
        d_piex=sqrt((point(1)-top_img(1))*(point(1)-top_img(1))+(point(2)-top_img(2))*(point(2)-top_img(2)));
        x = j;
        y = i;
        yl = line_l(x);
        yr = line_r(x);
        yl9 = line_l9(x);
        yr9 = line_r9(x);
        e1 = yl-y;
        e2 = yr-y;
        e19 = yl9-y;
        e29 = yr9-y;
        if e1>0 && e2>0
            rev_img(i,j) = 0;
        else
            if i>45 && i<H-9 && j>9 && j<W-9 && e19<0 && e29<0
                win_img = imgUS(i-7:i+7,j-7:j+7);
                pi_zero = sum(sum(win_img<=10));
                if pi_zero >= 110
                    %I0 = rand();
                    rev_img(i-2:i+2,j-2:j+2) = I0*0.5;
                else
                    I0 = I0*1;
                end
            else
                I0 = I0*1;
            end
            rev_img(i,j) = (I0)*exp((-2)*alpha*d_piex);
            %rev_img(i,j) = (I0-mean(win_img(:)*0.5))*exp((-2)*alpha*d_piex);
        end
    end
end
img = rev_img;
%img = mat2gray(rev_img);
%inver_img = rev_img;
end




% for i = 1:1:H-1
%     for j =1:1:W-1
%         point = [i,j];
%         I0 = imgUS(i,j);
%         d_piex=sqrt((point(1)-top_img(1))*(point(1)-top_img(1))+(point(2)-top_img(2))*(point(2)-top_img(2)));
%         if I0 == 0
%             rev_img(i,j) = 0;
%         else
%             rev_img(i,j) = I0*exp((-2)*alpha*d_piex);
%         end
%         %rev_img(i,j) = I0;
%     end
% end
% %rev_img = im2uint8(rev_img);
% rev_img = mat2gray(rev_img);

%imwrite(gr,'C:\Users\DELL\Desktop\ultrasound image intelligibility assessment\confidence_US\abc.jpg')







