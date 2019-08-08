load thrust.mat
anew
truethrust
ThrustErr
x=1:6;
plot(x,anew);
hold on
plot(x,truethrust,'r');
hold off
axis([1 6 0 18]);
 