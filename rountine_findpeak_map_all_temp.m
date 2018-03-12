function [peak,err]=rountine_findpeak_map_all_temp(qk)

[m,n]=size(qk);
x=[-5:0.05:61.95]';
peak=cell(m,n);
err=cell(m,n);

for i=1:m;
    for j = 1:n;
    [p,e]=rountine_findpeak_map(qk{i,j});
    peak{i,j}=p;
    err{i,j}=e;
    end
end


