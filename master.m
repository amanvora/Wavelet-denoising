%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Date: April 23, 2015                                                    %
% Wavelet Denoising                                                       %
% Name: Varun R, Likith Rana, Aman Vora                                   %
%=========================================================================%
% Description of the program:-                                            %
% The input is an image of Lena. Noise as specified by the user is added  %
% Different filters and denoising methods are used and compared.          %
%=========================================================================%
% Device parameters used :-                                               %
% Platform used         :       Matlab R2015a                             %
% Processor             :       4th Gen Intel i5-3230M @ 2.60 GHz         %
% Operating System      :       Windows 7 Professional 64-bit             %
% RAM                   :       8 GB                                      %
%=========================================================================%
%%% The Main Master code %%%
clc;close all; clear all;

% Read the Original Image
I=imread('lina.png');

% Specify the Noise to ne added to image
fprintf('Specify the noise to be added to image \n');
fprintf('1: Salt & Pepper 2: Gaussian 3: Speckle \n');
N=input('Enter the noise number:');

% Select the appropriate noise
switch(N)
    case 1
       Noise='salt & pepper';
    case 2
       Noise='gaussian';
    case 3
        Noise='speckle';
    otherwise
        disp('Invalid number')
end

% Specify the noise removal technique
fprintf('\nSpecify the noise removal technique to be used \n');
fprintf('1: Gaussian Filter 2: Median Filter 3:DWT Denoising \n');
N1=input('Enter the number:');

% Select the appropriate noise removal technique
switch(N1)
    case 1
       % Provide appropriate inputs for the filter size n sigma value
       Hsize=input('Enter the filter size [row col]=');
       Sigma=input('Enter the sigma value=');
       G=gaus_filt(I,Noise,Hsize,Sigma);
    case 2
       % Provide appropriate inputs for the filter size
       Hsize=input('Enter the filter size [row col]=');
       M = med_filt(I,Noise,Hsize);
    case 3
       % Provide appropriate inputs for the threshold parameters of DWT
       Thres=input('Enter the threshold parameters for ch, cv and cd components=');
       Im=wave_denoise(I,Noise,Thres); 
    otherwise
        disp('Invalid number')
end