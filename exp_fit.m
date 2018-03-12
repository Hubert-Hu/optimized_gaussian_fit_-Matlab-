function [a_fit,expfit]=exp_fit(X,Y)

% simulate some data
% X = linspace(0,100,200);
% Y = 20./((X-30).^2+20)+0.08*randn(size(X));

% rough guess of initial parameters
a4 = 20;
%a3 = ((max(X)-min(X))/10)^2;
a3 = -max(Y)*0.99;
%a2 = -(max(Y)-min(Y))/(max(X)-min(X));
a1 = max(Y);
a2 = log((Y(1)-a3)/a1)/mean(X);



%a0 = [a1,a2,a3,a4];

% define lorentz inline, instead of in a separate file
%gauss = @(param, x) param(1)*exp(-((x-param(2))./param(3)).^2) + param(4);

a0 = [a1,a2,a3];
expfit = @(param, x) param(1)*exp(param(2)*x) + param(3); 
 
%  a0 = [-1/1000,20];
%  expfit = @(param, x) param(1).*(x.^(-2))+param(2);

% define objective function, this captures X and Y
fit_error = @(param) sum((Y - expfit(param, X)).^2);
%fit_error = @(param) sum((Y - expfit(param, X)).^2)/sum((Y - mean(Y)).^2)

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
end