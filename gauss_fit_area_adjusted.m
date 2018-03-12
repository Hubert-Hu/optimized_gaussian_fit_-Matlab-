function range=gauss_fit_area_adjusted(X,Y,x1,x2)
%% set up ini center
% stp=(X(end)-X(1))/(length(X)-1);
% [n1,n2]=get_number([guess_1,guess_2],X(1),stp);
% ym=max(Y(n1:n2));
% nmax=round((ym-X(1))/stp)+1;
% ini_center=X(nmax);
% 



% define objective function, this captures X and Y
fit_error = @(param) gauss_fit_error(X,Y,param(1),param(2));
% do the fit

%options = optimset('PlotFcns',@optimplotfval);
%range = fminsearch(fit_error, [guess_1,guess_2],options);
options = optimset('Display', 'off','MaxFunEvals',1000);
range = fminsearch(fit_error, [x1,x2],options);