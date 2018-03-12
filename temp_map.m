function [temp,p2,err_z,err_p]=temp_map(im,thick,qz)
t1 = cputime;
x=[-5:0.05:61.95]';
res = 0.05;
h = round(0.05/res);

       [n_xpixel,n_ypixel,n_zpixel]=size(im);
        temp = zeros(n_xpixel,n_ypixel);
        %p1 = zeros(n_xpixel,n_ypixel);
        p2 = zeros(n_xpixel,n_ypixel);
        err_z = zeros(n_xpixel,n_ypixel);
        err_p = zeros(n_xpixel,n_ypixel);
%         [FX, FY] = gradient(thick);
%         Fg = sqrt(FX.^2 + FY.^2);
%         fg_serial = reshape(Fg,[],1);
%         fg_serial = sort(fg_serial);
%         th = round(0.9*length(fg_serial));
%         threshold = fg_serial(1) + 0.3*( fg_serial(th) - fg_serial(1) );
%         %threshold = min(min(Fg)) + 0.08*( max(max(Fg)) - min(min(Fg)) ); 
%         binary = -(sign(Fg-threshold)-1)/2;
%        thick_temp = thick .* binary;
%        [X, Y] = meshgrid([1:n_ypixel],[1:n_xpixel]);

        for i = 1:n_xpixel;
            for j = 1:n_ypixel;
                
                y=reshape(im(i,j,:),[],1,1);
                z=reshape(qz(i,j,:),[],1,1);
                [x_new,y_new,FitError]=align_then_spline(x,y,z,res,h);
                err_z(i,j)=FitError(1);
                %[shift1,shift2,FitError]=find_peak(x_new,y_new);
                [FitResults,FitError]=peakfit([x_new,y_new],22.275,4.95,1,2,13.37,10, [22.0312      10.5211]);
                err_p(i,j)=FitError(1);
                %p1(i,j)=shift1;
                p2(i,j)=FitResults(2);
                temp(i,j)=find_temp(p2(i,j),thick(i,j));
            end
        end

        temp = temp .* binary;

    function [x,y,FitError]=align_then_spline(x,y,z,res,h)
        [x,FitError]=calibrate_zlp(x,z,res);
        %[x,y]=splineplot(x,y,h);
    end

    function [n1,n2]=get_number(x0,a0,stp)
        n1=round((x0(1)-a0)/stp)+1;
        n2=round((x0(2)-a0)/stp)+1;
    end

t2 = cputime;

%     function [shift1,shift2,FitResults,FitError]=find_peak(x,y)
%             try
%                 datamatrix=[x,y];
%                     a=[24.435, 22.035, 23.635, 22.8];
%                     b=[26.35, 21.17, 26.39, 22.04];
%                     err=zeros(2,4);
%                     result=cell(1,4);
%                 try
%                     try 
%                         for ii =1:4;
%                             [FitResults,FitError]=peakfit(datamatrix,a(ii),b(ii),2,2,66.81,10);
%                             result{ii}=FitResults;
%                             err(:,ii) = FitError;
%                         end
%                     catch
%                         for ii =ii+1:4;
%                             [FitResults,FitError]=peakfit(datamatrix,a(ii),b(ii),2,2,66.81,10);
%                             result{ii}=FitResults;
%                             err(:,ii) = FitError;
%                         end
%                     end
%                 catch
%                     try 
%                         for ii =ii+1:4;
%                             [FitResults,FitError]=peakfit(datamatrix,a(ii),b(ii),2,2,66.81,10);
%                             result{ii}=FitResults;
%                             err(:,ii) = FitError;
%                         end
%                     catch
%                         for ii =ii+1:4;
%                             [FitResults,FitError]=peakfit(datamatrix,a(ii),b(ii),2,2,66.81,10);
%                             result{ii}=FitResults;
%                             err(:,ii) = FitError;
%                         end
%                     end
%                 end
%                 del=[];
%                 for ii =1:4;
%                     if err(1,ii) == 0 || err(2,ii) == 0;
%                         del = [del,ii];
%                     end
%                 end
%                 err2=err;
%                 err2(:,del)=[];
%                 jj=0;
%                 for ii =1:4;
%                     if sum(err(:,ii).^2) == min(sum(err2.^2));
%                         jj=ii;
%                     end
%                 end
% 
%                 
%                 FitError=err(:,jj);
%                 FitResults=result{jj}; 
%                 
%                 nx = length(x);
%                 sx = (x(end)-x(1))/(nx-1);
%                 [n1,n2]=get_number([10,30],x(1),sx);
%                 [B,I]=sort(y(n1:n2));
%                 max_n = n1-1+I(end);
%                 if abs(FitResults(1,2)-x(max_n)) < abs(FitResults(2,2)-x(max_n))
%                     shift1 = FitResults(1,2);
%                     shift2 = FitResults(2,2);
%                 else
%                     shift2 = FitResults(1,2);
%                     shift1 = FitResults(2,2);
%                 end
%             catch
%                 fprintf('No. %d Fitting failed.\n',c);
%             end
% 
%     end

    function te = find_temp(p,thick)
        % p = k*t +b, in which k,b depend on thickness.
        kb = [-2.89632 22.90295 
               -1.36776 22.62986 
              -0.76332  22.49
              1 0];
        a_fit = [6.5137      -1.4037      0.70102];
          t_range=[         0.06039      0.11795
      0.11795      0.17551
      0.17551      0.23307
      0.23307      0.29063];
         [mt,nt]=size(t_range);
         thick2 = sign(thick-t_range);
         layer = [1:mt]*(-(thick2(:,1).*thick2(:,2)-1)/2);
        %nl=length(layer);
        %for iii =1:nl;
%             if layer(iii) == 1;
%                 k=1.55714;b=24.30581;
%             elseif layer(iii) == 2
%                 k=1.04229;b=24.86645;
%             end
            k = kb(layer,1);
            b = kb(layer,2);
            %k = -23.49*exp( -0.6534 *thick);
            %b = ;
            te = (p - b)/(k/1000);
        %end
    end
fprintf('Total CPU time used is: %.2f', t2-t1)
end