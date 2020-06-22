close all;
clear all;
clc;
a = dir('*.pgm');
A = [];
figure;
hold on;
for i=1:30
  im = imread(a(i).name);
  [h w] = size(im);
  d = h * w;
  subplot(3, 10, i);
  imshow(im);
  A = [A; reshape(im, 1, d)];
end
disp(size(A));
A = double(A');
disp(size(A));
mA = mean(A, 2);
##figure;
##colormap gray;
##imagesc(reshape(ceil(mA), 243, 320));
figure;
for i=1:30
  A(:, i) = A(:, i) - mA;
end
colormap gray;
hold on; 
[U S V] = svd(A, 0);
min_vecto = min(U')';
for i=1:6
  subplot(2, 3, i);
  %cIM = (U(:, i) - min_vecto) * 80;
  cIM = U(:, i);
  %imshow(reshape(uint8(cIM),243, 320)); 
  cIM = reshape(cIM,243, 320);
  nIM = zeros(243, 320);
  for j=1:243
    for k=1:320
      nIM(j, k) = (cIM(j, k) - min(cIM(:, k))) / (max(cIM(:, k) - min(cIM(:, k))));
    end
  end
  imshow(uint8(nIM * 255));
end

figure;
imshow(im);
curr_vector = reshape(double(im), 1, d)' - mA;
disp(size(curr_vector));
final_vector = zeros(243*320, 1);
##s = 0
##for i=1:6
##  proj = dot(curr_vector, U(:, i));
##  disp(proj);
##  s = s + proj^2;
##end
##s = sqrt(s);
for i=1:6
  proj = dot(curr_vector, U(:, i));
  final_vector = final_vector + proj * U(:, i);
end
figure;
colormap gray;
final_vector = reshape(final_vector, 243, 320);
nIM = zeros(243, 320);
for i=1:243
  for j=1:320
    nIM(i, j) = (final_vector(i, j) - min(final_vector(:, j))) / (max(final_vector(:, j)) - min(final_vector(:, j)));
  end
end

imshow(uint8(nIM * 255));