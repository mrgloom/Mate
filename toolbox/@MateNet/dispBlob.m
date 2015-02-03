function dispBlob(net,blobNames)

if nargin < 2
  blobNames = net.blobsId.keys();
end

if ~iscell(blobNames)
  blobNames = {blobNames};
end

for blobName = blobNames
  blobName = blobName{1};

  x = squeeze(getBlob(net,blobName));

  if ndims(x) > 4 || isscalar(x)
    warning('Scalars and (>4)-dimensional blobs are not supported in net.distBlob.');
    return
  end

  figure(1000+net.blobsId(blobName));
  set(gcf,'Name',blobName);

  if ndims(x) == 1
    subplot(2,1,1); plot(x); title(blobName);
    subplot(2,1,2); plot(sort(x)); title([blobName ' (sorted)']);
  end

  if ndims(x) == 2
    imagesc(x); colorbar;
  %   if max(size(x)) > 200
  %     imagesc(x);
  %   else
  %     pcolor(x);
  %   end
  end

  if ndims(x) == 3 || ndims(x) == 4
    imagesc(getPlate(x)); 
    if size(x,3) ~= 3
      colorbar;  
    end
  end
end
