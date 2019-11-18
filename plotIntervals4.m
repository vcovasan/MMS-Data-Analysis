function plotIntervals4(x, y)



b_gse1 = spdfcdfread('mms1.cdf', 'Variable', 'mms1_fgm_b_gse_srvy_l2');
b_gse2 = spdfcdfread('mms2.cdf', 'Variable', 'mms2_fgm_b_gse_srvy_l2');
b_gse3 = spdfcdfread('mms3.cdf', 'Variable', 'mms3_fgm_b_gse_srvy_l2');


bt1=b_gse1(:,4);
bt2=b_gse2(:,4);
bt3=b_gse3(:,4);


%epoch1=spdfcdfread(filename, 'Variables', 'Epoch');
%UTC1 = spdftt2000unixtime(epoch1);

figure(1)
sgtitle(['MMS ramp timing'])
subplot(3,1,1)
plot([x:y],bt1(x:y))

subplot(3,1,2)
plot([x:y],bt2(x:y))

subplot(3,1,3)
plot([x:y],bt3(x:y))



end