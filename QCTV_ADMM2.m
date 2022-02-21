function [IND,Im_out,Weight,Psnr,iter] = QCTV_ADMM2(I, IN, alpha, beta, itera,mu, deblur, h, epsi, sigma,tt)
F = qctv2ctv(IN,0);
[rows, cols, c] = size(F); 
wx0 = zeros(rows, cols, c);
wy0 = zeros(rows, cols, c);
lambdawx = zeros(rows, cols,c); 
lambdawy = zeros(rows, cols,c);
   wx = wx0;
   wy = wy0;
   X_old = zeros(rows, cols,c); 

        [DD,a,Im_out, Weight]=dic(F, itera, sigma);
        [Im_dict] = Qdisp_Dictionary(DD); 
        figure;imshow(Im_dict)
   
 X = FFTsolutionofL2norm_QCTV_init(lambdawx,lambdawy,wx,wy,F,beta,deblur,h,Im_out,Weight,tt);
      
%main loop
for iter = 1:itera     
      Img = de(X,sigma,Im_out,Weight);
      [DX,DY] = ForwardDM(Img);
      [wx,wy] = QCTV_shrinkage(DX,DY,lambdawx,lambdawy,alpha,beta,mu);
       lambdawx = lambdawx+beta*(wx-DX);
       lambdawy = lambdawy+beta*(wy-DY);
      X = FFTsolutionofL2norm_QCTV_init(lambdawx,lambdawy,wx,wy,F,beta,deblur,h,Im_out,Weight,tt);
        
        
if mod(iter, 2) == 0

    IND = ctv2qctv(X,0);
    imagesc(uint8(IND*255));colormap gray;
    drawnow
end

crit = norm(X(:,:,1)-X_old(:,:,1),2)/norm(X_old(:,:,1),2);

if crit<epsi
    
iter
    break
end


X_old = X;



PSNR=psnr(I,ctv2qctv(Img,0));
%SSIM(iter)=ssim(I,ctv2qctv(X,0));
Psnr(iter)=PSNR;

y = 1:iter;
plot(y,Psnr)
end
IND = ctv2qctv(Img,0);












