function ramp2(time, rho, Vshock)

epoch1=spdfcdfread('mms1.cdf', 'Variables', 'Epoch');

epoch3=spdfcdfread('mms3.cdf', 'Variables', 'Epoch');
epoch4=spdfcdfread('mms4.cdf', 'Variables', 'Epoch');
M=1836.152;% ion to proton mass ratio

r11=time(1);
r12=time(2);

r31=time(3);
r32=time(4);

r41=time(5);
r42=time(6);

ni = rho(1);
ne = rho(2);

t11=epoch1(r11);
t12=epoch1(r12);


t31=epoch3(r31);
t32=epoch3(r32);

t41=epoch4(r41);
t42=epoch4(r42);

wpi=1.32*sqrt(ni/M)*10^3;
wpe=5.64*sqrt(ne)*10^3;% change this back to 10^4

c=299792;
Li=c/wpi;
Le=c/wpe;

Vshock = Vshock*10^(-3) %in km/ms
sprintf('Size of the ramp in km:')
ramp1 = abs(Vshock*(t12-t11));%in km

ramp3 = abs(Vshock*(t32-t31));
ramp4 = abs(Vshock*(t42-t41));

sprintf('Individual ramp sizes in km:')
ramps = [ramp1 ramp3 ramp4];
ramps=ramps.*10^2;
ramps./10

sprintf('Mean of the individual ramps:')
mean(ramps)/10

sprintf('Median of the individual ramps:')
Ramp = median(ramps);
Ramp/10

sprintf('Normalised ramp scales:')
rampNormalisedLi = Ramp/Li
rampNormalisedLe = Ramp/Le


end
