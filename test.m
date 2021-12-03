clc;
close all;
clear;

fid2 = fopen('noised_lena.raw','r');
noised_lena_raw  = fread(fid2, 'float64');
fclose(fid2);
noised_lena = reshape(noised_lena_raw,[256,256,3]);

figure(12);
subplot(3,3,1);
imshow(noised_lena), title('왜곡된 Lena')

% 노이즈 파악
GRAY = rgb2gray(noised_lena);
% Fourier Transform
GRAYF = fft2(GRAY);
%GRAYF = fft2(noised_lena);
% Magnitude
GRAYMag = abs(GRAYF);
% Centered Spectrum
GRAYFCenter = fftshift(GRAYF);
% log Transform
GRAYFCLog = log(1+abs(GRAYFCenter));

subplot(3,3,2);
imshow(log(GRAYMag),[]), title('Magnitude - FT');
subplot(3,3,3);
imshow(log(abs(GRAYFCenter)),[]), title('Centered Spectrum');    
subplot(3,3,4);
imshow(GRAYFCLog,[]), title('Log Transform');

% 인접한 주파수 값으로 처리
subplot(3,3,5)
M = 256;
N = 256;

D0 = 60;
D1 = -60;

u = 0:(M-1);
idx = find(u>M/2);
u(idx) = u(idx)-M;
v = 0:(N-1);
idy = find(v>N/2);
v(idy) = v(idy)-N;
[V, U] = meshgrid(v, u);
D = sqrt(U.^2+V.^2);

H1 = double(D <= D0);
H2 = double(D > D1);
G1 = H1.*GRAYF;
G2 = H2.*G1;
highpass_filtered = real(ifft2(double(G2)));
imshow(highpass_filtered, [ ]), title("Band pass 필터");

