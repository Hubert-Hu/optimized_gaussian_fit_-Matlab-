function [peak,err]=rountine_findpeak_map(a)
%% set up
[m,n,q]=size(a);
peak=zeros(m,n);
err=zeros(m,n);
x=[-5:0.05:61.95]';

% 1 Gaussian
gauss = @(param, x) param(1)*exp(-((x-param(2))./param(3)).^2) + param(4);

% Lorentz fitting:
%gauss = @(param, x) param(1)./((x - param(2)).^2 + param(3)) + param(4);

% 2 Gaussian
%gauss = @(param, x) param(1)./((x - param(2)).^2 + param(3)) + param(4)./((x - param(5)).^2 + param(6)) + param(7);

fit_error = @(param,X,Y) sum((Y - gauss(param, X)).^2)/sum((Y - mean(Y)).^2);
range=[13,32]; % initial range
%range=[2,9];
delta=1; % lower limit of range length
x1=asin(sqrt((range(1)-x(1))/((x(end)-delta)-x(1)))); % we use sin() function which is limited from -1 and 1 to limit the range. This is the inverse change. 
x2=asin(sqrt((range(2)-range(1)-delta)/(x(end)-range(1)-delta)));
[m1,m2]=get_number(range,x(1),0.05);
g=[1,1];
%[r1,r2]=get_number(range,x(1),0.05);
%% find peak for each point using auto fit
for i =1:m;
    for j=1:n;
    y0=reshape(a(i,j,:),[],1);
    % guess initial center:
    %guess_center=est_max(x,y0,range(1),range(2)); 
    % guess initial width:
    %half=min(abs([range(1),range(2)]-guess_center),2); 
    
    [a_fit,gauss]=routine_auto_gaussian_fit(x,y0,x1,x2);
    err(i,j)=fit_error(a_fit,x(m1:m2),y0(m1:m2));
    %re=findpeaksG(x(r1:r2),y0(r1:r2),10,1000,20,10);
    %[B,I2]=sort(re(:,4));
    
    %peak(i,j)=re(I2(end),2);
    peak(i,j)=a_fit(2);
%             if abs(a_fit(2)-21) < abs(a_fit(5)-21) ;
%                 peak(i,j)=a_fit(2);
%             else
%                 peak(i,j)=a_fit(5);
%             end    
    
    end
end

    function ini_center=est_max(X,Y,r1,r2)
        stp=(X(end)-X(1))/(length(X)-1);
        [n1,n2]=get_number([r1,r2],X(1),stp);
        [ym,I]=max(Y(n1:n2));
        nmax=I+n1-1;
        ini_center=X(nmax);
    end
    function [n1,n2]=get_number(x0,a0,stp)
        n1=round((min(x0)-a0)/stp)+1;
        n2=round((max(x0)-a0)/stp)+1;
    end
end
