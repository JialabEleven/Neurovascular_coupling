clear all;
clc;

%compare with mean value of first 30 picture

load mean_data.mat;
mean_data=img3;
load mycolormap.mat
savepath='second_deal_data\';
str='raw_data\';

for ii=1:120
    img=imread([str,num2str(ii),'.tiff']);
    img0=im2double(img(200:2048,100:1948));%cut useless black background
    img1=img0-mean_data;
    [rows,columns]=size(img1);
    %img_stack(:,:,ii)=img1;
%     for p=1:rows
%         for q=1:columns
%             if img1(p,q)>=0
%                 img1(p,q)=0;
%             else 
%                 img1(p,q)=-img1(p,q);
%             end
%         end
%     end
    compare_max0(ii)=max(max(img1));
    compare_min0(ii)=min(min(img1));
end
compare_max=max(compare_max0);
compare_min=min(compare_min0);


for n=1:120
    compare_img=imread([str,num2str(n),'.tiff']);
    compare_img1=im2double(compare_img(200:2048,100:1948));%cut useless black background
    compare_img2=compare_img1-mean_data;
%      figure(),imshow(compare_img2);
    [rows1,columns1]=size(compare_img1);
%     for p=1:rows
%         for q=1:columns
%             if compare_img2(p,q)>=0
%                 compare_img2(p,q)=0;
%             else 
%                 compare_img2(p,q)=-compare_img2(p,q);
%             end
%         end
%     end
%     compare_max=max(max(compare_img2));
%     compare_min=min(min(compare_img2));
    for pp=1:rows1
        for qq=1:columns1
            compare_img3(pp,qq)=(compare_img2(pp,qq)-compare_min)/(compare_max-compare_min);
        end
    end
%     compare_img3 =imresize(compare_img3,[2048 2048]);

    figure(),imshow(compare_img3,'border','tight');
    colormap(mycolormap2) ;%colorbar;
   saveas(gcf,[savepath,num2str(n),'.tif']);

end


