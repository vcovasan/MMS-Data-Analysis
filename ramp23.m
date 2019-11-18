function ramp23(time, rho, Vshock)

epoch1=spdfcdfread('mms1.cdf', 'Variables', 'Epoch');


epoch4=spdfcdfread('mms4.cdf', 'Variables', 'Epoch');
M=1836.152;% ion to proton mass ratio

r11=time(1);
r12=time(2);


r41=time(3);
r42=time(4);

ni = rho(1);
ne = rho(2);

t11=epoch1(r11);
t12=epoch1(r12);



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


ramp4 = abs(Vshock*(t42-t41));

sprintf('Individual ramp sizes in km:')
ramps = [ramp1 ramp4];
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
