clear;clc;
% Caculate the main direction 
[~, ~, OD] =xlsread('F:\Dengue\2018\GZ\OD回归new.xlsx');
[~, ~, Import] =xlsread('F:\Dengue\2018\GZ\OD回归new.xlsx',2);
OD(1,:)=[];
Import(1,:)=[];
Flow=[];

% Caculate the angle and flow of each OD
for j=1:length(OD)
    AngleOD=atan2d((OD{j,18}-OD{j,6}),(OD{j,17}-OD{j,5}));
%     Angle=mod(AngleOD, 2*pi);
    Flow=[Flow;OD(j,2),OD{j,3:5},OD(j,15),OD{j,16:18},AngleOD,OD{j,31}];
end


%=================Another way=================
%Caculate the flow coordinate of each point 将每个点的流向坐标
% ODflow=[];
% for i=1:length(Flow)
% %     %          if((Flow{i,2}==Flow{i+1,2})&&(strcmp(Flow(i,1),Flow(i+1,1))==1))
% %     if((Flow{i,10}>0))
%         X=Flow{i,3}+Flow{i,10}*cos(Flow{i,9})/100000;
%         Y=Flow{i,4}+Flow{i,10}*sin(Flow{i,9})/100000;
%         ODflow=[ODflow;Flow(i,1:10),X,Y];
% %     end
% end
% %Use 1-4 to indicate the east, west, south and north directions
% FlowA=[];
% [row,col]=size(ODflow);
% for j=1:11
%     num1=0;num2=0;num3=0;num4=0;Flow1=0;Flow2=0;Flow3=0;Flow4=0;
%     sinsum1=0; cossum1=0;sinsum2=0; cossum2=0;sinsum3=0; cossum3=0;sinsum4=0; cossum4=0;
%     for i=1:row
%         if((ODflow{i,2}==Import{j,2})&&(strcmp(ODflow(i,1),Import(j,1))==1))
%             if((ODflow{i,8}>ODflow{i,4})&&(cos(ODflow{i,9})>0))
%                 num1=num1+1;
%                 Flow1=Flow1+ODflow{i,10};
%                 sinsum1=sinsum1+sin(ODflow{i,9}*ODflow{i,10});
%                 cossum1=cossum1+cos(ODflow{i,9}*ODflow{i,10});
%             end
%              Angle1=atand( sinsum1/cossum1);
%             if((ODflow{i,8}>ODflow{i,4})&&(cos(ODflow{i,9})<0))
%                 num2=num2+1;
%                 Flow2=Flow2+ODflow{i,10};
%                  sinsum2=sinsum2+sin(ODflow{i,9}*ODflow{i,10});
%                 cossum2=cossum2+cos(ODflow{i,9}*ODflow{i,10});
%             end
%              Angle2=atand( sinsum2/cossum2);
%             if((ODflow{i,8}<ODflow{i,4})&&(cos(ODflow{i,9})<0))
%                 num3=num3+1;
%                 Flow3=Flow3+ODflow{i,10};
%                 sinsum3=sinsum3+sin(ODflow{i,9}*ODflow{i,10});
%                 cossum3=cossum3+cos(ODflow{i,9}*ODflow{i,10});
%             end
%              Angle3=atand( sinsum3/cossum3);
%             if((ODflow{i,8}<ODflow{i,4})&&(cos(ODflow{i,9})>0))
%                 num4=num4+1;
%                 Flow4=Flow4+ODflow{i,10};
%                 sinsum4=sinsum4+sin(ODflow{i,9}*ODflow{i,10});
%                 cossum4=cossum4+cos(ODflow{i,9}*ODflow{i,10});
%             end
%             Angle4=atand( sinsum4/cossum4);
%         end
%     end
%     FlowA=[FlowA;Import(j,1:5),Import(j,7), num1,Flow1,Angle1,num2,Flow2,Angle2,num3,Flow3,Angle3,num4,Flow4,Angle4];
% end
% 
% 


% Caculate the angle and folw of each imported case
FlowI=[];
for i=1:11
    sinsum=0;
    cossum=0;
    num=0;
    for k=1:length(Flow)
        if((Import{i,2}==Flow{k,2})&&(strcmp(Import(i,1),Flow(k,1))==1))
            sinsum=sinsum+sin(Flow{k,9}*Flow{k,10});
            cossum=cossum+cos(Flow{k,9}*Flow{k,10});
            num=num+1;
        end       
    end
    AngleI=atan2d( sinsum,cossum);
    FlowI=[FlowI;Import(i,1),Import{i,2:5},AngleI,Import{i,7}];
end


%Caculate the weight of main flow 
W=[];
for m=1:length(FlowI)
    Wm=0;
    for n=1:length(Flow)
        if((FlowI{m,2}==Flow{n,2})&&(strcmp(FlowI(m,1),Flow(n,1))==1))
            AngleD=-FlowI{m,6}+Flow{n,9};
            Wm=Wm+cos(AngleD)*Flow{n,10};
        end
    end
   W=[W;FlowI(m,1:7),Wm];
end

%Expression of the main flow of the area. 
%Since the flow of the partial area is much larger than other imported areas, the parameters for controlling the length of the arrow adopt different settings.
%When W{i,7}<100000,k=50000; otherwise k=1000000
MFlow=[];
for i=1:length(W)
%     if(W{i,7}<100000)
        Xd=W{i,3}+W{i,8}*cos(W{i,6})/500000;
        Yd=W{i,4}+W{i,8}*sin(W{i,6})/500000;
%     else
%         Xd=W{i,3}+W{i,8}*cos(W{i,6})/1000000;
%         Yd=W{i,4}+W{i,8}*sin(W{i,6})/1000000;
%     end
    MFlow=[MFlow;W(i,1:4),Xd,Yd,W(i,5:8)];
end
% xlswrite('F:\Dengue\2018\GZ\MainFlow.xlsx',MFlow);


        
        

