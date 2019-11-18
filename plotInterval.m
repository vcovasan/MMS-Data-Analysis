function plotInterval(filename, x, y)
data = spdfcdfread(filename);
info = spdfcdfinfo(filename);
vars = info.Variables;

probe_char = char(filename);
probe = probe_char(4);
var = strcat('mms',probe,'_fgm_b_gse_srvy_l2');

b_gse = spdfcdfread(filename, 'Variable', var);
bt=b_gse(:,4);

%epoch1=spdfcdfread(filename, 'Variables', 'Epoch');
%UTC1 = spdftt2000unixtime(epoch1);

figure(1)
sgtitle(['MMS',probe,':','ramp timing'])
plot([x:y],bt(x:y))
legend("MMS1")
ylabel('B_{t}(nT)')
end