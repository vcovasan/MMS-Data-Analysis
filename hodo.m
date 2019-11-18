function hodo(a1, a2, a3, a4, a5, a6)
%
% Function:
%    hodo(time, data)
%    hodo(time, data, start, stop)
%    hodo(time, data, vec, val)
%    hodo(time, data, start, stop, vec, val)
% Description:
%    Plots hodogram of data
% Args:
%    time .... array of times
%    data .... main data array, either n x 2 or n x 3 
%    start ... start index within array
%    stop .... stop index within array
%    vec ..... matrix of eigen values
%    val ..... array of eigen vectors
% Return:
%    None
% Defaults:
%    start=1, stop=size(data,1), vec=0, val=0
%

% set default args
start=1; stop=size(a2,1); vec=0; val=0;

% deal with supplied args
if nargin >= 2
  ttt=a1; data=a2;
  if nargin == 6
    start=a3; stop=a4; vec=a5; val=a6;
  elseif nargin == 4
    if numelem(a3) == 9 && numelem(a4) == 3
      vec=a3; val=a4;
    elseif numelem(a3) == 1 && numelem(a4) == 1
      start=a3; stop=a4;
    end
  end
else
  error('Incorrect input args to hodo');
end

dd=data(start:stop,:);
tt=ttt(start:stop);

[~, nc]=size(dd);
if nc == 2
  dim=2;
elseif nc == 3
  dim=3;
end

%figs;      % square figure
dim=3;
% set plot erase mode to xor
if dim == 2
  mag=sqrt(dd(:,1).^2+dd(:,2).^2);
  figure('position', [6 6 600 300]);
  subplot(121);plot(dd(:,1),dd(:,2));
  subplot(122);plot(mag);
elseif dim == 3
  mag=norm(dd);
  xmin=min(dd(:,1));xmax=max(dd(:,1));
  ymin=min(dd(:,2));ymax=max(dd(:,2));
  zmin=min(dd(:,3));zmax=max(dd(:,3));
  xmid=mean([xmin xmax]); xrng=xmax-xmin;
  ymid=mean([ymin ymax]); yrng=ymax-ymin;
  zmid=mean([zmin zmax]); zrng=zmax-zmin;
  delta=max([xrng yrng zrng])*1.1;
  xmaxlim=xmid+delta/2.; xminlim=xmid-delta/2.;
  ymaxlim=ymid+delta/2.; yminlim=ymid-delta/2.;
  zmaxlim=zmid+delta/2.; zminlim=zmid-delta/2.;

  subplot('position', [.1 .1 .4 .4]);
  plot(dd(:,1),dd(:,2));hold on;plot(dd(1,1),dd(1,2),'x');
  axis([xminlim xmaxlim yminlim ymaxlim]);
  axis equal
  xlabel('Component 1 (nT)');ylabel('Component 2 (nT)');
  for i=1:length(dd(:,1))-1
    arrowhead(dd(i+1,1:2), dd(i,1:2), 0.5);
  end

  subplot('position', [.1 .5 .4 .4]);
  plot(dd(:,1),dd(:,3));hold on;plot(dd(1,1),dd(1,3),'x');
  axis([xminlim xmaxlim zminlim zmaxlim]);
  axis equal
  set(gca, 'xaxislocation', 'top');
  xlabel('Component 1 (nT)');ylabel('Component 3 (nT)');

  subplot('position', [.5 .5 .4 .4]);
  plot(dd(:,2),dd(:,3));hold on;plot(dd(1,2),dd(1,3),'x');
  axis([yminlim ymaxlim zminlim zmaxlim]);
  axis equal
  set(gca, 'xaxislocation', 'top', 'yaxislocation', 'right');
  xlabel('Component 2 (nT)');ylabel('Component 3 (nT)');

  if numelem(vec) == 9                     % if eig val/vecs given,
    subplot('position', [.5 .05 .4 .2]);   % use two small panels
    set(gca, 'visible', 'off');
    text(.05, .70, 'Time:');
    if tt(1) < 1e8 % msday
      text(.25, .70, [ms2str(tt(1),1), '-', ms2str(tt(length(tt)),1)]);
    else         %msad
      text(.25, .70, [tnum2str(tt(1),1), '-', tnum2str(tt(length(tt)),21)]);
    end
    text(.05, .40, 'Vec:');
    text(.25, .40, num2str(vec, 3));
    text(.05, .05, 'Val:');
    text(.25, .05, num2str(val, 3));
    subplot('position', [.5 .3 .4 .2]);
  else
    subplot('position', [.5 .1 .4 .4]);    % else use whole space
  end
  plot(mag);
  set(gca, 'yaxislocation', 'right');
  xlabel('point num'); ylabel('Magnitude (nT)')

end

