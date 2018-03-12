function [a_fit,gauss]=routine_auto_gaussian_fit(X,Y,x1,x2)

%% find peak
range=gauss_fit_area_adjusted(X,Y,x1,x2);

delta = 1; %%|r2-r1| > 2*delta, range > 2&delta
r1 = X(1) + ((X(end)-delta)-X(1))*sin(range(1)).^2;
r2 = r1 + delta + (X(end)-r1-delta)*sin(range(2)).^2;

% delta = 0.5; %%|r2-r1| > delta
% r1 = X(1) + ((X(end)-delta)-X(1))*sin(range(1)).^2;
% r2= r1 + delta + (X(end)-r1-delta)*sin(range(2)).^2;

%[rr1,rr2]=transform_constraint(X,Y,r1,r2,range(1),range(2));

[a_fit,gauss]=gauss_fit(X,Y,r1,r2);

end