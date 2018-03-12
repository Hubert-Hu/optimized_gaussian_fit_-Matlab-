function [xt,ht,tp,pk]=make_hist(p,z)
tic
a=length(p);
div=0.21;
num=20;
tp=cell(a,1);
xt=tp;
ht=tp;
pk=tp;
for i =1:a;
    [b,c]=size(p{i});
    temp_p=p{i};
    temp_z=z{i};
    temp_xt=cell(b,c);
    temp_ht=cell(b,c);
    temp_tp=temp_xt;
    temp_pk=temp_xt;
    for j =1:b;
        for k =1:c; 
            temp_tp{j,k}=reshape(temp_p{j,k}-temp_z{j,k},[],1);
            %temp_xt{j,k}=[max(18,min(temp_tp{j,k})):div:min(30,max(temp_tp{j,k})+2)];
            ttp=temp_tp{j,k};
            ttp=ttp(ttp>12);
            ttp=ttp(ttp<30);
            size(ttp);
            temp_xt{j,k}=linspace(max(14,min(ttp)),min(28,max(ttp)+0.5),num);
            temp_ht{j,k}=hist(temp_tp{j,k},temp_xt{j,k});
            temp_pk{j,k}=findpeaksG(temp_xt{j,k},temp_ht{j,k},0,1,1,1);
            if sum(temp_pk{j,k}(:,2)) == 0;
                
            end
        end
    end
    xt{i}=temp_xt;
    ht{i}=temp_ht;
    tp{i}=temp_tp;
    pk{i}=temp_pk;
end
toc