function [zlp,err]=rountine_zlp_map(a)
%% set up
[m,n,q]=size(a);
zlp=zeros(m,n);
err=zeros(m,n);
x=[-5:0.05:61.95]';
gauss = @(param, x) param(1)*exp(-((x-param(2))./param(3)).^2) + param(4);
fit_error = @(param,X,Y) sum((Y - gauss(param, X)).^2)/sum((Y - mean(Y)).^2);
range=[-2,2];
%range=[2,9];
delta=1;
x1=asin(sqrt((range(1)-x(1))/((x(end)-delta)-x(1))));
x2=asin(sqrt((range(2)-range(1)-delta)/(x(end)-range(1)-delta)));
[m1,m2]=get_number(range,x(1),0.05);
g=[1,1];
%% find peak for each point using auto fit
for i =1:m;
    for j=1:n;
    y0=reshape(a(i,j,:),[],1);
    %guess_center=est_max(x,y0,range(1),range(2));
    %half=min(abs([range(1),range(2)]-guess_center),2);
    [a_fit,gauss]=gauss_fit(x,y0,range(1),range(2));
    err(i,j)=fit_error(a_fit,x(m1:m2),y0(m1:m2));
    zlp(i,j)=a_fit(2);
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
