%chay lenh pkg load ltfat trong command window
close all;
clear all;
IM = cameraman;
figure;
imagesc(cameraman); colormap(gray); axis('image')
A = [1 0.5 ; 0.2 0.8]

F=[]

for i=1:size(IM,1)

    for j=1:size(IM,2)

        h = ceil(A*[i j]');

        F= [F h];

        H(h(1),h(2))=IM(i,j);

    end

end
figure;
imagesc(H); colormap(gray); axis('image')
% y - 4.92307x = 0
% y - 5.0196x + 901.0196 = 0
% y - 0.6244x = 0
% y - 0.6275x - 223.3725 = 0
backup = []
p = []
for x=1:size(H, 1)
  for y=1:size(H, 2)
    j = x;
    i = y;
    if ((j - 4.92307*i) * (j - 5.0196 * i + 901.0196) <= 0) && ((j - 0.6244*i) * (j - 0.6275*i - 223.3725) <= 0)
      backup = [backup; x y];
      p = [p; x y];
    endif
  endfor
endfor
%p = [0 52 205 256; 0 256 128 384];
p = p';
backup = backup';
mx = mean(p(1, :));
my = mean(p(2, :));
p(1, :) = p(1, :) - mx;
p(2, :) = p(2, :) - my;
sigma = p * p' / size(p, 2);
[V D] = eig(inv(sigma));
W = inv(V) * D.^0.5 * V;
pn = W * p;
pn(1, :) = pn(1, :) + abs(min(pn(1, :)));
pn(2, :) = pn(2, :) + abs(min(pn(2, :)));
for i=1:size(p,2)
  h = pn(1:2, i) * 100;
  h = ceil(h);
  if h(1) <= 0
    h(1) = 1;
  end
  if h(2) <= 0
    h(2) = 1;
  end
  K(h(1), h(2)) = H(backup(1, i), backup(2, i));
endfor
figure;
imagesc(K); colormap(gray); axis('image')
##figure;
##plot(pn(1, :), pn(2, :), 'ro');
