% index1 = 475246 
% index2 = 475273
% index3 = 475266
% index4 = 474274
%found from Bt on the plot


% t1 = Epoch1(index1)
% t2 = Epoch2(index1)
% t3 = Epoch3(index1)
% t4 = Epoch4(index1)

function [V] = shockVelocity4(i1,i2,i3, N)

epoch1 = spdfcdfread('mms1.cdf', 'Variables', 'Epoch');
epoch2 = spdfcdfread('mms2.cdf', 'Variables', 'Epoch');
epoch3 = spdfcdfread('mms3.cdf', 'Variables', 'Epoch');
%epoch4 = spdfcdfread('mms4.cdf', 'Variables', 'Epoch');

eState1 = spdfcdfread('mms1.cdf', 'Variables','Epoch_state');
eState2 = spdfcdfread('mms2.cdf', 'Variables','Epoch_state');
eState3 = spdfcdfread('mms3.cdf', 'Variables','Epoch_state');
%eState4 = spdfcdfread('mms4.cdf', 'Variables','Epoch_state');

t1=epoch1(i1);
t2=epoch2(i2);
t3=epoch3(i2);
%t4=epoch4(i2);

t12=abs(t2-t1);% all in miliseconds
t13=abs(t3-t1);
%t14=abs(t4-t1);
t23=abs(t3-t2);
%t24=abs(t4-t2);
%t34=abs(t4-t3);

r_gse1 = spdfcdfread('mms1.cdf', 'Variables', 'mms1_fgm_r_gse_srvy_l2'); %read all the x y z and R data
r_gse2 = spdfcdfread('mms2.cdf', 'Variables', 'mms2_fgm_r_gse_srvy_l2');
r_gse3 = spdfcdfread('mms3.cdf', 'Variables', 'mms3_fgm_r_gse_srvy_l2');
%r_gse4 = spdfcdfread('mms4.cdf', 'Variables', 'mms4_fgm_r_gse_srvy_l2');



r1x = r_gse1(:,1); % MMS1 x component of the GSE position vector
r1y = r_gse1(:,2);
r1z = r_gse1(:,3);
r1x = interp1(eState1, r1x, epoch1);
r1y = interp1(eState2, r1y, epoch2);
r1z = interp1(eState3, r1z, epoch3);

sprintf('MMS1 Position at shock crossing:')
[r1x(i1) r1y(i1) r1z(i1)]

r2x = r_gse2(:,1); % MMS2 x component of the GSE position vector
r2y = r_gse2(:,2);
r2z = r_gse2(:,3);
r2x = interp1(eState1, r2x, epoch1);
r2y = interp1(eState2, r2y, epoch2);
r2z = interp1(eState3, r2z, epoch3);

sprintf('MMS2 Position at shock crossing:')
[r2x(i2) r2y(i2) r2z(i2)]

r3x = r_gse3(:,1); % MMS3 x component of the GSE position vector
r3y = r_gse3(:,2);
r3z = r_gse3(:,3);
r3x = interp1(eState1, r3x, epoch1);
r3y = interp1(eState2, r3y, epoch2);
r3z = interp1(eState3, r3z, epoch3);

sprintf('MMS3 Position at shock crossing:')
[r3x(i3) r3y(i3) r3z(i3)]

% r4x = r_gse4(:,1); % MMS4 x component of the GSE position vector
% r4y = r_gse4(:,2);
% r4z = r_gse4(:,3);
% r4x = interp1(eState1, r4x, epoch1);
% r4y = interp1(eState2, r4y, epoch2);
% r4z = interp1(eState3, r4z, epoch3);
% 
% sprintf('MMS4 Position at shock crossing:')
% [r4x(i4) r4y(i4) r4z(i4)]

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

sx12=abs(r1x-r2x); % these are the separation vectors for each pair 
sx13=abs(r1x-r3x);
%sx14=abs(r1x-r4x);
sx23=abs(r2x-r3x);
%sx24=abs(r2x-r4x);
%sx34=abs(r3x-r4x);

sy12=abs(r1y-r2y);
sy13=abs(r1y-r3y);
%sy14=abs(r1y-r4y);
sy23=abs(r2y-r3y);
%sy24=abs(r2y-r4y);
%sy34=abs(r3y-r4y);

sz12=abs(r1z-r2z);
sz13=abs(r1z-r3z);
%sz14=abs(r1z-r4z);
sz23=abs(r2z-r3z);
%sz24=abs(r2z-r4z);
%sz34=abs(r3z-r4z);

