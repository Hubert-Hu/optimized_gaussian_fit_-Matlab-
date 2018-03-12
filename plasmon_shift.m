function [v1,v2]=plasmon_shift_align(p1,p2,pos1,pos2,unit1,unit2,div)
[m1,n1]=size(p1);
[X1,Y1]=meshgrid([1:m1]-pos1(1),[1:n1]-pos1(2));
X1=X1*unit1;Y1=Y1*unit1;

[m2,n2]=size(p2);
[X2,Y2]=meshgrid([1:m2]-pos2(1),[1:n2]-pos2(2));
X2=X2*unit2;Y2=Y2*unit2;
[X2q,Y2q]=meshgrid([X2(1):div:X2(end)],[Y2(1):div:Y2(end)]);
Vq=interp2(X2,Y2,p2,X2q,Y2q,'spline');
fnx=@(x) round((x-X2(1))/div)+1;
fny=@(x) round((x-Y2(1))/div)+1;
lx=fnx(X1(1,:))';
ly=fny(Y1(:,1))';
for i =1:m1;
    for j =1:n1;
        if lx(i) == 0 && ly(i) == 0
            v2
        end
    end
end