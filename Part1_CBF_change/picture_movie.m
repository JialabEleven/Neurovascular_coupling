clear all;
clc;
str='second_deal_data\';
savepath='final_data\';
for ii=1:120
    img=imread([str,num2str(ii),'.tif']);
    img1=imresize(img,[2048 2048]);
    imwrite(img1,[savepath,'revise',num2str(ii),'.tif']);
end

myobj= VideoWriter('CBF.avi');
myobj.FrameRate=10;
open(myobj)
for i=1:120
    fname = strcat('final_data\revise',num2str(i),'.tif');
    frame = imread(fname);
    writeVideo(myobj, frame);
end
close(myobj)