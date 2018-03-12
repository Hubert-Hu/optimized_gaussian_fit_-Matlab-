function err=gauss_fit_error(X,Y,x1,x2)

%% set up:
%[r1,r2]=transform_constraint(X,Y,rg1,rg2,x1,x2);
% % r2= r1 + delta + (X(end)-r1-delta)*sin(x2).^2;

delta = 1; %%|r2-r1| > 2*delta, range > 2&delta
r1 = X(1) + ((X(end)-delta)-X(1))*sin(x1).^2;
r2= r1 + delta + (X(end)-r1-delta)*sin(x2).^2;

stp=(X(end)-X(1))/(length(X)-1);

% if min([r1,r2]) <X(1);
%    r2 = max([r1,r2]);
%    r1 = X(1);
% end
% if max([r1,r2] >X(end);
%    r1 = min([r1,r2]);
%    r2 = X(end);
% end
% if abs(r2-r1) < 0.5;
%     if max([r1,r2]) + 0.5 > X(end)
%         r2=X(end);
%         r1=r2-0.5;
%     else
%         r1=min([r2,r1]);
%         r2=r1+0.5;
%     end
% end
[m1,m2]=get_number([r1,r2],X(1),stp);
%fprintf('%.2f, %.2f, %.2f, %.2f\n',r1,r2,m1,m2)
% ym=max(Y(n1:n2));
% nmax=round((ym-X(1))/stp)+1;
% center=X(nmax);


X1=X(m1:m2);
Y1=Y(m1:m2);
% rough guess of initial parameters
a4 = min(Y1);
a3 = ((max(X1)-min(X1))/10)^2;
a2 = (max(X1)+min(X1))/2;
a1 = max(Y1)*a3;

a21 = min(X1) + (max(X1)-min(X1))/3;
a22 = min(X1) + (max(X1)-min(X1))/3 * 2;
%a0 = [a1,a2,a3];
a0 = [a1,a2,a3,a4];
%a0 = [a1,a21,a3,a1,a22,a3,a4];

%% R2=1-SSE/SST
% define lorentz inline, instead of in a separate file
gauss = @(param, x) param(1)*exp(-((x-param(2))./param(3)).^2) + param(4);
%gauss = @(param, x) param(1)./((x - param(2)).^2 + param(3)) + param(4);
%gauss = @(param, x) param(1)./((x - param(2)).^2 + param(3)) + param(4)./((x - param(5)).^2 + param(6)) + param(7);
%expfit = @(param, x) param(1)*exp(param(2)*x+param(3)) + param(4); 


% define objective function, this captures X and Y
%fit_error = @(param) sum((Y - gauss(param, X)).^2);
fit_error = @(param) sum((Y1 - gauss(param, X1)).^2)/sum((Y1 - mean(Y1)).^2);
% do the fit
%options = optimset('Display', 'off');
a_fit = fminsearch(fit_error, a0);

err = fit_error(a_fit);

% err_area=[17.8,24.8];
% [e1,e2]=get_number(err_area,X(1),stp);
% X2=X(e1:e2);
% Y2=Y(e1:e2);
% err = sum((Y2 - gauss(a_fit, X2)).^2)/sum((Y2 - mean(Y2)).^2);

% quick plot

% x_grid = linspace(min(X), max(X), 1000); % fine grid for interpolation
% plot(X, Y, '.', x_grid, lorentz(a_fit, x_grid), 'r')

%legend('Measurement', 'Fit')
%title(sprintf('a1_fit = %g, a2_fit = %g, a3_fit = %g', ...
%    a_fit(1), a_fit(2), a_fit(3)), 'interpreter', 'none')
%fprintf('a1_fit = %g,\n a2_fit = %g,\n a3_fit = %g,\n a4_fit = %g,\n a5_fit = %g,\n a6_fit = %g\n',...
%    a_fit(1), a_fit(2), a_fit(3), a_fit(4),a_fit(5),a_fit(6));

    function [n1,n2]=get_number(x0,a0,stp)
        n1=round((min(x0)-a0)/stp)+1;
        n2=round((max(x0)-a0)/stp)+1;
    end
end