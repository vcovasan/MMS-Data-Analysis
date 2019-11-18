function [N] = normal(filename, i1, i2, N) % to be called with Nmin=decompose(...)

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



bx=fgm_gse(interval,1);
by=fgm_gse(interval,2);
bz=fgm_gse(interval,3);
bt=fgm_gse(interval,4);


Bxyz=[bx by bz];

for i=1:length(bx)
Bn(i)=dot(Bxyz(i,:),N);
i=i+1;
end

close()
figure(2)


str = sprintf("MMS1: N=[%d %d %d]",N(1),N(2),N(3));


sgtitle(str);

s1=subplot(2,1,1)
plot([i1:i2],Bn)
xlabel('Index')
ylabel('B_{N}')

s2=subplot(2,1,2)
plot([i1:i2],bt)
xlabel('Index')
ylabel('Bt_{GSE}')

linkaxes([s1,s2],'x')


end
