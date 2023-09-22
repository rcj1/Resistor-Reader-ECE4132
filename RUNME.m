function RUNME(impath) % impath: path to image on which to detect resistors
% dark mode (for dark bg) hasn't been tested but  you just say
% T-im2double(Agray) instead of im2double(Agray)-T on line 20
origImage = imread(impath);
load final_wspace.mat % this contains the SVMs
figure()
imshow(origImage)
ax = gca;
% binarize the image
binarizedImg = binarizedImage(origImage);

blobProps = regionprops(binarizedImg, "all");
% go through each blob properties and see if it could be a resistor
for i=1:length(blobProps)
    if blobProps(i).Area > 8000 && (blobProps(i).MajorAxisLength./blobProps(i).MinorAxisLength) > 2 % if the blob could possibly be a resistor
        bb = blobProps(i).BoundingBox; % find its bounding box
        bb(3) = bb(3)-1;
        bb(4) = bb(4)-1;
        imnew = imcrop(origImage, bb);
        imnew = imrotate(imnew, 90-blobProps(i).Orientation); % rotate the image so that blob is aligned with the long side top to bottom

        % now do some morphological operations on the mask to zoom in on
        % the relevant part of the resistor, just the body without any
        % wires or anything
        mask = getMask(blobProps(i));
        newRegionProps = regionprops(bwconncomp(mask), "all"); 
        try
            bb2 = newRegionProps(1).BoundingBox;
        catch
            continue
        end
        bb2(3) = bb2(3)-1;
        bb2(4) = bb2(4)-1;
        imnew = imcrop(imnew, bb2);
        resAndTolerance = findResAndTolerance(imnew, SVM_beige, SVM_blue, SVM_brown);
        if (resAndTolerance ~= "1") % if a valid value is returned
            rectangle(ax, 'Position', bb, "EdgeColor", "black") % display a bounding box
            text(ax, bb(1), bb(2)-15, resAndTolerance) % and the resistance value
        end
    end
end
end