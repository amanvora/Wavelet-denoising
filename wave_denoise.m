function Im=wave_denoise(I,Noise,Thres);    
% Function which performs the operation of DWT Denoising %
% I - Original Image
% Noise - Noise to be added
% Thres - Provides threshold parameters for DWT componenets
% Im - Noise removed image

% Start the timer (To record the time taken to remove noise)
tic;

% Calculate the size of original image
[r c]=size(I);

% Add the noise specified to original image
Im=imnoise(I,Noise);

% Display the image
figure;subplot(1,2,1);imshow(Im);
title(strcat('Noisy Image ;',' Noise added =  ', Noise));

% Compute the 2-D DWT of the noisy image
[ca,ch,cv,cd]=dwt2(Im,'haar');

% Compute the 2-D DWT of only the ca (LL) component image
[ca,ch,cv,cd]=dwt2(ca,'haar');

% Resize each component to original size to maintain clarity
ca=imresize(ca,[r c]);
ch=imresize(ch,[r c]);
cv=imresize(cv,[r c]);
cd=imresize(cd,[r c]);


% figure;
% subplot(2,2,1);imshow(mat2gray(ca));
% subplot(2,2,2);imshow(mat2gray(ch));
% subplot(2,2,3);imshow(mat2gray(cv));
% subplot(2,2,4);imshow(mat2gray(cd));

% Find the highest value of the ch component
maxx=max(max(ch));
% Size of ch image
s=size(ch);
% Make pixels below the specified threshold zero
for i=1:s(1);
    for j=1:s(2);
        if ch(i,j)<(Thres(1)*maxx)
            ch(i,j)=0;
        end
    end
end

% Find the highest value of the cv component
maxx=max(max(cv));
% Size of cv image
s=size(cv);
% Make pixels below the specified threshold zero
for i=1:s(1);
    for j=1:s(2);
        if cv(i,j)<(Thres(2)*maxx)
            cv(i,j)=0;
        end
    end
end

% Find the highest value of the cd component
maxx=max(max(cd));
% Size of cd image
s=size(cd);
% Make pixels below the specified threshold zero
for i=1:s(1);
    for j=1:s(2);
        if cd(i,j)<(Thres(3)*maxx)
            cd(i,j)=0;
        end
    end
end

% Convert the matrixes to grayscale images
ca=mat2gray(ca);
ch=mat2gray(ch);
cv=mat2gray(cv);
cd=mat2gray(cd);

% Combine all the noise removed components using 2-D Inverse DWT
Im=idwt2(ca,ch,cv,cd,'haar');

% Adjust the brighness of the image 
Im = imadjust(Im);

% Display the results
subplot(1,2,2);imshow(Im);
title(strcat('Filtered Image ;',' Threshold for ch, cv & cd = [',num2str(Thres),']'));

% Stop the timer
toc;
end