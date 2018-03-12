function [zlp,err]=rountine_zlp_map_all_temp(qk)

[m,n]=size(qk);
x=[-5:0.05:61.95]';
zlp=cell(m,n);
err=cell(m,n);

for i=1:m;
    for j = 1:n;
    [z0,e0]=rountine_zlp_map(qk{i,j});
    zlp{i,j}=z0;
    err{i,j}=e0;
    end
end
