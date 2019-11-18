function [N] = decompose(filename, i1, i2) % to be called with Nmin=decompose(...)

%minimum variance calculated according to "space physics coordinate
%transformations: a user guide, page 716 
data = spdfcdfread(filename);
info = spdfcdfinfo(filename);
vars = info.Variables;
probe_char = char(filename);
probe = probe_char(4);
var = strcat('mms',probe,'_fgm_b_gse_srvy_l2');
fgm_gse = spdfcdfread(filename, 'Variable', var);
interval = i1:i2;

bt=fgm_gse(:,4);
Bu=mean(bt(i1:(i1+100)))
Bd=mean(bt((i2-100):i2))



bx=fgm_gse(interval,1);
by=fgm_gse(interval,2);
bz=fgm_gse(interval,3);
bt=fgm_gse(interval,4);

%figure(1)
%irf_minvar_nest_gui([bx bx by bz])

% % 
% nrOfPoints = i2-i1+1;          %NL=NF-NB+1;% whaaat
% 
% % calculate means
% Bxxbar=sum(bx)/(nrOfPoints);
% Byybar=sum(by)/(nrOfPoints);
% Bzzbar=sum(bz)/(nrOfPoints);
% 
% % REMOVE THE MEANS!!!
% bx=bx-Bxxbar;          %xx=xx-xxa;
% by=by-Byybar; %yy=yy-yya;
% bz=bz-Bzzbar;  %  zz=zz-zza;


Bxyz=[bx by bz];

%hodo(Bxyz, 1:length(bx))
% 
% BxxBar=(1/(length(bx)))*sum(bx);
% ByyBar=(1/(length(by)))*sum(by.*by);
% BzzBar=(1/(length(bz)))*sum(bz.*bz);
% BxByBar=(1/(length(bx)))*sum(bx.*by);
% ByBzBar=(1/(length(by)))*sum(by.*bz);
% BxBzBar=(1/(length(bz)))*sum(bx.*bz);
% 
% BiBjBar=[BxxBar BxByBar BxBzBar; BxByBar ByyBar ByBzBar;BxBzBar ByBzBar BzzBar];
% 
% BxBar=mean(bx);% mean of Bx
% ByBar=mean(by);% mean of By
% BzBar=mean(bz);% mean of Bz
% means=[BxBar ByBar BzBar];
% %M=eye(3);
% for i=1:3
%     for j=1:3
%      m(i,j)=BiBjBar(i,j)-mean(i)*mean(j);
%      j=j+1;
%     end
%     i=i+1;
% end

[vec, val, max_err, min_err]=minvar(fgm_gse,i1,i2);
%where l is the vector containing the eigenvalues
%k_min=find(l==min(l));
% the eigenvector defining the normal boundary direction; N from LMN found
N = [ -0.8597    0.2574   -0.4412]'; 
L = [-0.1152    0.7438    0.6584]';
M = [-0.8597    0.2574   -0.4412]';

%now we could define L in the direction defined by the eigenvector whose
%eigenvalue is the maximum one


%k_max=find(l==max(l));


%now M is defined just as the perpendicular to the plane defined by the
%previous two 



% lambda_M / lambda_N is about 0.00(D(2,2)/D(1,1)) so it might not be
% clearly distinguishable(see paper), therefore a new method is required 

%now the transformation matrix is T = [Lx Ly Lz](not sure if they are just th)
%is that just the components of L or the components of L projected on the
%original GSE system 
T = [L M N]';

%now we can finally transform the coordinates 

%for each entry in Bxyz, multiply it by T to get Blmn
Blmn=zeros(length(bx),3);
for i=1:length(bx)
Blmn(i,:)=(T*(Bxyz(i,:).')).';
i=i+1;
end

% Vmin = vec';        
% Nmin = [Vmin(3,1) Vmin(3,2) Vmin(3,3)]   %use final row values
% BxyzN=Bxyz(:,1)*Nmin(1)+Bxyz(:,2)*Nmin(2)+Bxyz(:,3)*Nmin(3); %Normal vector to Bxyz
% figure(1)
% plot(-BxyzN)

Bl = Blmn(:,1);
Bm = Blmn(:,2);
Bn = Blmn(:,3);

% 
% for i=1:length(Bn)
% Btlmn(i)=sqrt(Bl(i)^2+Bm(i)^2+Bn(i)^2);
% i=i+1;
% end
%total B vector obtained by summing up the LMN compoenents

%plottign the three components and the total B vector
close()
figure(2)
str = sprintf("MMS %c: N=[%d %d %d]",probe,N(1),N(2),N(3));

sgtitle(str);



% the magnetic jump in this one should be less than 10% of the jump in the total B 

s1=subplot(2,1,1)
plot([i1:i2],Bl)
xlabel('Index')
ylabel('B_{M}')

s2=subplot(2,1,2)
plot([i1:i2],bt)
xlabel('Index')
ylabel('Bt_{GSE}')

linkaxes([s1,s2],'x')


%calculating the separation 
r_gse1 = spdfcdfread('mms1.cdf', 'Variables', 'mms1_fgm_r_gse_srvy_l2');%read all the x y z and R data
r_gse2 = spdfcdfread('mms2.cdf', 'Variables', 'mms2_fgm_r_gse_srvy_l2');
r_gse3 = spdfcdfread('mms3.cdf', 'Variables', 'mms3_fgm_r_gse_srvy_l2');
r_gse4 = spdfcdfread('mms4.cdf', 'Variables', 'mms4_fgm_r_gse_srvy_l2');
b_gse1 = spdfcdfread('mms1.cdf', 'Variables', 'mms1_fgm_b_gse_srvy_l2');
r_gse1=r_gse1(:,4); %keep only the magnitude R
r_gse2=r_gse2(:,4);
r_gse3=r_gse3(:,4);
r_gse4=r_gse4(:,4);

%calculate the separations 
s12=sqrt(r_gse1.^2+r_gse2.^2-2.*r_gse1.*r_gse2);%not sure about the absolute, why does it become negative
s13=sqrt(abs(r_gse1.^2+r_gse3.^2-2.*r_gse1.*r_gse3));
s14=sqrt(abs(r_gse1.^2+r_gse4.^2-2.*r_gse1.*r_gse4));
s23=sqrt(abs(r_gse2.^2+r_gse3.^2-2.*r_gse2.*r_gse3));
s24=sqrt(abs(r_gse2.^2+r_gse4.^2-2.*r_gse2.*r_gse4));
s34=sqrt(abs(r_gse3.^2+r_gse4.^2-2.*r_gse3.*r_gse4));
N'
%now we need the times of the shock striking each pair of satellites 
end

%interval = 473246,478351