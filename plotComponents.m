function plotComponents(filename, i1, i2) % to be called with Nmin=decompose(...)

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
x=i1;
y=i2;


bx=fgm_gse(interval,1);
by=fgm_gse(interval,2);
bz=fgm_gse(interval,3);
bt=fgm_gse(interval,4);

figure(1)
sgtitle(['Magnetic Field Components'])

plot([x:y],bx,'b',[x:y],by,'g',[x:y],bz,'r', [x:y], bt, 'k')
legend('B_{x}','B_{y}','B_{z}', 'B_{t}')
ylabel('Magnetic Field Strength(nT)')
hold off

end