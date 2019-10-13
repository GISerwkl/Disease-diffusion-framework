% =================Attributes related to imported cases=================
% extract the taxi flow among 678*678 grids
% Calculated based on the results of the previous tensor decomposition
% Reference :Haiyan Tao, Keli Wang, Li Zhuo & Xuliang Li (2019): Re-examining urban region and inferring regional function based on spatial¨Ctemporal interaction, International Journal of Digital Earth,
% DOI: 10.1080/17538947.2018.1425490
load('F:\Dengue\2018\GZ\Result\result_cell_day.mat');
X=tensor(Result);
Y=collapse(X,[1,2]);
Fishnet=double(Y);

xlswrite('F:\Dengue\2018\GZ\Taxi.xlsx',Fishnet);
% Taxi traffic is expressed in probabilistic form
% load('F:\Dengue\2018\GZ\Result\result_cell_day.mat')
%  X1=tensor(Y3266);
%  Y1=collapse(X1,[1,2]);
%  FishnetP=double(Y1);
%  xlswrite('F:\Dengue\2018\GZ\TaxiP.xlsx',FishnetP);
% 
% ================= Import source and sink =================
Sourcesink = csvread ('F:\Dengue\2018\GZ\OD.csv',1,0);

% Match the taxiOD and sourcesink 
[row, col]=size(Fishnet);
ResultOD=[];
for i=1:length(Sourcesink)
    for j=1:row
        for k=1:col
            if((Sourcesink(i,1)==j)&&(Sourcesink(i,5)==k))
               ResultOD=[ResultOD;Sourcesink(i,1:8),Fishnet(j,k)];
            end
        end
     end
end
csvwrite('F:\Dengue\2018\Result\ODresult.csv',ResultOD);


%Caculate the weight of imported cases 
Flow=[];
for n=1:length(Record)
    FlowSum=0;
    Flowlink=0;
    Flowweight=0;
    for m=1:length(ResultOD)
        if(strcmp(ResultOD(m,1),Record(n,1))==1&&(ResultOD{m,2}==Record{n,2}))
            if(ResultOD{m,12}>0)
                Flowweight=Flowweight + ResultOD{m,11}*ResultOD{m,12};
            else
                Flowweight=Flowweight+ ResultOD{m,11};
            end
            FlowSum= FlowSum+ResultOD{m,12};
            Flowlink= Flowlink+FlowSum*Record{n,3};
        end
        %     Flow=[Flow;FlowSum,FlowSum*W(n,1)/num];
    end
    Flow=[Flow;FlowSum,Flowweight,Flowlink];
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',Flow,2,'E');

%Match the population density with imported cases
[~, ~, Pop] =xlsread('F:\Dengue\2018\GZ\pop_fishnet.xlsx');
Pop(1,:)=[];
Pop1=[];
Pop2=[];
PopOD=[];
Pop_im=[];
for l=1:length(Record)
    for p=1:length(Pop)
        if(Record{l,2}==Pop{p,1})
            Pop_im=[Pop_im;Pop{p,2}/1000,Pop(p,3)];
        end
    end
end
xlswrite('F:\Dengue\2018\GZ\OD.xlsx',Pop_im,2,'H');
%Match the population density with source and sink
for q=1:length(ResultOD)
     for o=1:length(Pop)
    if(ResultOD{q,2}==Pop{o,1})
        Pop1=[Pop1;Pop{o,2}/1000,Pop(o,3)];
    end
    if(ResultOD{q,6}==Pop{o,1})
        Pop2=[Pop2;Pop{o,2}/1000,Pop(o,3)];
    end
     end
end















