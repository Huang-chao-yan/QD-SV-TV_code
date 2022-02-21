function [wx,wy] = QCTV_shrinkage(DX,DY,lambdawx,lambdawy,alpha,beta,mu)


s1 = sqrt((DX(:,:,1)-lambdawx(:,:,1)/beta).^2+(DX(:,:,2)-lambdawx(:,:,2)/beta).^2+(DY(:,:,1)-lambdawy(:,:,1)/beta).^2+(DY(:,:,2)-lambdawy(:,:,2)/beta).^2);
s1(s1 == 0) = 1e-3;

s2 = sqrt((DX(:,:,3)-lambdawx(:,:,3)/beta).^2+(DY(:,:,3)-lambdawy(:,:,3)/beta).^2);
s2(s2 == 0) = 1e-3;

wx(:,:,3) = max(0, s2-alpha*mu/beta).*(DX(:,:,3)-lambdawx(:,:,3)/beta)./s2;
wx(:,:,1) = max(0, s1-alpha/beta).*(DX(:,:,1)-lambdawx(:,:,1)/beta)./s1;
wx(:,:,2) = max(0, s1-alpha/beta).*(DX(:,:,2)-lambdawx(:,:,2)/beta)./s1;

wy(:,:,3) = max(0, s2-alpha*mu/beta).*(DY(:,:,3)-lambdawy(:,:,3)/beta)./s2;
wy(:,:,1) = max(0, s1-alpha/beta).*(DY(:,:,1)-lambdawy(:,:,1)/beta)./s1;
wy(:,:,2) = max(0, s1-alpha/beta).*(DY(:,:,2)-lambdawy(:,:,2)/beta)./s1;


