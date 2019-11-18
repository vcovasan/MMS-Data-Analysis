function [nn nnn]=norm_mods(a1, a2, a3, a4, a5, a6, a7, a8, a9)
%
% Function:
%    n=norm_mods(x, y, z, bdy, model)
%    n=norm_mods([x y z], bdy, model)
% Description:
%    Compute several model mp normals at position (x,y,z)
% Args:
%    x ..... x component of position
%    y ..... y component of position
%    z ..... z component of position
%    bdy ... boundary, either 'mp' - magnetopause, 'bs' - bow shock
%    model . model to use (all assume rotational symmetry)
%            mp models 'rs'            Roelof and Sibeck
%                      'fairfield1'    Fairfield meridian 4 deg
%                      'fairfield2'    Fairfield meridian no 4 deg
%                      'farris'        Farris
%                      'petrinec1'     Petrinec Bz gt 0
%                      'petrinec2'     Petrinec Bz lt 0
%                      'formisano1'    Formisano un-normalised z=0
%                      'formisano2'    Formisano normalised z=0
%      a                'user'          user defined params (e, x0, y0)
%            bs models
%                      'peredo'        Peredo
%                      'sh'            Slavin and Holzer
%                      'fairfield1'    Fairfield meridian 4 deg
%                      'fairfield2'    Fairfield meridian no 4 deg
%                      'formisano'     Formisano un-normalised
%                      'farris'        Farris
%                      'user'          user defined params (e, x0, y0)
%                      'saturn'        Saturnian shock (Masters 2008)
%                      'venus'         Venusian shock (Zhang 2008)
% Return:
%    n ..... n X 3 matrix of normal directions
% Ref:
%    Conic parameters come from
%    Analysis methods for multi-spacecraft data
%    Ch. 10  ISSI Scientific report SR-001
%

if length(a1) == 1
  if nargin < 5, model='farris'; else model = a5; end
  if nargin < 4, bdy = 'bs'; else bdy = a4; end
  if nargin < 3, error('norm_mods: bad arg list.');
  else x=a1; y=a2; z=a3; end
elseif length(a1) == 3
  if nargin < 3, model='farris'; else model = a3; end
  if nargin < 2, bdy = 'bs'; else bdy = a2; end
  if nargin < 1, error('norm_mods: bad arg list.');
  else x=a1(1); y=a1(2); z=a1(3); end
else
  error('norm_mods: bad arg list.');
end

disp(['X ', num2str(x)]);disp(['Y ', num2str(y)]);disp(['Z ', num2str(z)]);
disp(['model: ', model]);
disp(['bdy: ', bdy]);

switch char(upper(bdy))
  case 'MP',
    switch char(model)
      case 'rs',         % Roelof and Sibeck
        n=calc_model(x,y,z,0.91,0,4.82,0);
      case 'fairfield1', % Fairfield meridian 4 deg
        n=calc_model(x,y,z,0.79,-0.3,3.6,0.4);
      case 'fairfield2', % Fairfield meridian no 4 deg
        n=calc_model(x,y,z,0.80,-1.5,3.9,0.6);
      case 'farris',     % Farris
        n=calc_model(x,y,z,0.43,3.8,0,0);
      case 'petrinec1',  % Petrinec Bz gt 0
        n=calc_model(x,y,z,0.42,0,0,0);
      case 'petrinec2',  % Petrinec Bz lt 0
        n=calc_model(x,y,z,0.50,0,0,0);
      case 'formisano1', % Formisano un-normalised z=0
        n=calc_model(x,y,z,0.82,4.2,4.1,0.1);
      case 'formisano2', % Formisano normalised z=0
        n=calc_model(x,y,z,0.69,6.6,0.9,-0.4);
      case 'user',       % User defined parameters
        x0=a6;
        y0=a7;
        e=a8;
        a=a9;
        n=calc_model(x,y,z,e,a,x0,y0);
      otherwise,
        error(['bdy_norm: Bad model specification - ', char(model)]);
    end
  case 'BS',
    switch char(model)
      case 'peredo',     % Peredo
        n=calc_model(x,y,z,0.98,0,2.0,0.3);
      case 'slavin and holzer',         % Slavin and Holzer
        n=calc_model(x,y,z,1.16,0,3.0,0);
      case 'fairfield1', % Fairfield meridian 4 deg
        n=calc_model(x,y,z,1.02,4.8,3.4,0.3);
      case 'fairfield2', % Fairfield meridian no 4 deg
        n=calc_model(x,y,z,1.05,5.2,4.6,0.4);
      case 'formisano',  % Formisano un-normalised
        n=calc_model(x,y,z,0.97,3.6,2.6,1.1);
      case 'farris',     % Farris
        n=calc_model(x,y,z,0.81,3.8,0,0);
      case 'user',       % User defined parameters
        x0=a6;
        y0=a7;
        e=a8;
        a=a9;
        n=calc_model(x,y,z,e,a,x0,y0);
      case 'saturn',   % Masters saturnian shock
        n=calc_model(x,y,z,1.05, 0, 0, 0);
      case 'venus1',   % Zhang venusian shock
        n=calc_model(x,y,z,0.621, 0, 0, 0);
      otherwise,
        error(['bdy_norm: Bad model specification - ', char(model)]);
    end
  otherwise,
    error(['bdy_norm: Bad boundary specification - ', char(bdy)]);
end
end
%==============================================================

function nn=calc_model(x,y,z,e,a,x0,y0)
% assume z0=0
z0=0;
xaxis=[1 0 0];

a=deg2rad(a);
abmtx=[cos(a) -sin(a) 0; ...
       sin(a)  cos(a) 0; ...
         0       0    1];

pos_abd=(abmtx*[x;y;z])-[x0;y0;z0];

r = sqrt(pos_abd(1)^2+pos_abd(2)^2+pos_abd(3)^2);
npos=pos_abd./r;
angle = acos( dot( npos, xaxis));
k = r * ( 1 + ( e * cos ( angle ) ) )

nor(1) = ( 1-e^2) * pos_abd(1) + e * k;
nor(2) = pos_abd(2);
nor(3) = pos_abd(3);
               
nnorm = sqrt(nor(1)^2+nor(2)^2+nor(3)^2);

nn = nor./nnorm;

%disp_array(nn, 'normal 1');
sprintf('Normal 1:');
nn


%===================================================

mtx=[ (pos_abd(1)*(1-e^2) + e*k)*cos(a) + pos_abd(2)*sin(a); ...
     -(pos_abd(1)*(1-e^2) + e*k)*sin(a) + pos_abd(2)*cos(a); ...
      pos_abd(3)];

divs=2*k/norm(pos_abd)*mtx;

nnn=divs/norm(divs);
%disp_array(nnn, 'normal 2');
sprintf('Normal 2:');
nnn'
end
                
