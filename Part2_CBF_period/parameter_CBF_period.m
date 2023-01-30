clc
clear all
filename='test.xls'
 data=xlsread(filename);
savepath='deal_data\';

 time_total=30:0.1:(30+0.1*size(data,1))-0.1;
 
%  curve_total=zeros(1000,1000)*nan;
%  time_total=zeros(1000,1000)*nan;
 for i=1:size(data,2)
     curve=data(:,i);
     curve(curve==0)=[];
     time=time_total(1:length(curve))';


curve=smoothdata(curve,'gaussian',2);
 %xmin=find(data2==min(min(data2)));
 xmax=find(curve==max(max(curve)));
%  data1=data1(~isnan(data1));%去掉NAN的无效数据
%  data2=data2(~isnan(data1));

time=time(1:xmax);
curve=curve(1:xmax);

if isempty(curve)
    dot_all=zeros(1,24)
    savedata(i,:)=dot_all;
    continue
end

% figure(),plot(data1,data2);
left_dot=(max(curve)-min(curve))*0.2+min(curve);
right_dot=(max(curve)-min(curve))*0.8+min(curve);

%%第一组数据
x1=interp1(curve,time,left_dot,'pchip');
x2=interp1(curve,time,left_dot,'spline');
x3=interp1(curve,time,left_dot,'makima');

x11=interp1(curve,time,right_dot,'pchip');
x12=interp1(curve,time,right_dot,'spline');
x13=interp1(curve,time,right_dot,'makima');


a1=polyfit([x1,x11],[left_dot,right_dot],1);
%y0=a(1)*x0+a(2);
x00=(min(curve)-a1(2))/a1(1);
detax00=x00-min(time);

a2=polyfit([x2,x12],[left_dot,right_dot],1);
x01=(min(curve)-a2(2))/a2(1);
detax01=x01-min(time);

a3=polyfit([x3,x13],[left_dot,right_dot],1);
x02=(min(curve)-a3(2))/a3(1);
detax02=x02-min(time);

x_all=[x00 x01 x02];
detax_all=[detax00 detax01 detax02];

 xi=min(time):0.001:max(time);
 yi=interp1(time,curve,xi, 'pchip');
  figure(), plot(time,curve,'o' ,xi,yi);
% imshow(img,'Border','tight');
 %set(gcf,'color','white','paperpositionmode','auto');
 set(gcf,'Position',[0,0,1920,962], 'color','w')
 xlabel('Time/s'); ylabel('Blood flow change (%)');
 saveas(gca,[savepath,'pchip_',num2str(i),'.tif']);


 yi1=interp1(time,curve,xi, 'spline');
 figure(), plot(time,curve,'o' ,xi,yi1);
 set(gcf,'Position',[0,0,1920,962], 'color','w')
 xlabel('Time/s'); ylabel('Blood flow change (%)');
 saveas(gca,[savepath,'spline_',num2str(i),'.tif']);

 yi2=interp1(time,curve,xi, 'makima');
  figure(), plot(time,curve,'o' ,xi,yi2);
 set(gcf,'Position',[0,0,1920,962], 'color','w')
 xlabel('Time/s'); ylabel('Blood flow change (%)');
 saveas(gca,[savepath,'makima_',num2str(i),'.tif']);

 dot1=[time(1),curve(1)];
 dot2_1=[x1,left_dot];
 dot2_2=[x2,left_dot];
 dot2_3=[x3,left_dot];
 dot3_1=[x11,right_dot];
 dot3_2=[x12,right_dot];
 dot3_3=[x13,right_dot];
 dot4=[max(time),max(curve)];
 dot_all=[time(end)-time(1) a1,a2,a3,max(curve)-curve(1),dot1,dot2_1,dot2_2,dot2_3,dot3_1,dot3_2,dot3_3,dot4];
 savedata(i,:)=dot_all;
 
 time=[];
 curve=[];
 x1=[];
 x2=[];
 x3=[];
 x11=[];
 x12=[];
 x13=[];
 left_dot=[];
 right_dot=[];
 dot1=[];
 dot2_1=[];
 dot2_2=[];
 dot2_3=[];
 dot3_1=[];
 dot3_2=[];
 dot3_3=[];
 dot4=[]; %均置0以防影响下次判断

 end

B = [{'Time','Group1_pchip(k)','Group1_pchip(b)','Group1_spline(k)','Group1_spline(b)','Group1_makima(k)','Group1_makima(b)','Ymax-Ybegin','dots(min)_x',...
    'y_min','dots(20%)_x1_pchip(k)','y1_20%','dots(20%)_x2_spline(k)','y2_20%','dots(20%)_x1_makima(k)','y3_20%',...
    'dots(80%)_x1_pchip(k)','y1_80%','dots(80%)_x2_spline(k)','y2_80%','dots(80%)_x1_makima(k)','y3_80%','dots(max)_x','y_max'}; num2cell(savedata)];
xlswrite([savepath,'Total_data'],B);

