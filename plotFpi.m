function plotEdp(disFile,desFile,i1,i2)
%data = spdfcdfread(filename1);
%info = spdfcdfinfo(filename1);
%vars = info.Variables;



probe_char = char(disFile);
probe = probe_char(4);
var1 = strcat('mms',probe,'_dis_numberdensity_fast');
var2 = strcat('mms',probe,'_des_numberdensity_fast');

ni = spdfcdfread(disFile, 'Variable', var1);
ne = spdfcdfread(desFile, 'Variable', var2);


figure(1)
sgtitle(['MMS',probe,':','number densities'])
plot([i1:i2],ni(i1:i2),'g')
hold on;
plot([i1:i2],ne(i1:i2),'b')
legend('ni','ne')
xlabel('Index')
ylabel('Number density(cm^{-3}')
hold off




end








