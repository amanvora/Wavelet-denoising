function G=gaus_filt(I,Noise,Hsize,Sigma)
% Function which performs the operation of gaussian filter %
% I - Original Image
% Noise - Noise to be added
% Hsize - Filer size
% Sigma - Sigma value of gaussian filter
% G - Noise removed image

% Start the timer (To record the time taken to remove noise)
tic;

% Add the noise specified to original image
G=imnoise(I,Noise);

% Display the image
figure;subplot(1,2,1);imshow(G);
title(strcat('Noisy Image ;',' Noise added = ', Noise));

% Create a Pre-defined filter
% Gaussian filter
f = fspecial('gaussian',Hsize,Sigma);

% Filter the image using the filter defined
G = imfilter(G,f,'replicate'); 

% Display the results
subplot(1,2,2);imshow(G);
title(strcat('Filtered Image ;',' Filter size = [', num2str(Hsize),'] ; Sigma =',num2str(Sigma)));

% Stop the timer
toc;
end