clear all;
clc;

%savepath='D:\20211205-RJY-散斑\data\';
str='raw_data\';
for i=1:30
    img=imread([str,num2str(i),'.tiff']);
    img1=img(200:2048,100:1948);%cut useless black background
    img_stack(:,:,i)=img1;
    %figure(),imshow(img1)
     [rows,columns]=size(img1);
end

mean=0;
% for m=1:30 %test the (1,1) of every stack picture is input
%     img2(1000,1000)=img_stack(1000,1000,m);
%     mean_singledots=img2(1000,1000);
%     mean=mean+mean_singledots;%get the every pixel in picture
%     %mean_img(j,k)=mean_img(j,k)+img2(j,k);
% end




for j=1:rows
    for k=1:columns
        for m=1:30
            img2(j,k)=img_stack(j,k,m);
            mean_singledots=double(img2(j,k)); %Here，we need double because of unit8's max value is just 255.
            mean=mean+mean_singledots;%get every pixel in picture
            %mean_img(j,k)=mean_img(j,k)+img2(j,k);
        end
        img3(j,k)=mean/30;
        mean=0;
    end
end
%img3=uint8(img3);
img3=img3/255;
% figure(),imshow(img3);
% img4=img_stack(:,:,1);
% img5=img_stack(:,:,10);
% img6=img_stack(:,:,20);
% img7=img_stack(:,:,30);
% figure(),imshow(img_stack(:,:,1));

%save D:\20211205-RJY-散斑\mean_data;
save('deal_data\mean_data','img3')

% img5=img_stack(1000:1002,1000:1002,1); test the mean value is no problem
% img6=img_stack(1000:1002,1000:1002,2);
% img7=img_stack(1000:1002,1000:1002,3);
% img8=img_stack(1000:1002,1000:1002,4);
% img9=img_stack(1000:1002,1000:1002,5);
% img10=img_stack(1000:1002,1000:1002,6);
% img11=img_stack(1000:1002,1000:1002,7);
% img12=img_stack(1000:1002,1000:1002,8);
% img13=img_stack(1000:1002,1000:1002,9);
% img14=img_stack(1000:1002,1000:1002,10);



% for j=1:50  %test the input picture is true
% img2=img_stack(:,:,j);
% figure(), imshow(img2);
% end