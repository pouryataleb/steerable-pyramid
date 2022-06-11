clc;
clear;
close all;

i=imread('C:\Users\pourya\Desktop\kahgel.jpg');
i=rgb2gray(i);
i=im2double(i);

p=angle(fft2(i));


filts = 'sp5Filters';
[lo0filt,hi0filt,lofilt,bfilts,steermtx,harmonics] = eval(filts);
fsz = round(sqrt(size(bfilts,1))); fsz =  [fsz fsz];
nfilts = size(bfilts,2);
nrows = floor(sqrt(nfilts));

%Look at the oriented bandpass filters:
figure
for f = 1:nfilts
  subplot(nrows,ceil(nfilts/nrows),f);
  showIm(conv2(reshape(bfilts(:,f),fsz),lo0filt));
end

lo0 = fftshift(abs(fft2(lo0filt,size(i,1),size(i,2))));
fsum = zeros(size(lo0));
figure
for f = 1:size(bfilts,2)
  subplot(nrows,ceil(nfilts/nrows),f);
  flt = reshape(bfilts(:,f),fsz);
  freq = lo0 .* fftshift(abs(fft2(flt,size(i,1),size(i,2))));

  fsum = fsum + freq.^2;
  showIm(freq);
end


[pyr,pind] = buildSFpyr(i,4,0);

figure
for s = 1:min(4,spyrHt(pind))
  band = spyrBand(pyr,pind,s,1);
  subplot(2,2,s); showIm(band);
end
 

figure
subplot(2,4,1);
 band = spyrBand(pyr,pind,1,1);
 
 showIm(abs(band));
  subplot(2,4,2);
  phase1=angle(band);
showIm(phase1);

subplot(2,4,3);
 band = spyrBand(pyr,pind,2,1);

 showIm(abs(band));
  subplot(2,4,4);
  phase1=angle(band);
showIm(phase1);

subplot(2,4,5);
 band = spyrBand(pyr,pind,3,1);
  showIm(abs(band));
  subplot(2,4,6);
  phase1=angle(band);
showIm(phase1);
subplot(2,4,7);
 band = spyrBand(pyr,pind,4,1);
 
 showIm(abs(band));
  subplot(2,4,8);
  phase1=angle(band);
showIm(phase1);


figure
subplot(1,2,1);
low = pyrLow(pyr,pind);
showIm(abs(low));
title('low-pass');

subplot(1,2,2);
high = spyrHigh(pyr,pind);
showIm(abs(high));
title('high-pass');

figure
showSpyr(pyr,pind);




figure
res = reconSFpyr(pyr,pind);
subplot(1,2,1);
showIm(res);
title('reconstruc');
subplot(1,2,2);

title('original');

imStats(i,res);
% figure
% imshow(i);


% figure
% band=reshape(band,[281*157,1]);
% res = reconSFpyr(band,pind);
% subplot(1,2,1);
% showIm(res);
% title('reconstruc');
