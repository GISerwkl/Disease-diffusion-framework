clear;clc;
% Define the source and sink 
hwait=waitbar(0,'Please wait>>>>>>>>');
[~, ~, strA] =xlsread('F:\Dengue\2018\GZ\Import_fishnet.xlsx');
[~, ~, strB] =xlsread('F:\Dengue\2018\GZ\Indeginous_fishnet.xlsx');
strA(1,:)=[];
strB(1,:)=[];
A=strA;
B=sortrows(strB,2);
[rowA, colA]=size(A);
for i=1:rowA
    A{i,colA+1}=datenum(A{i,1});
end
[rowB, colB]=size(B);
for i=1:rowB
    B{i,colB+1}=datenum(B{i,1});
end
[IA,ia,~]=unique([A{:,2}]);
[IB,ib,~]=unique([B{:,2}]);
ib=[ib;(rowB+1)];
% Caculate the timelag between imported cases and indigenous cases 
ResultD=[];
for i=1 : rowA
    for j= 1: (length(ib)-1)
        TimeList=[];
        TimePos=[];
        for k= (ib(j)) : (ib(j+1)-1)
            time1=A{i, colA+1};
            time2=B{k, colB+1};
            if (((time2-time1)/7)>=2) && (((time2-time1)/7)<=8)%time buffer
                TimeList=[TimeList;(time2-time1)];
                TimePos=[TimePos;k];
            end
        end
        if ~isempty(TimeList)
            minpos=find(TimeList==min(TimeList));
            Bpos=TimePos(minpos(1));
            ResultD=[ResultD;A(i,1),A(i,2),A(i,3),A(i,4),B(Bpos,1),B(Bpos,2),B(Bpos,3),B(Bpos,4)];
        end
    end
    str=['正在运行中',num2str(i/rowA*100),'%'];
    waitbar(i/rowA,hwait,str);
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',ResultD);
close(hwait);

