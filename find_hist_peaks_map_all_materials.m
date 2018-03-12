function [p1,p2]=find_hist_peaks_map_all_materials(p,z)
tic
a=length(p);
p1=cell(a,1);
p2=p1;
for i =1:a;
    [b,c]=size(p{i});
    temp_p=p{i};
    temp_p1=zeros(b,c);
    temp_p2=zeros(b,c);
    for j =1:b;
        for k =1:c; 
            tp=reshape(temp_p{j,k}-z{i}{j,k},[],1);
            [xt,ht,pk]=find_hist_peaks(tp);
            temp_p1(j,k)=pk(1,2);
            [B,I]=sort(ht);
            temp_p2(j,k)=xt(I(end));
        end
    end
    p1{i}=temp_p1;
    p2{i}=temp_p2;
end
toc