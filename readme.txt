This is the code for ``Quaternion Dictionary Learning and Satuation-Value 
Total Variation-based Color Image Restoration'',  in IEEE Transactions on Multimedia, doi: 10.1109/TMM.2021.3107162.
with Gaussian blur (15,1) and Gaussian noise 12.75.

%%%%%%%%%
Run main.m  to test the results.

madeblur.m is to generate the degraded images.

dict_256_atoms.mat is the trained dictionary with 800 images of Dataset DIV2K.
If you need to retrain the dic, pleace see dic.m

0804_15_1_12.75.mat is generated from made blur.m

0804.png is the original image from DIV2K.

The cropped image is for parameter setting, in the real test, we test the full image. 

By Chaoyan Huang 
July 2020

