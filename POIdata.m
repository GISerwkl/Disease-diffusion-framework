%Extract thr POIs
[~, ~, strD] =xlsread('F:\Dengue\2018\GZ\POI_fishnet.xlsx');
strD(1,:)=[];
Type=[];
[rowD, colD]=size(strD);
for i=1:rowD
    Type=[Type;floor([strD{i,3}]/10000)];
end
[type,t,~]=unique(floor([strD{:,3}]/10000));
 
%extract the POI classes
POI1=[];POI2=[];POI3=[];POI4=[];POI5=[];POI6=[];POI7=[];POI8=[];POI9=[];POI10=[];POI11=[];POI12=[];POI13=[];POI14=[];POI15=[];
for m=1:rowD
    for n=1:678
        if((strD{m,10}==n)&&(strD{m,11}==type(1)))
        POI1=[POI1;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(2)))
        POI2=[POI2;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(3)))
        POI3=[POI3;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(4)))
        POI4=[POI4;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(5)))
        POI5=[POI5;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(6)))
        POI6=[POI6;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(7)))
        POI7=[POI7;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(8)))
        POI8=[POI8;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(9)))
        POI9=[POI9;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(10)))
        POI10=[POI10;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(11)))
        POI11=[POI11;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(12)))
        POI12=[POI12;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(13)))
        POI13=[POI13;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(14)))
        POI14=[POI14;strD(m,10:11)];
        end
        if((strD{m,10}==n)&&(strD{m,11}==type(15)))
        POI15=[POI15;strD(m,10:11)];
        end
    end
end
%Caculate the number of different categories of POIs
POI=[];
for l=1:678
    num1=0;num2=0;num3=0;num4=0;num5=0;num6=0;num7=0;num8=0;num9=0;num10=0;num11=0;num12=0;num13=0;num14=0;num15=0;
    for k1=1:length(POI1)
        if(POI1{k1,1}==l)
            num1=num1+1;
        end
     
    end
    for k2=1:length(POI2)
        if(POI12{k2,1}==l)
             num2=num2+1;
        end
    end
    for k3=1:length(POI3)
        if(POI3{k3,1}==l)
             num3=num3+1;
        end
    end
    for k4=1:length(POI4)
        if(POI4{k4,1}==l)
             num4=num4+1;
        end
    end
    for k5=1:length(POI5)
        if(POI5{k5,1}==l)
            num5=num5+1;
        end
    end
    for k6=1:length(POI6)
        if(POI6{k6,1}==l)
           num6=num6+1;
        end
    end
    for k7=1:length(POI7)
        if(POI7{k7,1}==l)
             num7=num7+1;
        end
    end
    for k8=1:length(POI8)
        if(POI8{k8,1}==l)
           num8=num8+1;
        end
    end
    for k9=1:length(POI9)
        if(POI9{k9,1}==l)
             num9=num9+1;
        end
    end
    for k10=1:length(POI10)
        if(POI10{k10,1}==l)
             num10=num10+1;
        end
    end
    for k11=1:length(POI11)
        if(POI11{k11,1}==l)
            num11=num11+1;
        end
    end
    for k12=1:length(POI12)
        if(POI12{k12,1}==l)
            num12=num12+1;
        end
    end
    for k13=1:length(POI13)
        if(POI13{k13,1}==l)
             num13=num13+1;
        end
    end
    for k14=1:length(POI14)
        if(POI14{k14,1}==l)
            num14=num14+1;
        end
    end
    for k15=1:length(POI15)
        if(POI15{k15,1}==l)
           num15=num15+1;
        end
    end
    POI=[POI;l,num1,num2,num3,num4,num5,num6,num7,num8,num9,num10,num11,num12,num13,num14,num15];
end
xlswrite('F:\Dengue\2018\GZ\POI.xlsx',POI);


%POI Matches the imported casea 
[~, ~, Import] =xlsread('F:\Dengue\2018\GZ\OD.xlsx',2);
[~, ~, Category] =xlsread('F:\Dengue\2018\GZ\POI.xlsx',1);
[row, col]=size(Import);
POIim=[];
for j=1:row
    for k=1:length( Category)
        if(Import{j,2}== Category{k,1})
            POIim=[POIim;Category(k,1:8)];
        end
    end
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',POIim,2,'J');
% POI matches with OD
P1=[];
P2=[];
POIin=[];
for p=1:length(ResultOD)
    for q=1:length(Category)
        if(ResultOD{p,2}==Category{q,1})
            P1=[P1;ResultOD(p,1:4),Category(q,2:8),ResultOD(p,5:11)];
        end
        if(ResultOD{p,6}==Category{q,1})
            P2=[P2;ResultOD(p,1:8),Category(q,2:8),ResultOD(p,9:11)];
        end
    end
end
POIin=[P1(:,1:11),P2(:,5:18)]; 
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',POIin,3);