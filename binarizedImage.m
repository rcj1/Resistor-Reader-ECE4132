function binarized = binarizedImage(original)
imageSize = size(original);

numRows = imageSize(1);
numCols = imageSize(2);
Agray = imresize(original, max(ceil(650.0/numRows)/10.0, 0.1));
Agray = rgb2gray(Agray);
Agray = imgaussfilt(Agray, 5);
Thresholded = adaptthresh(Agray, 0.4, 'NeighborhoodSize', 2*floor(size(Agray)/4)+1);
% if bg_light_or_dark == "dark"
%     g2 = im2double(Agray)-T;
% else
binarized = Thresholded-im2double(Agray);
% end
binarized = imbinarize(binarized);
binarized = imresize(binarized, [numRows numCols]);
end