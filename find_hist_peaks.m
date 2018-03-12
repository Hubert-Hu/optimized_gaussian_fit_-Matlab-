function [xt,ht,pk]=find_hist_peaks(tp)
%div=0.2;
%xt=[max(18,min(tp)):div:min(30,max(tp))];
xt=linspace(max(18,min(tp)),min(30,max(tp)),20);
ht=hist(tp,xt);
pk=findpeaksx(xt,ht,0,1,1,1);

end