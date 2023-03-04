function RUNME(impath)
% dark mode (for dark bg) hasn't been tested but  you just say
% T-im2double(Agray) instead of im2double(Agray)-T on line 20
A = imread(impath);
load final_wspace.mat
figure()
imshow(A)
ax = gca;
imageSize = size(A);

numRows = imageSize(1);
numCols = imageSize(2);
Anew = imresize(A, max(ceil(650.0/numRows)/10.0, 0.1));
Agray = rgb2gray(Anew);
Agray = imgaussfilt(Agray, 5);
T = adaptthresh(Agray, 0.4, 'NeighborhoodSize', 2*floor(size(Agray)/4)+1);
% if bg_light_or_dark == "dark"
%     g2 = im2double(Agray)-T;
% else
g2 = T-im2double(Agray);
% end
g2b = imbinarize(g2);
g2b = imresize(g2b, [numRows numCols]);

mypps = regionprops(g2b, "all");
for i=1:length(mypps)
    if mypps(i).Area > 8000 && (mypps(i).MajorAxisLength./mypps(i).MinorAxisLength) > 2
        bb = mypps(i).BoundingBox;
        bb(3) = bb(3)-1;
        bb(4) = bb(4)-1;
        imnew = imcrop(A, bb);
        mask = double(mypps(i).FilledImage);
        mask = imclose(mask, strel('disk', round(mypps(i).MinFeretDiameter/3)));
        mask = imopen(mask, strel('disk', round(mypps(i).MinFeretDiameter/4)));
        mask = imrotate(mask, 90-mypps(i).Orientation);
        imnew = imrotate(imnew, 90-mypps(i).Orientation); % fix and don't let the rot border do something
        mysecond = regionprops(bwconncomp(mask), "all");
        try
            bb2 = mysecond(1).BoundingBox;
        catch
            continue
        end
        bb2(3) = bb2(3)-1;
        bb2(4) = bb2(4)-1;
        imnew2 = imcrop(imnew, bb2);
        rval = workerbee(imnew2, SVM_beige, SVM_blue, SVM_brown);
        if (rval ~= "1")
            rectangle(ax, 'Position', bb, "EdgeColor", "black")
            text(ax, bb(1), bb(2)-15, rval)
        end
    end
end
end