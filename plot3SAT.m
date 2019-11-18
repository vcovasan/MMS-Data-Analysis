function plot3SAT(x, y)
format long



b_gse1 = spdfcdfread('mms1.cdf', 'Variable', 'mms1_fgm_b_gse_srvy_l2');
b_gse2 = spdfcdfread('mms2.cdf', 'Variable', 'mms2_fgm_b_gse_srvy_l2');

b_gse4 = spdfcdfread('mms4.cdf', 'Variable', 'mms4_fgm_b_gse_srvy_l2');

bt1=b_gse1(:,4);
bt2=b_gse2(:,4);

bt4=b_gse4(:,4);

%epoch1=spdfcdfread(filename, 'Variables', 'Epoch');
%UTC1 = spdftt2000unixtime(epoch1);

datenum = [1:length(b_gse1)]/10; %time in seconds
seconds = round(datenum);
hours= datenum./(3600); % time in hours 

minutes = datenum./60;
minutes = round(minutes);
hours = round(hours);

datenum2 = [1:length([x:y])]/10; %time in seconds
sec = round(datenum2);
min = round(sec/60)
t = datetime(2018, 01, 08, 06, min, sec);

length(t)

figure(1)
sgtitle(['Shock time shift'])

plot(sec, bt1(x:y));

%plot(sec,bt1(x:y),'k',[x:y],bt2(x:y),'r',[x:y],bt4(x:y),'b')
legend('MMS1','MMS2','MMS4')
ylabel('|B| (nT)')
%xtickformat('MMMM d, yyyy HH:mm:ss Z')
end