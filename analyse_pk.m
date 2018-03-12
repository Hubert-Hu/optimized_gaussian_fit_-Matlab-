function r=analyse_pk(pk)
tic
a=length(pk);
r=cell(a,1);
for i =1:a;
    [b,c]=size(pk{i});
    temp_r=cell(b,c);
    for k =1:c; 
        d=zeros(b);
        for j =1:b;
            [d(j),e]=size(pk{i}{j,k});
        end
        num=min(d);
        for j =1:b;
            [B,I]=sort(pk{i}{j,k}(:,3));
            temp_r{j,k}=pk{i}{j,k}(I(end-num+1:end),2);
        end
    end
    r{i}=temp_r;
end
toc