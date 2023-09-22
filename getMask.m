function mask = getMask(blobProp)
mask = double(blobProp.FilledImage);
mask = imclose(mask, strel('disk', round(blobProp.MinFeretDiameter/3)));
mask = imopen(mask, strel('disk', round(blobProp.MinFeretDiameter/4)));
mask = imrotate(mask, 90-blobProp.Orientation);
end