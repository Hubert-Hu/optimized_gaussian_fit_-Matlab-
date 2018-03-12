function [v1,v2]=SI_align(p1,p2,z1,z2,pos1,pos2,unit1,unit2,div)
p1=p1-z1;
p2=p2-z2;

[m1,n1]=size(p1);
[X1,Y1]=meshgrid([1:n1]-pos1(1),[1:m1]-pos1(2));
X1=X1*unit1;Y1=Y1*unit1;

[m2,n2]=size(p2);
[X2,Y2]=meshgrid([1:n2]-pos2(1),[1:m2]-pos2(2));
X2=X2*unit2;Y2=Y2*unit2;

[X2q,Y2q]=meshgrid([X2(1):div:X2(end)],[Y2(1):div:Y2(end)]);
Vq=interp2(X2,Y2,p2,X2q,Y2q,'spline');
fnx=@(x) round((x-X2(1))/div)+1;
fny=@(x) round((x-Y2(1))/div)+1;
lx=fnx(X1(1,:))';
ly=fny(Y1(:,1))';
[mmm,nnn]=size(X2q);
num_nag_x=sum(lx<0);
num_up_x=sum(lx>nnn);
num_nag_y=sum(ly<0);
num_up_y=sum(ly>mmm);
v1=zeros(m1-num_nag_y-num_up_y,n1-num_nag_x-num_up_x);
v2=v1;
for i =num_nag_y+1:m1-num_up_y;
    for j =num_nag_x+1:n1-num_up_x;
        v1(i-num_nag_y,j-num_nag_x)=p1(i,j);
        v2(i-num_nag_y,j-num_nag_x)=Vq(ly(i),lx(j));
    end
end