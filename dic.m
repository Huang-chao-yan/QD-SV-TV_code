function [DD,a, Im_out, Weight]=dic( Im, iter, sigma)
%generate D and a and RDa RR
%Im_out \sum RDa
%Weight \sum RR
%by Chaoyan Huang
%July 5,2020

%[m n] = size(Im(:,:,1)); % size of input image
bb = 8;                  % size of each block
step = 2;
dict_size = 256;       % dictionary size
Out_iter = 10;
L = 5;                 % number of non-zero coeficients for each representation      
patch_size = bb;       % image patch size
num_patch = 10002;  
C = 1.15;
errorGoal = sigma*C;
Reduce_DC =1;

%update dictionary
% (step 1)D, alpha
% [temp_X] = sample_patches(Im, patch_size, num_patch); 
%    learned dictionary form noisy image 
%    temp_X(:,ii)=temp(:); temp is 8*8*3,192*10002
% [D, output]=DictTraining_our(temp_X,dict_size,L,Out_iter);
%y = 1:Out_iter;
%plot(y,output.totalerr)
% saveas(gcf,'error.png')
 load ('dict_256_atoms.mat')
 D = Dictionary;

%(step 2)alpha
    [blocks,idx] = Q_im2col(Im, bb, step);%transfer image Y into quaternion.
    for jj=1:10000:size(blocks,2)
        jump_size = min(jj+10000-1,size(blocks,2));
        if (Reduce_DC)
            mean_R = repmat(mean(blocks(:,jj:jump_size,2)),size(blocks(:,jj:jump_size,:),1),1);
            mean_G = repmat(mean(blocks(:,jj:jump_size,3)),size(blocks(:,jj:jump_size,:),1),1);
            mean_B = repmat(mean(blocks(:,jj:jump_size,4)),size(blocks(:,jj:jump_size,:),1),1);
            blocks(:,jj:jump_size,2) = blocks(:,jj:jump_size,2) - mean_R;
            blocks(:,jj:jump_size,3) = blocks(:,jj:jump_size,3) - mean_G;
            blocks(:,jj:jump_size,4) = blocks(:,jj:jump_size,4) - mean_B;
           % blocks(:,:,1)=zeros(bb^2,size(blocks,2));% %the result shows bolck(:,:,1)=0,sparisty=3.7446
        end    

         Coefs = QOMPerr_our(D, blocks(:,jj:jump_size,:),errorGoal); 
      
        if (Reduce_DC)
            blocks(:,jj:jump_size,:) = Qmult(D,Coefs);
            blocks(:,jj:jump_size,2) = blocks(:,jj:jump_size,2) + mean_R;
            blocks(:,jj:jump_size,3) = blocks(:,jj:jump_size,3) + mean_G;
            blocks(:,jj:jump_size,4) = blocks(:,jj:jump_size,4) + mean_B;
            %blocks(:,:,1)=zeros(bb^2,size(blocks,2));%DA=0 %result shows  blocks(:,:,1)=0,sparisty=0
        else
            blocks(:,jj:jump_size,:) = Qmult(D,Coefs);
           % blocks(:,:,1)=zeros(bb^2,size(blocks,2)); %DA=0 %result shows  ,sparisty=6.7437
        end
    end
    
    Im_out = zeros(size(Im));
    Weight = zeros(size(Im));

for ii=1:3
    tmp_Blks = blocks(:,:,1+ii);
    [rows,cols] = ind2sub(size(Im_out(:,:,ii))-bb+1,idx); % revise required
    count = 1;
    for jj = 1:length(rows)
        row = rows(jj);
        col = cols(jj);
        blk = reshape(tmp_Blks(:,count,:),[bb bb]);
        Im_out(row:row+bb-1,col:col+bb-1,ii) = Im_out(row:row+bb-1,col:col+bb-1,ii)+blk;
        Weight(row:row+bb-1,col:col+bb-1,ii) = Weight(row:row+bb-1,col:col+bb-1,ii)+1;
        count = count+1;
    end
end
DD=D;
a=Coefs;
    
