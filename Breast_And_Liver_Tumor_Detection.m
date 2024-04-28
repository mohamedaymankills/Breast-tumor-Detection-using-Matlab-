%%%%%% LIVER %%%%%%%%


choice = menu ('Choose Tumor Type','LIVER','BREAST' );

if choice==1 
    % Load your CT scan image
image = imread('C:\..........................');

% Convert black pixels to white pixels
% black_pixels = image(:,:,1) == 0 & image(:,:,2) == 0 & image(:,:,3) == 0;
% image(repmat(black_pixels,[1,1,3])) = 255;


gray_image = rgb2gray(image);

% fs = gray_image;
% se = strel('disk',5);
% A =imerode(fs,se);
% A = gray_image-A ;
% A =imresize(A,2);
% fs = imresize (fs,2); 
% imshowpair(fs , A , 'montage');

% Thresholding to segment potential cancerous regions
threshold_value = 80; % Example threshold value

binary_image =   gray_image < threshold_value    ;


% threshold_value = 255 ;
% binary_image =   binary_image_1  > threshold_value    ;

% Fill small holes in the binary image
 binary_image = imfill(binary_image, 'holes');

% Remove small objects (noise) from the binary image
binary_image = bwareaopen(binary_image, 100);

% Label connected components in the binary image
[labeled_image, num_regions] = bwlabel(binary_image);

% If there are detected regions, assume cancer is present
if num_regions > 0
    fprintf('Cancer is detected.\n');
else
    fprintf('No cancer is detected.\n');
end

% Display the original image with detected regions overlaid
imshow(image) ;
hold on ;

% Outline the detected regions (optional)
boundaries = bwboundaries(labeled_image);
for k = 1 : length(boundaries)
    boundary = boundaries{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
end










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This code is not effective for (dense tissues )

%%%%%%% BREAST %%%%%



else if choice== 2
    % Read the Mammogram scan image
% Read the image
image = imread('C:\.................................');

% Get the dimensions of the image
[rows, cols, ~] = size(image);

% Calculate the dimensions for each quadrant
quarter_rows = floor(rows / 2);
quarter_cols = floor(cols / 2);

% Extract each quadrant
top_left = image(1:quarter_rows, 1:quarter_cols, :);
top_right = image(1:quarter_rows, quarter_cols+1:end, :);
bottom_left = image(quarter_rows+1:end, 1:quarter_cols, :);
bottom_right = image(quarter_rows+1:end, quarter_cols+1:end, :);

% Create a blank image with the same size as the original image
image_without_top_left = uint8(zeros(rows, cols, 3));

% Replace the top left quadrant with zeros
image_without_top_left(1:quarter_rows, quarter_cols+1:end, :) = top_right;
image_without_top_left(quarter_rows+1:end, 1:quarter_cols, :) = bottom_left;
image_without_top_left(quarter_rows+1:end, quarter_cols+1:end, :) = bottom_right;

% Display the result
% imshow(image_without_top_left);
% Preprocess the image (optional)
% Apply filters, enhance contrast, resize, etc.

% Convert the image to grayscale
gray_image = rgb2gray(image_without_top_left);

% fs = gray_image;
% se = strel('disk',5);
% A =imerode(fs,se);
% A = gray_image-A ;
% A =imresize(A,2);
% fs = imresize (fs,2); 
% imshowpair(fs , A , 'montage');

% Thresholding to segment potential cancerous regions

threshold_value = 150; % Example threshold value
binary_image =   gray_image > threshold_value    ;

% Fill small holes in the binary image

binary_image = imfill(binary_image, 'holes');

% Remove small objects (noise) from the binary image

binary_image = bwareaopen(binary_image, 100);

% Label connected components in the binary image

[labeled_image, num_regions] = bwlabel(binary_image);

% If there are detected regions, assume cancer is present

if num_regions > 0
    fprintf('Cancer is detected.\n');
else
    fprintf('No cancer is detected.\n');
end

% Display the original image with detected regions overlaid

imshow(image);
hold on;

% Outline the detected regions (optional)

boundaries = bwboundaries(labeled_image);
for k = 1 : length(boundaries)
    boundary = boundaries{k};
    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
end
    end ;
end ;
