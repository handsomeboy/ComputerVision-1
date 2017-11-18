close all;
clear all;
clc
%%%% Load images

imDir='./RawImages/';
myFiles = dir(fullfile(imDir,'*.png')); %gets all png files in struct
for k = 1:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(imDir, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    Iraw = rgb2gray(imread(fullFileName));
    % all of your actions for filtering and plotting go here
    -horizon(Iraw)
    Iorthogonal=imrotate(Iraw,-horizon(Iraw),'bilinear');
    Ibw=(imbinarize(Iorthogonal,0.9));
    [row_start,col_start]=find(Ibw,1,'first');
    [row_end,col_end]=find(Ibw,1,'last');
    % imrotate works well for rotated images
    % but non-rotated images shouldn't be rotated.
    Icrop=Iorthogonal(row_start:row_end,col_start:col_end);
    imshow(Icrop)
end