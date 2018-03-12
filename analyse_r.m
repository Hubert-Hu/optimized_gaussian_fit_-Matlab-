function result=analyse_r(r)
tic
a=length(r);
result=cell(a,1);
for i =1:a;
    [b,c]=size(r{i});
    temp_result=cell(1,c);
    for k =1:c; 
        for j =1:b;
            temp_result{k}(j,:)=r{i}{j,k}';
        end
    end
    result{i}=temp_result;
end
toc