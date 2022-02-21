function [wx,wy] = TV_shrinkage(DX,DY,lambdawx,lambdawy,alpha,beta,mu)
%THe shrinkage of w
%by Chaoyan Huang
% July, 11, 2020

 s1 = sqrt((DX(:,:,1)-lambdawx(:,:,1)/beta).^2+(DX(:,:,2)-lambdawx(:,:,2)/beta).^2+(DY(:,:,1)-lambdawy(:,:,1)/beta).^2+(DY(:,:,2)-lambdawy(:,:,2)/beta).^2);
 s1(s1 == 0) = 1e-3;
 
 s2 = sqrt((DX(:,:,3)-lambdawx(:,:,3)/beta).^2+(DY(:,:,3)-lambdawy(:,:,3)/beta).^2);
 s2(s2 == 0) = 1e-3;
 
s= sqrt(s1.^2+s2.^2);
s(s==0)=1e-3;

wx(:,:,3) = max(0, s-alpha*mu/beta).*(DX(:,:,3)-lambdawx(:,:,3)/beta)./s;
wx(:,:,1) = max(0, s-alpha/beta).*(DX(:,:,1)-lambdawx(:,:,1)/beta)./s;
wx(:,:,2) = max(0, s-alpha/beta).*(DX(:,:,2)-lambdawx(:,:,2)/beta)./s;

wy(:,:,3) = max(0, s-alpha*mu/beta).*(DY(:,:,3)-lambdawy(:,:,3)/beta)./s;
wy(:,:,1) = max(0, s-alpha/beta).*(DY(:,:,1)-lambdawy(:,:,1)/beta)./s;
wy(:,:,2) = max(0, s-alpha/beta).*(DY(:,:,2)-lambdawy(:,:,2)/beta)./s;
