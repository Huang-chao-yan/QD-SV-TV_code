%clear
function [I,ID,h,sigma]= madeblur()
I = im2double(imread('0804.png'));
  h = fspecial('gaussian',[15,15],1);
sigma=0.05;
ID = imfilter(I, h, 'circular', 'conv') + sigma*randn(size(I));
figure;imshow(I)
figure;imshow(ID)
psnr(I,ID)
ssim(I,ID)
