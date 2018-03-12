function routine_for_signal_mapping(a)
%%%set up
sg={};
int=12;%%start point: 13 eV
num=40;%%number of division: 20
rang=18;%%total energy range of interest: 12-30 eV 
div=rang/num;%%range of each division: 18 eV/20=0.9 eV
x=[-5:0.05:61.95]';
[m,n,q]=size(a);

%%% normalization based on window [x1,x2] eV, for example, [40 60] eV
x1=0;
x2=60;
y0=reshape(a(1,1,:),[],1);
s0=area_integral([x,y0],x1,x2);
for i =1:m;
    for j=1:n;
        y0=reshape(a(i,j,:),[],1);
        s1=area_integral([x,y0],x1,x2);
        a(i,j,:)=a(i,j,:)/s1*s0;
    end;
end

%%% start integral signal in the interest area and map it
for k=1:num;
    for i =1:m;
        for j=1:n;
            y0=reshape(a(i,j,:),[],1);
            sg{k}(i,j)=area_integral([x,y0],int+k*div,int+div+k*div);
        end;
    end;
end
for k =1:num;
    figure();
    image(sg{k},'CDataMapping','scaled');
    colormap gray;
end
end