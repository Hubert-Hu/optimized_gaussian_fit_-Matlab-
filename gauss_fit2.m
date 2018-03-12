function [a_fit,gauss]=gauss_fit2(X1,X2,Y,int,ed)

%% set up:
stp=(X(end)-X(1))/(length(X)-1);
 [n1,n2]=get_number([int,ed],X(1),stp);
 X=X(n1:n2);
 Y=Y(n1:n2);

% rough guess of initial parameters
a7 = min(Y);
a3 = ((max(X1)-min(X1))/10).^2;
a2 = (max(X1)+min(X1))/2;
a1 = max(Y)*a3;
a6 = ((max(X2)-min(X2))/10).^2;
a5 = (max(X2)+min(X2))/2;
a4 = max(Y)*a3;

a21 = min(X) + (max(X)-min(X))/3;
a22 = min(X) + (max(X)-min(X))/3 * 2;
%a0 = [a1,a2,a3];
a0 = [a1,a2,a3,a4,a5,a6,a7];
%a0 = [a1,a21,a3,a1,a22,a3,a4];

%% R2=1-SSE/SST
% define lorentz inline, instead of in a separate file
gauss = @(param, x1, x2) param(1)*exp(-((x1-param(2))./param(3)).^2) + param(4)*exp(-((x2-param(5))./param(6)).^2) + param(7);
% ERF fit
%gauss = @(param,x) param(1)*(1-erf((x-param(2))./param(3))) + param(4);

%gauss = @(param, x) param(1)./((x - param(2)).^2 + param(3)) + param(4);
%gauss = @(param, x) param(1)./((x - param(2)).^2 + param(3)) + param(4)./((x - param(5)).^2 + param(6)) + param(7);
%expfit = @(param, x) param(1)*exp(param(2)*x+param(3)) + param(4); 


% define objective function, this captures X and Y
%fit_error = @(param) sum((Y - gauss(param, X)).^2);
fit_error = @(param) sum((Y - gauss(param, X1, X2)).^2)/sum((Y - mean(Y)).^2);
%fit_error = @(param) sum((Y - expfit(param, X)).^2)/sum((Y - mean(Y)).^2);
% do the fit
a_fit = fminsearch(fit_error, a0);

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