function [ID,blur]=blurnoisy(I,deblur,h,sigma)
%It is the function to generate blur and noisy data
%I is the clean image
%deblur decide blur or not
%h is the blur operator
%sigma is the noise level
%by Chaoyan Huang 
%July 3, 2020

sizeh=size(I(:,:,1));
dim=size(I,3);
otfH = psf2otf(h,sizeh);
% ffth=zeros(m,n);
% t=floor(size(h,1)/2);
% ffth(m/2+1-t:m/2+1+t,n/2+1-t:n/2+1+t)=h;
% ffth= fft2(fftshift(ffth));
if deblur == 1 
    blur=zeros(size(I));
    if dim ==3
        for i=1:3
            f = fft2(I(:,:,i));
            z = otfH.*f;
            B=real(ifft2(z));
            blur(:,:,i)=B;
        end
    else
        error('Input is not color image')
    end
    ID= blur + sigma*randn(size(I));
else
    ID = sigma*randn(size(I));
end

                                    