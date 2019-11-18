function simplePlot(filename)
probe_char = char(filename);
probe = probe_char(4);
var = strcat('mms',probe,'_fgm_b_gse_srvy_l2');

%epoch1=spdfcdfread(filename, 'Variables', 'Epoch');
b_gse = spdfcdfread(filename, 'Variable', var);

bt=b_gse(:,4);
%UTC1 = spdftt2000unixtime(epoch1);

figure(1)
plot([1:length(bt)],bt)
xlabel('Index');
ylabel('B_{t}(nT)');

end

