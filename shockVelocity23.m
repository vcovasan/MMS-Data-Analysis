
function [V] = shockVelocity23(i1,i4, N)

epoch1 = spdfcdfread('mms1.cdf', 'Variables', 'Epoch');
epoch4 = spdfcdfread('mms4.cdf', 'Variables', 'Epoch');

eState1 = spdfcdfread('mms1.cdf', 'Variables','Epoch_state');
eState4 = spdfcdfread('mms4.cdf', 'Variables','Epoch_state');

t1=epoch1(i1);
t4=epoch4(i4);

%t12=abs(t2-t1);% all in miliseconds
t14=abs(t4-t1);
%t23=abs(t3-t2);
%t24=abs(t4-t2);

r_gse1 = spdfcdfread('mms1.cdf', 'Variables', 'mms1_fgm_r_gse_srvy_l2'); %read all the x y z and R data
r_gse4 = spdfcdfread('mms4.cdf', 'Variables', 'mms4_fgm_r_gse_srvy_l2');



r1x = r_gse1(:,1); % MMS1 x component of the GSE position vector
r1y = r_gse1(:,2);
r1z = r_gse1(:,3);
r1x = interp1(eState1, r1x, epoch1);
r1y = interp1(eState1, r1y, epoch1);
r1z = interp1(eState1, r1z, epoch1);

sprintf('MMS1 Position at shock crossing:')
[r1x(i1) r1y(i1) r1z(i1)]

% r2x = r_gse2(:,1); % MMS2 x component of the GSE position vector
% r2y = r_gse2(:,2);
% r2z = r_gse2(:,3);
% r2x = interp1(eState1, r2x, epoch1);
% r2y = interp1(eState2, r2y, epoch2);
% r2z = interp1(eState3, r2z, epoch3);
% 
% sprintf('MMS2 Position at shock crossing:')
% [r2x(i2) r2y(i2) r2z(i2)]

r4x = r_gse4(:,1); % MMS4 x component of the GSE position vector
r4y = r_gse4(:,2);
r4z = r_gse4(:,3);
r4x = interp1(eState4, r4x, epoch4);
r4y = interp1(eState4, r4y, epoch4);
r4z = interp1(eState4, r4z, epoch4);

sprintf('MMS4 Position at shock crossing:')
[r4x(i4) r4y(i4) r4z(i4)]

%print the position at every 

%rx=r_gse1(:,1);
%ry=r_gse1(:,2);
%rz=r_gse1(:,3);
% rx = interp1(eState1, rx, epoch1);
% ry = interp1(eState2, ry, epoch2);
% rz = interp1(eState3, rz, epoch3);
% rxyz=[rx ry rz];
%sprintf("The spacecraft position when the shock strikes is:")
%rxyz(i1,:)

minLengthrx=min([length(r1x)  length(r4x)]);
minLengthry=min([length(r1y) length(r4y)]);
minLengthrz=min([length(r1z) length(r4z)]);

r1x=r1x(1:minLengthrx);

r4x=r4x(1:minLengthrx);

r1y=r1y(1:minLengthry);

r4y=r4y(1:minLengthry);

r1z=r1z(1:minLengthrz);

r4z=r4z(1:minLengthrz);




%sx12=abs(r1x-r2x); % these are the separation vectors for each pair 

sx14=abs(r1x-r4x);
%sx23=abs(r2x-r3x);
%sx24=abs(r2x-r4x);


%sy12=abs(r1y-r2y);

sy14=abs(r1y-r4y);
%sy23=abs(r2y-r3y);
%sy24=abs(r2y-r4y);
%sy34=abs(r3y-r4y);

%sz12=abs(r1z-r2z);

sz14=abs(r1z-r4z);
%sz23=abs(r2z-r3z);
%sz24=abs(r2z-r4z);


sprintf('Separations:')
%sep12=sqrt(sx12(i1)^2+sy12(i1)^2+sz12(i1)^2);

sep14=sqrt(sx14(i1)^2+sy14(i1)^2+sz14(i1)^2);
%sep23=sqrt(sx23(i2)^2+sy23(i2)^2+sz23(i2)^2);
%sep24=sqrt(sx24(i2)^2+sy24(i2)^2+sz24(i2)^2);
%sep34=sqrt(sx34(i3)^2+sy34(i3)^2+sz34(i3)^2);
[sep14]

sprintf('dot products of the separations:')
%sepVec12=dot([sx12(i1) sy12(i1) sz12(i1)],N);

sepVec14=dot([sx14(i1) sy14(i1) sz14(i1)],N);
%sepVec23=dot([sx23(i2) sy23(i2) sz23(i2)],N);
%sepVec24=dot([sx24(i2) sy24(i2) sz24(i2)],N);


[sepVec14]


%vx12=sx12/t12;

vx14=sx14/t14;
%vx23=sx23/t23;
%vx24=sx24/t24;


%vy12=sy12/t12;

vy14=sy14/t14;
%vy23=sy23/t23;
%vy24=sy24/t24;


%vz12=sz12/t12;

vz14=sz14/t14;
%vz23=sz23/t23;
%vz24=sz24/t24;


vx=vx14;% see the shape of the tetrahedron to check
vy=vy14;%  which pairs are reliable and which not
vz=vz14;% if too close, discard 

vx=mean(vx)*10^(-1);
vy=mean(vy)*10^(-1);
vz=mean(vz)*10^(-1);

V = [vx vy vz];

r_gse1=r_gse1(:,4); % all in km
%r_gse2=r_gse2(:,4);

r_gse4=r_gse4(:,4);

r1 = interp1(eState1, r_gse1, epoch1);%interpolated distance 
%r2 = interp1(eState2, r_gse2, epoch2);

r4 = interp1(eState4, r_gse4, epoch4);

r1(i1,:)

minLength=min([length(r1),length(r4)]);% normalise wrt the shortest dataset
r1=r1(1:minLength);
%r2=r2(1:minLength);

r4=r4(1:minLength);



%calculate the separations 

s14=sqrt(abs(r1.^2+r4.^2-2.*r1.*r4));
%s23=sqrt(abs(r2.^2+r3.^2-2.*r2.*r3));
%s24=sqrt(abs(r2.^2+r4.^2-2.*r2.*r4));



% if i1<i2
% Vs12 = mean(s12(i1:i2))/t12; % in km/ms
% else
%     Vs12 = mean(s12(i2:i1))/t12; %mean separation over shock crossing 
% end


if i1<i4
Vs14 = mean(s14(i1:i4))/t14;
else
    Vs14 = mean(s14(i4:i1))/t14;
end

% if i2<i3
% Vs23 = mean(s23(i2:i3))/t23;
% else
%     Vs23 = mean(s23(i3:i2))/t23;
% end
% 
% if i2<i4
% Vs24 = mean(s24(i2:i4))/t24;
% else
%     Vs24 = mean(s24(i4:i2))/t24;
% end


Vi = [Vs14]

Vshock = mean(Vi)*10^(-1);

%r12=[s12(:,1), s12(:,2),s12(:,3)];
end

