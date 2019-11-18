function plotIntervals23(x, y)



b_gse1 = spdfcdfread('mms1.cdf', 'Variable', 'mms1_fgm_b_gse_srvy_l2');
b_gse4 = spdfcdfread('mms4.cdf', 'Variable', 'mms4_fgm_b_gse_srvy_l2');

bt1=b_gse1(:,4);


bt4=b_gse4(:,4);


figure(1)
sgtitle(['MMS ramp timing'])
subplot(2,1,1)
plot([x:y],bt1(x:y))

subplot(2,1,2)
plot([x:y],bt4(x:y))


end