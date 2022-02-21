%This is the code for 
%``Quaternion Dictionary Learning and Satuation-Value Total Variation-based
%   Color Image Restoration'',  in IEEE Transactions on Multimedia, doi: 10.1109/TMM.2021.3107162.
%  with Gaussian blur (15,1) and Gaussian noise 12.75

clc
clear 
close all
%load ('0804_15_1_12.75.mat')
[I,ID,h,sigma]= madeblur();
imagname='0804.png';
%crop them for easy to get the test results
%in the real test we test the full original image
I =imcrop(I,[240,210,100,100]);
ID = imcrop(ID,[240,210,100,100]);

%==============================================
%parameter setting
[m,n,c] = size(I);
N = m*n*c;
deblur = 1;
mu = 0.5;
tau = 0.04;
alpha = tau*sqrt((sigma^2)*N);
tt=0.00003;
beta = 0.0004;
iters =100;
epsi = 1*1e-6;
%===============================================
%restoration
[IND,Im_out,Weight,Psnr,iter]= QCTV_ADMM2(I, ID, alpha, beta, iters, mu, deblur, h, epsi, sigma,tt);
y = 1:iter;
plot(y,Psnr)

SSIM = ssim(IND,I);
PSNR = psnr(IND,I);
imshow(cat(2,I,ID,IND));
drawnow;
title(['Deblurring     ',num2str(psnr(I,ID),'%2.2f'),'dB','    ',num2str(PSNR,'%2.2f'),'dB'],'FontSize',12)
  









