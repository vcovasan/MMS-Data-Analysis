function plotEdp(edpFile,fgmFile,i1,i2)
%data = spdfcdfread(filename1);
%info = spdfcdfinfo(filename1);
%vars = info.Variables;



probe_char = char(edpFile);
probe = probe_char(4);
var1 = strcat('mms',probe,'_edp_dce_gse_fast_l2');
var2 = strcat('mms',probe,'_fgm_b_gse_srvy_l2');

b_gse = spdfcdfread(fgmFile, 'Variable', var2);
bx=b_gse(:,1);
by=b_gse(:,2);
bz=b_gse(:,3);

bx=bx(i1:i2);
by=by(i1:i2);
bz=bz(i1:i2);

field = spdfcdfread(edpFile, 'Variable', var1);
ex=field(:,1);
ey=field(:,2);
ez=field(:,3);

ex=ex(i1:i2);
ey=ey(i1:i2);
ez=ez(i1:i2);

figure(1)
subplot(4,1,1)
plot([i1:i2],bx)
hold on;
plot([i1:i2],by)
plot([i1:i2],bz)
legend('bx','by','bz')
xlabel('Index')
ylabel('B_{xyz}')
hold off


subplot(4,1,2)
plot([i1:i2],ex)
xlabel('Index')
ylabel('Ex')

subplot(4,1,2)
plot([i1:i2],ex)
xlabel('Index')
ylabel('Ex')

subplot(4,1,3)
plot([i1:i2],ey)
xlabel('Index')
ylabel('Ey')

subplot(4,1,4)
plot([i1:i2],ez)
xlabel('Index')
ylabel('Ez')


end








