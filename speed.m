%Classfy the transmission speed
[~, ~, strA] =xlsread('F:\Dengue\2018\GZ\Timelag.xls');
strA(1,:)=[];
A=[];
sum=0;
p1=0;p2=0;p3=0;
c=0;p=0;
for i=1:length(strA)
    sum=strA{i,4}+strA{i,5}+strA{i,6};
    if(sum>0)
    p1=strA{i,4}/sum;
    p2=strA{i,5}/sum;
    p3=strA{i,6}/sum;      
    else
        p1=0;p2=0;p3=0;
    end
    if(p1==0&&p2==0&&p3==0)
        c=0;p=0;
    elseif((p1==p2&&p2==p3)||(p2==p3&&p2>p1))
       c=2;p=p2;
    elseif((p1==p2&&p3==0)||(p1==p3&&p1>p2))
        c=1;p=p1;
    end
    if(p1>p2&&p1>p3)
      c=1;p=p1;
    end
     if(p2>p1&&p2>p3)
       c=2;p=p2;
     end
     if(p3>p2&&p3>p1)
         c=3;p=p3;
    end
    A=[A;strA{i,1:4},strA{i,5},strA{i,6},p1,p2,p3,c,p];
end

