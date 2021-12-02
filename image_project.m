clc;
close all;
clear;

% open an image file. Ex. ‘Lena.raw’
fid = fopen('Lena.raw','r');
lena_raw  = fread(fid , 'float64');
fclose(fid);
lena_rgb = reshape(lena_raw,[256,256,3]);
 
% Task 1 – 컬라 영상 디스플레이
figure(1);
imshow(lena_rgb), title('컬러 Lena')

% Task 2 – 컬라 영상을 회색조 영상으로 변환하기
figure(2);
lena_gray = rgb2gray(lena_rgb);
imshow(lena_gray), title('회색조 변환 Lena');

% Task 3 – 회색조 영상의 grey level 반전
figure(3);
inverseGrayImage = imcomplement(lena_gray);
imshow(inverseGrayImage), title('grey level 반전 Lena');

% Task 4 – 칼라 영상에 대하여 공간 영역에서 moving average filter (3x3, 5x5, 7x7) 적용, (R,G.B) 각 component 에 대하여 동일한 filtering
figure(4);
subplot(2, 2, 1), imshow(lena_rgb), title('원본');

windowSize = 3;
kernel = ones(windowSize) / windowSize ^ 2;
R = conv2(lena_rgb(:,:,1), kernel, 'same');
G = conv2(lena_rgb(:,:,2), kernel, 'same');
B = conv2(lena_rgb(:,:,3), kernel, 'same');
blurredImage = cat(3,R,G,B);
subplot(2, 2, 2), imshow(blurredImage, []), title('3x3 moving average 필터 적용');

windowSize = 5;
kernel = ones(windowSize) / windowSize ^ 2;
R = conv2(lena_rgb(:,:,1), kernel, 'same');
G = conv2(lena_rgb(:,:,2), kernel, 'same');
B = conv2(lena_rgb(:,:,3), kernel, 'same');
blurredImage = cat(3,R,G,B);
subplot(2, 2, 3), imshow(blurredImage, []), title('5x5 moving average 필터 적용');

windowSize = 7;
kernel = ones(windowSize) / windowSize ^ 2;
R = conv2(lena_rgb(:,:,1), kernel, 'same');
G = conv2(lena_rgb(:,:,2), kernel, 'same');
B = conv2(lena_rgb(:,:,3), kernel, 'same');
blurredImage = cat(3,R,G,B);
subplot(2, 2, 4), imshow(blurredImage, []), title('7x7 moving average 필터 적용');

% Task 5 – 칼라 영상에 대하여 공간 영역에서 Laplacian filter (high pass filter) 적용 
figure(5);
laplacian_h = fspecial('laplacian', 0.5);
B_laplacian = imfilter(lena_rgb, laplacian_h);
imshow(B_laplacian), title('Laplacian 필터 적용');

% Task 6 – Laplacian filter 적용 영상과 원영상을 적당한 가중치로 합하여 영상 개선
%figure(6)

%[R,G,B] 각 component 별로 아래의 task 수행.
% Task 7 – 이차원 Fourier 변환 (dc 가 가운데 위치)

% 이차원 Fourier 변환으로 fft2 사용
% 이차원 matrix 에서 dc 를 가운데로 옮기는 함수도 fftshift  (1차원과 동일)
 
% Task 8 – Fourier 변환 결과의 magnitude 를 log scale 로 display 

% Task 9 – 주파수 영역에서 low pass filter (임의로 설정), Fourier 역변환을 통한 filtered 영상 디스플레이
  
% Task 10 - 주파수 영역에서 high pass filter (임의로 설정), Fourier 역변환을 통한 filtered 영상 디스플레이
 
% Task 11 - 주파수 영역에서 band pass filter (임의로 설정), Fourier 역변환을 통한 filtered 영상 디스플레이

%---------------------------------------------------------------
% Task 12 –특정 주파수 잡음에 의해 왜곡된 영상을 복원하는 프로그램 작성.

% Task 13 – 흑/백 마스크 및 마스크를 쓰지 않은 자신의 영상에서의 흑색/백색 마스크를 착용하였는지 여부를 판단하는 프로그램 작성. (자신의 사진은 가급적 256x256 크기 영상으로 변환할 것., color 또는 gray scale 영상은 임의로 선택할 것)
%Hint (Task 12)
% (1) 왜곡된 영상을 Fourier 변환하여 특정 영역들의 노이즈를 파악.
% (2) 특정 영역들의 noise 들을 제거.
%     특정 영역들을 (i) 0 으로 처리하거나, (ii) 인접한 주파수 값들로 처리
% (3) Inverse Fourier 변환으로 영상 복원.

% Hint (Task 13)
% 일정한 크기의 (MxM) 평탄한 kernel을 원 영상과 convolution 하여, 출력 값이 threshold1 이상인 pixel 에는 1, 이하인 pixel 에는 0을 할당.
% (2) Thresholding한 영상에서 1로 할당한 영역이 마스크 영역과 일치하는지를 확인.
%     필요시 kernel 크기와 threshold1 값을 조절.
% (3) Thresholding한 영상에서 pixel 의 값이 1 인 pixel의 개수를 counting 하여  적당한 값(threshold 2) 이상이면 마스크를 착용한 것으로 판정. 
% (4) (1)-(3) 과정을 변형하여 마스크의 색깔을 구분할 수 있는 프로그램 작성  
% (5) 주어진 영상들 모두에서 잘 동작하는 kernel의 크기, threshold 1 값, threshold 2 값과 이들로 얻은 Threshold 영상, 원영상들을 reporting.

% Due: 12월 7일(화) 
% 제출물: 레포트, 프로그램, 결과물, 간단한 설명 등
% 발표를 원하는 사람은 녹화 파일(mp4)을 함께 제출 - 추가 점수 부여
% 평가 후 (선택된) 녹화 파일은 (온라인) 강의 자료실에 업로드할 계획. 