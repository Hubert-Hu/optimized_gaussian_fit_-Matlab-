function [r1,r2]=transform_constraint(X,Y,rg1,rg2,x1,x2)
stp=(X(end)-X(1))/(length(X)-1);
[n1,n2]=get_number([rg1,rg2],X(1),stp);
[ym,I]=max(Y(n1:n2));
nmax=I+n1-1;
ini_center=X(nmax);

delta = 0.5; %%|r2-r1| > 2*delta
center = ini_center-1+2*sin(x1).^2;
rmin=min(delta,min(abs([rg1,rg2]-center)));
rmax=max(delta,min(abs([rg1,rg2]-center)));
radius = rmin + (rmax-rmin)*sin(x2).^2;
r1=center-radius;
r2=center+radius;
    function [n1,n2]=get_number(x0,a0,stp)
        n1=round((min(x0)-a0)/stp)+1;
        n2=round((max(x0)-a0)/stp)+1;
    end
end