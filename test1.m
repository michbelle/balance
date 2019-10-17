km=10;
ke=10;
Mp=10;
l=10;
r=10;
Ip=10;
R=10;
g=9.81;
Mw=10;
Iw=10;

beta=(2*Mw+2*Iw/r^2+Mp);
alpha=Ip*beta+2*Mp*l^2*(Mw+Iw/r^2);

Z=2*km*ke*(Mp*l*r-Ip-Mp^2*g*l^2)/(R*r^2*alpha);
X=Mp^2*g*l^2/alpha;
Y=2*km*(Ip+Mp*l^2-Mp*l*r)/(R*r*alpha);
J=2*ke*km*(r*beta-Mp*l)/(R*r^2*alpha);
K=Mp*g*l*beta/alpha;
L=2*km*(Mp*l-r*beta)/(R*r*alpha);

A=[0 1 0 0;...
    0 Z X 0;...
    0 0 0 1;
    0 J K 0];
B=[0 Y 0 L]';
C=[0 0 1 0];
D=0;

sys=ss(A,B,C,D);

opt = stepDataOptions('StepAmplitude',3);
[result,t]=step(sys,50,opt);
plot (t,result)