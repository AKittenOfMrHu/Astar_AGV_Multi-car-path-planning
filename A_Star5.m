%多小车进货过程
clear;
%占用情况
%蓝色车架优先级
A=[1,3,2,5,7,6];%[1,3,2,5,4,7,6,8]
%绿色车架优先级
B=[3,7,6,4,2];%[1,3,5,7,8,6,4,2]
%紫色车架优先级
C=[4,8,5,3,1];%[2,4,6,8,7,5,3,1]
%蓝色车头优先级
D=[1,3,5,2,4,8];%[1,3,5,7,2,4,6,8]
%绿色车头优先级
E=[8,4,2,3,5,7];%[8,6,4,2,1,3,5,7]
%紫色车头优先级
F=[7,8,6,3,1];%[7,8,5,6,3,4,1,2]
 %占用时删除相应货架优先级数列的对应货位，并且在下面对应矩形内加上'FaceColor','color'
% Obtain Obstacle, Target and Robot Position
% Initialize the MAP with input values
% Obstacle=-1,Target = 0,Robot=1,Space=2
MAX_X=64;
MAX_Y=63;
MAX_VAL=10;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y));
j=0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1])
grid on;
hold on;
n=0;%Number of Obstacles
x = 1 : 65;
y = 1 : 64;
x1 = [x(1) x(end)]';
y1 = [y(1) y(end)]';
x2 = repmat(x1, 1, length(y)-2);
x3 = repmat(x(2) : x(end-1), 2, 1);
xData = [x2 x3];
y2 = repmat(y1, 1, length(x)-2);
y3 = repmat(y(2) : y(end-1), 2, 1);
yData = [y3 y2];
h = line(xData, yData);
box on;
set(h, 'Color', 'w');
rectangle('Position',[1,4,1,5],'Curvature', [0 0], 'FaceColor','m');
rectangle('Position',[1,15,1,5],'Curvature', [0 0], 'FaceColor','g');
rectangle('Position',[1,26,1,5],'Curvature', [0 0], 'FaceColor','b');
rectangle('Position',[1,34,1,5],'Curvature', [0 0], 'FaceColor','m');
rectangle('Position',[1,45,1,5],'Curvature', [0 0], 'FaceColor','g');
rectangle('Position',[1,56,1,5],'Curvature', [0 0], 'FaceColor','b');
rectangle('Position',[64,4,1,5],'Curvature', [0 0], 'FaceColor','m');
rectangle('Position',[64,15,1,5],'Curvature', [0 0], 'FaceColor','g');
rectangle('Position',[64,26,1,5],'Curvature', [0 0], 'FaceColor','b');
rectangle('Position',[64,34,1,5],'Curvature', [0 0], 'FaceColor','m');
rectangle('Position',[64,45,1,5],'Curvature', [0 0], 'FaceColor','g');
rectangle('Position',[64,56,1,5],'Curvature', [0 0], 'FaceColor','b');
rectangle('Position',[7,4,5,3],'linewidth',1,'EdgeColor','b','FaceColor','b');
rectangle('Position',[12,4,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[7,12,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,12,5,3],'linewidth',1,'EdgeColor','b','FaceColor','b');
rectangle('Position',[7,20,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,20,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[7,28,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,28,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[7,34,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,34,5,3],'linewidth',1,'EdgeColor','b','FaceColor','b');
rectangle('Position',[7,42,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,42,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[7,50,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,50,5,3],'linewidth',1,'EdgeColor','b','FaceColor','b');
rectangle('Position',[7,58,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[12,58,5,3],'linewidth',1,'EdgeColor','b');
rectangle('Position',[27,4,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[32,4,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[27,12,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[32,12,5,3],'linewidth',1,'EdgeColor','g','FaceColor','g');
rectangle('Position',[27,20,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[32,20,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[27,28,5,3],'linewidth',1,'EdgeColor','g','FaceColor','g');
rectangle('Position',[32,28,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[27,34,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[32,34,5,3],'linewidth',1,'EdgeColor','g','FaceColor','g');
rectangle('Position',[27,42,5,3],'linewidth',1,'EdgeColor','g','FaceColor','g');
rectangle('Position',[32,42,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[27,50,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[32,50,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[27,58,5,3],'linewidth',1,'EdgeColor','g','FaceColor','g');
rectangle('Position',[32,58,5,3],'linewidth',1,'EdgeColor','g');
rectangle('Position',[47,4,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[52,4,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[47,12,5,3],'linewidth',1,'EdgeColor','m','FaceColor','m');
rectangle('Position',[52,12,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[47,20,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[52,20,5,3],'linewidth',1,'EdgeColor','m','FaceColor','m');
rectangle('Position',[47,28,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[52,28,5,3],'linewidth',1,'EdgeColor','m','FaceColor','m');
rectangle('Position',[47,34,5,3],'linewidth',1,'EdgeColor','m','FaceColor','m');
rectangle('Position',[52,34,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[47,42,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[52,42,5,3],'linewidth',1,'EdgeColor','m','FaceColor','m');
rectangle('Position',[47,50,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[52,50,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[47,58,5,3],'linewidth',1,'EdgeColor','m');
rectangle('Position',[52,58,5,3],'linewidth',1,'EdgeColor','m','FaceColor','m');
%% BEGIN Interactive Obstacle, Target, Start Location selection
pause(1);
h=msgbox('请指定进货口');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('请指定进货口','Color','black');
but=1;
i=1;
ATarget=[];
while (but == 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
    if(but==1)
        ATarget(i,1)=i;
        ATarget(i,2)=xval;
        ATarget(i,3)=yval;
        i=i+1;
        plot(xval+.5,yval+.5,'gd');
        text(xval+1,yval+.5,'Target')
    end
end

pause(1);
 
h=msgbox('请指定小车分布，右键结束');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('请指定小车分布，右键结束 ','Color','black');
but=1;
i=1;
AStart=[];
while (but == 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
    if(but==1)
        AStart(i,1)=i;
        AStart(i,2)=xval;
        AStart(i,3)=yval;
        i=i+1;
        plot(xval+.5,yval+.5,'bo');
    end
end




num=min(size(AStart,1),size(ATarget,1));
AUsedCarIndex=[];

%PathALL=[];
SizePath=[];
aa=[];
PathALL(1)=libpointer('int16PtrPtr',aa);
for inx=1:1:num
    crash_points=[];
    xTarget=ATarget(inx,2);%X Coordinate of the Target
    yTarget=ATarget(inx,3);%Y Coordinate of the Target

  
    [UsedCarIndex,Path1,Path2,Path3]=find_car_and_path(AStart,xTarget,yTarget,AUsedCarIndex,crash_points,A,B,C,D,E,F);
    
  
    
    newPath=Path3;
   
    if inx>1
        for jnx=1:1:inx-1

            tempt_Path=get(PathALL(jnx+1),'Value');
            size_tempt_Path=size(tempt_Path,1);

            find_crash=1;
            num_crash_points=0;
            while find_crash==1

                size_newPath=size(newPath,1);
                count=min(size_newPath,size_tempt_Path);

                kdx=1;
                while kdx<count
                   if (newPath(size_newPath-kdx+1,1)==tempt_Path(size_tempt_Path-kdx+1,1))&&(newPath(size_newPath-kdx+1,2)==tempt_Path(size_tempt_Path-kdx+1,2))||(((newPath(size_newPath-kdx+1,1)==tempt_Path(size_tempt_Path-kdx,1))&&(newPath(size_newPath-kdx+1,2)==tempt_Path(size_tempt_Path-kdx,2)))&&((newPath(size_newPath-kdx,1)==tempt_Path(size_tempt_Path-kdx+1,1))&&(newPath(size_newPath-kdx,2)==tempt_Path(size_tempt_Path-kdx+1,2))))
                        num_crash_points=num_crash_points+1;
                        crash_points(num_crash_points,1)=newPath(size_newPath-kdx+1,1);
                        crash_points(num_crash_points,2)=newPath(size_newPath-kdx+1,2);
                       
                        [UsedCarIndex,Path1,Path2,Path3]=find_car_and_path(AStart,xTarget,yTarget,AUsedCarIndex,crash_points,A,B,C,D,E,F);
                        newPath=Path3;

                        kdx=1000000000;%用于结束小循环
                    end
                    kdx=kdx+1;
                end
                if kdx<100000
                    find_crash=0;
                end
            end
        end
    end
    AUsedCarIndex(inx,1)=UsedCarIndex; 
    PathALL(inx+1)=libpointer('int16PtrPtr',newPath);
    
end

% for inx=2:1:size(PathALL,2)
%     Path3=get(PathALL(inx),'Value');
%     j=size(Path3,1);%get(c(1),'Value')
%     %Plot the Optimal Path!
%     p=plot(Path3(j,1)+.5,Path3(j,2)+.5,'bo');
%     j=j-1;
%     for i=j:-1:1
%         pause(.1);
%         set(p,'XData',Path3(i,1)+.5,'YData',Path3(i,2)+.5);
%         drawnow ;
%     end
%     plot(Path3(:,1)+.5,Path3(:,2)+.5,'LineWidth',1);
% 
% end
path1=[];
path2=[];
path3=[];
num_Path=size(PathALL);
for inx=1:1:num_Path(2)
    if inx==2
        path1=get(PathALL(2),'Value');
    elseif inx==3
        path2=get(PathALL(3),'Value');
    elseif inx==4
        path3=get(PathALL(4),'Value');
    end
end
Lpath1=size(path1,1);
Lpath2=size(path2,1);
Lpath3=size(path3,1);
j=max(max(Lpath1,Lpath2),Lpath3);
 %Plot the Optimal Path!
 p=plot(path1(size(path1,1),1)+.5,path1(size(path1,1),2)+.5,'bo');
 j=j;
 for i=j:-1:1%打印小车所在位置
  pause(.25);
  if (j-i<Lpath1)&&(j-i<Lpath2)&&(j-i<Lpath3)
    set(p,'XData',[path1(Lpath1-j+i,1)+.5,path2(Lpath2-j+i,1)+.5,path3(Lpath3-j+i,1)+.5],'YData',[path1(Lpath1-j+i,2)+.5,path2(Lpath2-j+i,2)+.5,path3(Lpath3-j+i,2)+.5],'Color','r');
  elseif(j-i<Lpath1)&&(j-i+3<Lpath2)&&(j-i>=Lpath3)
    set(p,'XData',[path1(Lpath1-j+i,1)+.5,path2(Lpath2-j+i-3,1)+.5],'YData',[path1(Lpath1-j+i,2)+.5,path2(Lpath2-j+i-3,2)+.5],'Color','r');  
  elseif(j-i<Lpath1)&&(j-i>=Lpath2)&&(j-i<Lpath3)
  set(p,'XData',[path1(Lpath1-j+i,1)+.5,path3(Lpath3-j+i,1)+.5],'YData',[path1(Lpath1-j+i,2)+.5,path3(Lpath3-j+i,2)+.5],'Color','r');
  elseif(j-i>=Lpath1)&&(j-i<Lpath2)&&(j-i<Lpath3)  
    set(p,'XData',[path2(Lpath2-j+i,1)+.5,path3(Lpath3-j+i,1)+.5],'YData',[path2(Lpath2-j+i,2)+.5,path3(Lpath3-j+i,2)+.5],'Color','r');
  elseif(j-i<Lpath1)&&(j-i>=Lpath2)&&(j-i>=Lpath3)
       set(p,'XData',path1(Lpath1-j+i,1)+.5,'YData',path1(Lpath1-j+i,2)+.5,'Color','r');
  elseif    (j-i>=Lpath1)&&(j-i<Lpath2)&&(j-i>=Lpath3)
       set(p,'XData',path2(Lpath2-j+i,1)+.5,'YData',path2(Lpath2-j+i,2)+.5,'Color','r');
  elseif(j-i>=Lpath1)&&(j-i>=Lpath2)&&(j-i<Lpath3)
       set(p,'XData',path3(Lpath3-j+i,1)+.5,'YData',path3(Lpath3-j+i,2)+.5,'Color','r');
  else
      
  end
  
   %if j-i<Lpath2
   % set(p,'XData',path2(Lpath2-j+i,1)+.5,'YData',path2(Lpath2-j+i,2)+.5);
  %end
 drawnow ;
 end;
 %%打印小车轨迹
 plot(path1(:,1)+.5,path1(:,2)+.5,'LineWidth',1);
 plot(path2(:,1)+.5,path2(:,2)+.5,'LineWidth',1);
 plot(path3(:,1)+.5,path3(:,2)+.5,'LineWidth',1);


