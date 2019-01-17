function c =cost(xS,yS,xT,yT)
%DEFINE THE 2-D MAP ARRAY
MAX_X=64;
MAX_Y=63;
%This array stores the coordinates of the map and the 
%Objects in each coordinate
MAP=2*(ones(MAX_X,MAX_Y));
 
 
xf=xT;
yf=yT;
xf=floor(xf);
yf=floor(yf);
xTarget=xf;
yTarget=yf;
MAP(xf,yf)=0;%Initialize MAP with location of the target
xval=floor(xS);
yval=floor(yS);
xStart=xval;
yStart=yval;
MAP(xval,yval)=1;
 
for i=7:17
    MAP(i,4)=-1;
    MAP(i,31)=-1;
    MAP(i,34)=-1;
    MAP(i,61)=-1;
    MAP(i+20,4)=-1;
    MAP(i+20,31)=-1;
    MAP(i+20,34)=-1;
    MAP(i+20,61)=-1;
    MAP(i+40,4)=-1;
    MAP(i+40,31)=-1;
    MAP(i+40,34)=-1;
    MAP(i+40,61)=-1;
end
 
 
for j=4:31
    MAP(7,j)=-1;
    MAP(7,j+30)=-1;
    MAP(17,j)=-1;
    MAP(17,j+30)=-1;
    MAP(27,j)=-1;
    MAP(27,j+30)=-1;
    MAP(37,j)=-1;
    MAP(37,j+30)=-1;
    MAP(47,j)=-1;
    MAP(47,j+30)=-1;
    MAP(57,j)=-1;
    MAP(57,j+30)=-1;
end


if(yStart>=61||yStart<=4||xStart<=7||xStart>=57)
    if(yStart>=34)
        for i=37:47
            MAP(i,61)=-1;
        end
    else
        for i=17:27
            MAP(i,4)=-1;
        end
    end
end
if(yTarget>=61||yTarget<=4||xTarget<=7||xTarget>=57)
  if(yTarget>=34)
    for i=17:27
        MAP(i,61)=-1;
    end 
  else
     for i=37:47
        MAP(i,4)=-1;
     end
  end
end
 if(yStart<61&&yStart>4&&xStart>17&&xStart<27)
     for i=17:27
         MAP(i,yStart+1)=-1;
     end
 end
 if(yStart<61&&yStart>4&&xStart>37&&xStart<47)
     for i=37:47
         MAP(i,yStart-1)=-1;
     end
 end
 if(yTarget<61&&yTarget>4&&xTarget>17&&xTarget<27)
     for i=17:27
         MAP(i,yTarget-1)=-1;
     end
 end
  if(yTarget<61&&yTarget>4&&xTarget>37&&xTarget<47)
     for i=37:47
         MAP(i,yTarget+1)=-1;
     end
 end
 
 if(xStart<57)
     if(yStart<34&&yStart>31)
         for j=31:34
             MAP(xStart+1,j)=-1;
         end
     end
     for j=31:34
         MAP(57,j)=-1;
     end
     if(xStart<37)
         for j=31:34
             MAP(37,j)=-1;
         end
         if(xStart<17)
             for j=31:34
                 MAP(17,j)=-1;
             end
         end
     end
 end
             
%End of obstacle-Target pickup
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OPEN LIST STRUCTURE
%--------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
%--------------------------------------------------------------------------
OPEN=[];
%CLOSED LIST STRUCTURE
%--------------
%X val | Y val |
%--------------
% CLOSED=zeros(MAX_VAL,2);
CLOSED=[];
 
%Put all obstacles on the Closed list
k=1;%Dummy counter
for i=1:MAX_X
    for j=1:MAX_Y
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i; 
            CLOSED(k,2)=j; 
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
%set the starting node as the first node
xNode=xval;
yNode=yval;
OPEN_COUNT=1;
path_cost=0;
goal_distance=distance(xNode,yNode,xTarget,yTarget);
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_COUNT,1)=0;
CLOSED_COUNT=CLOSED_COUNT+1;
CLOSED(CLOSED_COUNT,1)=xNode;
CLOSED(CLOSED_COUNT,2)=yNode;
NoPath=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
%  plot(xNode+.5,yNode+.5,'go');
 exp_array=expand_array(xNode,yNode,path_cost,xTarget,yTarget,CLOSED,MAX_X,MAX_Y);
 exp_count=size(exp_array,1);
 %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 %--------------------------------------------------------------------------
 %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
 %EXPANDED ARRAY FORMAT
 %--------------------------------
 %|X val |Y val ||h(n) |g(n)|f(n)|
 %--------------------------------
 for i=1:exp_count
    flag=0;
    for j=1:OPEN_COUNT
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if OPEN(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);
                OPEN(j,7)=exp_array(i,4);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        OPEN_COUNT = OPEN_COUNT+1;
        OPEN(OPEN_COUNT,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%End of insert new element into the OPEN list
 end;%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_COUNT=CLOSED_COUNT+1;
  CLOSED(CLOSED_COUNT,1)=xNode;
  CLOSED(CLOSED_COUNT,2)=yNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path
 
i=size(CLOSED,1);
Optimal_path=[];
xval=CLOSED(i,1);
yval=CLOSED(i,2);
i=1;
Optimal_path(i,1)=xval;
Optimal_path(i,2)=yval;
i=i+1;
 
if ( (xval == xTarget) && (yval == yTarget))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index(OPEN,xval,yval),4);%node_index returns the index of the node
   parent_y=OPEN(node_index(OPEN,xval,yval),5);
   
   while( parent_x ~= xStart || parent_y ~= yStart)
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_x,parent_y);
           parent_x=OPEN(inode,4);%node_index returns the index of the node
           parent_y=OPEN(inode,5);
           i=i+1;
    end;
    c=OPEN(size(OPEN,1),8);
else
c=-1;
end
