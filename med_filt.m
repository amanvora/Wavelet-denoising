function M = med_filt(I,Noise,Hsize)
% Function which performs the operation of Median filter %
% I - Original Image
% Noise - Noise to be added
% Hsize - Filer size
% M - Noise removed image

% Start the timer (To record the time taken to remove noise)
tic;

% Add the noise specified to original image
I=imnoise(I,Noise);

% Display the image
figure;subplot(1,2,1);imshow(I);
title(strcat('Noisy Image ;',' Noise added = ', Noise));

% Produce a dummy image of zeros of same size as original image
M = zeros(size(I));

% Calculate the window size of the filter
wsize = Hsize(1)*Hsize(2);

% Create a image padded with zeros of filter size with original size
paddedI = zeros(size(I,1)+Hsize(1)-1, size(I,2)+Hsize(2)-1);
    
    % Copy the original image to padded image
    % Leaving half amount of the padded zeros on all 4 sides 
    for x = 1:size(I,1)
            for y = 1:size(I,2)
                 paddedI(x + (Hsize-1)/2,y + (Hsize-1)/2) = I(x,y);
            end
    end
    
    % Loop for each pixel of the image
    for i = 1:size(I,1)
    for j = 1:size(I,2)
        % A variable to store window co-efficients
        window = zeros(wsize,1);
        % Initialize counter
        inc = 1;
        % Loop for each pixel in filter window
        for x = 1:Hsize(1)
            for y = 1:Hsize(2)
                % Fetch the window co-efficients from the padded image
                window(inc)= paddedI(i+x-1,j+y-1);
                % Update counter
                inc = inc+1;
            end
        end
        
        % Sort the co-efficients in ascending order
        window = sort(window);
        
        % Condition to determine the median value
        if (logical(mod(wsize,2)))
            % Add the median value to output image
            M(i,j) = window(ceil(wsize/2));
        else
            M(i,j) = (window(wsize-1) + window(wsize+1))/2;
        end
    end
  
    end
    % Convert the matrix to image form
    M = uint8(M);
    
% Display the results
subplot(1,2,2);imshow(M);
title(strcat('Filtered Image ;',' Filter size = [', num2str(Hsize),']'));

% Stop the timer
toc;
end


