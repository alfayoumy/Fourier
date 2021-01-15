clc; clear all;
t0 = -1; %t initial
T = 2;  %period
t = t0:0.001:t0+T;  %range of t
y = square(t);  %original function
coeff(1)=(1/T)*quad(@(t) square(t), t0, t0+T);  %calculating a_0
M = 5;  %number of harmonics
for k=1:M
  coeff(k+1)=(2/T)*quad(@(t) square(t)*cos(k*pi*t), t0, t0+T);  %calculating a_k
  coeff(k+M+1)=(2/T)*quad(@(t) square(t)*sin(k*pi*t), t0, t0+T);  %calculating b_k
end
coeff %display coeff in form of [a_0, a_1, ..., a_M, b_1, ..., b_M]

%dimension of fourier series array
N  = length(t);
M  = (length(coeff)-1)/2;
series = zeros(N,2*M+1);
series(:,1) = 1;

%calculating fourier series
w0 = 2*pi/T;
for m=2:M+1
    series(:,m)   = cos(w0*(m-1)*t);  
    series(:,m+M) = sin(w0*(m-1)*t);
end
fseries = series*reshape(coeff,2*M+1,1);

%plots
plot(t,y,'k',t,fseries,'r.')
legend('Original function','Fourier series')
title('Fourier Series Representation')
xlabel('t')