sprintf('Separations:')
sep12=sqrt(sx12(i1)^2+sy12(i1)^2+sz12(i1)^2);
sep13=sqrt(sx13(i1)^2+sy13(i1)^2+sz13(i1)^2);
%sep14=sqrt(sx14(i1)^2+sy14(i1)^2+sz14(i1)^2);
sep23=sqrt(sx23(i2)^2+sy23(i2)^2+sz23(i2)^2);
%sep24=sqrt(sx24(i2)^2+sy24(i2)^2+sz24(i2)^2);
%sep34=sqrt(sx34(i3)^2+sy34(i3)^2+sz34(i3)^2);
[sep12 sep13 sep23]

sprintf('dot products of the separations:')
sepVec12=dot([sx12(i1) sy12(i1) sz12(i1)],N);
sepVec13=dot([sx13(i1) sy13(i1) sz13(i1)],N);
%sepVec14=dot([sx14(i1) sy14(i1) sz14(i1)],N);
sepVec23=dot([sx23(i2) sy23(i2) sz23(i2)],N);
%sepVec24=dot([sx24(i2) sy24(i2) sz24(i2)],N);
%sepVec34=dot([sx34(i3) sy34(i3) sz34(i3)],N);

[sepVec12 sepVec13 sepVec23]


vx12=sx12/t12;
vx13=sx13/t13;
%vx14=sx14/t14;
vx23=sx23/t23;
%vx24=sx24/t24;
%vx34=sx34/t34;

vy12=sy12/t12;
vy13=sy13/t13;
%vy14=sy14/t14;
vy23=sy23/t23;
%vy24=sy24/t24;
%vy34=sy34/t34;

vz12=sz12/t12;
vz13=sz13/t13;
%vz14=sz14/t14;
vz23=sz23/t23;
%vz24=sz24/t24;
%vz34=sz34/t34;

vx=mean([vx12 vx13 vx23]);% see the shape of the tetrahedron to check
vy=mean([vy12 vy13 vy23]);%  which pairs are reliable and which not
vz=mean([vz12 vz13 vz23]);% if too close, discard 

vx=mean(vx)*10^(-1);
vy=mean(vy)*10^(-1);
vz=mean(vz)*10^(-1);

V = [vx vy vz];

r_gse1=r_gse1(:,4); % all in km
r_gse2=r_gse2(:,4);
r_gse3=r_gse3(:,4);
%r_gse4=r_gse4(:,4);

r1 = interp1(eState1, r_gse1, epoch1);%interpolated distance 
r2 = interp1(eState2, r_gse2, epoch2);
r3 = interp1(eState3, r_gse3, epoch3);
%r4 = interp1(eState4, r_gse4, epoch4);

r1(i1,:);

minLength=min([length(r1),length(r2),length(r3)]);% normalise wrt the shortest dataset
r1=r1(1:minLength);
r2=r2(1:minLength);
r3=r3(1:minLength);
%r4=r4(1:minLength);



%calculate the separations 
s12=sqrt(abs(r1.^2+r2.^2-2.*r1.*r2)); % The separation at every instant [in km]
s13=sqrt(abs(r1.^2+r3.^2-2.*r1.*r3));
%s14=sqrt(abs(r1.^2+r4.^2-2.*r1.*r4));
s23=sqrt(abs(r2.^2+r3.^2-2.*r2.*r3));
%s24=sqrt(abs(r2.^2+r4.^2-2.*r2.*r4));
%s34=sqrt(abs(r3.^2+r4.^2-2.*r3.*r4));


if i1<i2
Vs12 = mean(s12(i1:i2))/t12; % in km/ms
else
    Vs12 = mean(s12(i2:i1))/t12; %mean separation over shock crossing 
end

if i1<i3
Vs13 = mean(s13(i1:i3))/t13;
else
    Vs13 = mean(s13(i3:i1))/t13;
end

% if i1<i4
% Vs14 = mean(s14(i1:i4))/t14;
% else
%     Vs14 = mean(s14(i4:i1))/t14;
% end

if i2<i3
Vs23 = mean(s23(i2:i3))/t23;
else
    Vs23 = mean(s23(i3:i2))/t23;
end

% if i2<i4
% Vs24 = mean(s24(i2:i4))/t24;
% else
%     Vs24 = mean(s24(i4:i2))/t24;
% end
% 
% if i3<i4
% Vs34 = mean(s34(i3:i4))/t34;
% else
%     Vs34 = mean(s34(i4:i3))/t34;
% end
sprintf('Individual separations:')
Vi = [Vs12 Vs13 Vs23]
vimin=min(Vi);
sprintf('Normalized separations:')
Vi./vimin

Vshock = mean(Vi)*10^(-1)

%r12=[s12(:,1), s12(:,2),s12(:,3)];
end

