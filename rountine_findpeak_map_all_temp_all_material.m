function [peak,err]=rountine_findpeak_map_all_temp_all_material(qm,qz)
tic
peak=cell(length(qm),1);
err=cell(length(qm),1);
%zlp=cell(length(qm),1);
%errz=cell(length(qm),1);
for i =1:length(qm);
    qk=qm{i};
    [peak{i},err{i}]=rountine_findpeak_map_all_temp(qk);
    %[zlp{i},errz{i}]=rountine_zlp_map_all_temp(qz{i});
end
toc
