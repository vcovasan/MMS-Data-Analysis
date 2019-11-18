function [vec, val, max_err, min_err]= minvar(data,order,NB,NF, error_flag)
%
% Function:
%    [vec, val, max_err, min_err]= minvar(data,order,NB,NF, error_flag)
%    [vec, val, max_err, min_err]= minvar(data,order,NB,NF)
%    [vec, val, max_err, min_err]= minvar(data,NB,NF)
%    [vec, val, max_err, min_err]= minvar(data,order)
%    [vec, val, max_err, min_err]= minvar(data)
% Description:
%    Compute eigen values and vectors of a data set and order them
% Arg:
%    data ....... data array n rows by 3 cols
%    order ...... flag - 0=order vals/vecs high to low
%                        1=dont order vals/vecs 
%    NB ......... start index
%    NF ......... end index
%    error_flag . method for calculating errors
%                   0 - Hoppe et al
%                   1 - Khrabrov and Sonnerup
% Return:
%    vec ........ matrix whose cols are eigen vectors
%    val ........ array whose values are eigen values
%    max_err .... max error in max var direction
%    min_err .... max error in min var direction
% Defaults:
%    order=0, NB=1, NF=number of rows, error_flag=0
% References:
%    Sonnerup and Cahill, jgr 72, 171, 1967
%    Hoppe, Russell, Frank, Eastman and Greenstadt, jgr 86, 4471, 1981
%    Khrabrov and Sonnerup, jgr 103, 6641, 1998
%

switch nargin
  case 4
    error_flag=0;
  case 3
    NF=NB;
    NB=order; 
    error_flag=0;
    order=0;
  case 2
    error_flag=0;
    NB=1; NF=size(data, 1);
  case 1
    error_flag=0;
    NB=1; NF=size(data, 1);
    order=0;
end

% fprintf('Parameters\n==========\n\n');
% fprintf('\tNB ........ %d\n', NB);
% fprintf('\tNF ........ %d\n', NF);
% fprintf('\tOrder ..... %d\n', order);
% fprintf('\tErrors .... %d\n', error_flag);
% fprintf('\n');

%if nargin < 5, error_flag=0; end
%if nargin < 4, NB=1; NF=size(data, 1); end
%if nargin < 2, order=0; end

xx=data(NB:NF, 1);
yy=data(NB:NF, 2);
zz=data(NB:NF, 3);
NL=NF-NB+1;

% calculate means
xxa=sum(xx)/(NL);
yya=sum(yy)/(NL);
zza=sum(zz)/(NL);

% remove means
xx=xx-xxa;
yy=yy-yya;
zz=zz-zza;

xs=mean(xx);
ys=mean(yy);
zs=mean(zz);
xys=mean(xx.*yy);
xzs=mean(xx.*zz);
yzs=mean(yy.*zz);
xxs=mean(xx.*xx);
yys=mean(yy.*yy);
zzs=mean(zz.*zz);
B(1,1)=xxs-xs*xs;
B(2,2)=yys-ys*ys;
B(3,3)=zzs-zs*zs;
B(1,2)=xys-xs*ys;
B(1,3)=xzs-xs*zs;
B(2,3)=yzs-ys*zs;
B(3,1)=B(1,3);
B(2,1)=B(1,2);
B(3,2)=B(2,3);

[vec,val]=eig(B);

if order == 0  % sort to max, intermediate, min

  evals=max(val);
  if any(evals<0)
    error('probable negative eigen value');
  end
  [~,i]=sort(evals);
  vec2=[vec(:,i(3)) vec(:,i(2)) vec(:,i(1))];
  vec=vec2;
  val2=[evals(i(3)) evals(i(2)) evals(i(1))];
  val=val2;

  if (det(vec) < -.99) % ie det(vec) == -1
    vec(:,2)=-cross(vec(:,1), vec(:,3));
    if det(vec) == -1, error('LH axes still occur'); end
  end
else
  disp('Not ordering')
  if (det(vec) < -.99) % ie det(vec) == -1
    disp('CAUTION - AXIS ARE LEFT HANDED')
  end
end

% Error estimation

switch (error_flag)
  case 0
%    Hoppe, Russell, Frank, Eastman and Greenstadt, jgr 86, 4471, 1981
%    disp(['Error calc - Hoppe et al'])
    if val(2) ~= val(3)
      min_err=rad2deg(atan(val(3)/(val(2)-val(3))));
    else
      min_err=NaN;
    end
    if val(1) ~= val(2)
      max_err=rad2deg(atan(val(3)/(val(1)-val(2))));
    else
      max_err=NaN;
    end

  case 1
%    Khrabrov and Sonnerup, jgr 103, 6641, 1998
%    disp(['Error calc Khrabrov and Sonnerup']);
    phi=zeros(3);
    for i=1:3
      for j=1:i
        if i ~= j
          phi(i,j)=sqrt((val(3)*(val(i)+val(j)-val(3)))/ ...
                   ((NF-NB)*(val(i)-val(j))^2));
        end
      end
    end

    min_err=rad2deg(phi(3,2)); % error int-min
    max_err=rad2deg(phi(3,1)); % error max-min
  otherwise
    disp(['minvar: method for calculating errors unknown: ', n2s(error_flag)]);
end
