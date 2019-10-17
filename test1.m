km=10;%costante meccanica
ke=10;%back emf costant 
Mp=1; %massa pendolo
l=0.12;%lunghezza dal baricentro
r=0.05;%raggio ruota
a=0.04;%lato a pendolo
b=0.20;%lato b pendolo
Ip=Mp*(a^2+b^2)/3;%inerzia del pendolo
R=6;%resistenza del motore
g=9.81;
Mw=0.2;%massa ruota
Iw=Mw*r^2/2;%inerzia ruota



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
    0 0 0 1;...
    0 J K 0];
B=[0 Y 0 L]';
C=[0 0 1 0];
D=0;

sys=ss(A,B,C,D);

pi=10000000*tf([1 -7.74],[1 0]);

sys_t=pi*sys;
tot=sys_t/(1+sys_t);

opt = stepDataOptions('StepAmplitude',3);
[result,t]=step(tot,opt);
plot (t,result)
% bode(sys)
