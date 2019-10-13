% Calculate the number of links for each imported case and indigenous cases 
num=1;
Record=[];
[row,col]=size(ResultD);
ResultD(row+1,:)={999,999,999,999,999,999,999,999};
for i=1:row
    if((ResultD{i,2}==ResultD{i+1,2})&&(strcmp(ResultD(i,1),ResultD(i+1,1))==1))
        num=num+1;
    else
        Record=[Record;ResultD(i,1),ResultD(i,2),num];
        num=1;
    end
     
end
ResultD(row+1,:)=[];
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',Record,2);


% Calculate the distance between the grid where the imported case and indigenous case located 
Dis=[];
for j=1 : row
    D1=[ResultD{j,3},ResultD{j,4}];
    D2=[ResultD{j,7},ResultD{j,8}];
    Dis=[Dis;geodistance(D1,D2)/1000];
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',Dis,1,'I');


%Timelag between imported case and indeigenous case
Lag=[];
for k=1:row
    time5=datenum(ResultD{k,1});
    time6=datenum(ResultD{k,5});
    Lag=[Lag;(time6-time5)/7];
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',Lag,1,'J');

% Sum of the links multiplied by the reciprocal of each OD distance as the weight of the imported case
[~, ~, strC] =xlsread('F:\Dengue\2018\GZ\OD.xlsx');
W=[];
weight=[];
[rowC, colC]=size(strC);
for n=1:length(Record)
    WeightSum=0;
    for m=1:rowC
        if(strcmp(strC(m,1),Record(n,1))==1&&(strC{m,2}==Record{n,2}))
            if(strC{m,9}>0)
                weight=[weight;1/strC{m,9}];
                WeightSum=WeightSum + 1/strC{m,9};
            elseif(strC{m,9}==0)
                 weight=[weight;1];
                WeightSum=WeightSum + 1;
            end
        end
    end  
    WLink=WeightSum*Record{n,3};
    W=[W; WLink];
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',W,2,'D');
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',weight,1,'K');

%Proportion of time lag for each indigenous case 
    TLag=[]; 
    for i= 1:677
    num1=0;num2=0;num3=0;num4=0;num5=0;num6=0; 
    for j= 1:rowC
        if(strC{j,6}==i)
            if(floor(strC{j,10})==2)
                num1=num1+1;
            end if(floor(strC{j,10})==3)
                num2=num2+1;
            end if(floor(strC{j,10})==4)
                num3=num3+1;
            end if(floor(strC{j,10})==5)
                num4=num4+1;
            end if(floor(strC{j,10})==6)
                num5=num5+1;
            end if((strC{j,10}>=7)&&(strC{j,10}<=8))
                num6=num6+1;
            end
        end
        
    end
   TLag=[TLag;i,num1,num2,num3,num4,num5,num6];
end

        
 
        
