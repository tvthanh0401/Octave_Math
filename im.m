%Chay dong nay trong command window
%pkg load ltfat
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

B = inv(A);
F=[]
for i=1:size(H,1)

    for j=1:size(H,2)

        h = ceil(B*[i j]');

        F= [F h];
        if h(1) <= 0
          h(1) = 1;
        end
        if h(2) <= 0
          h(2) = 1;
        end
        if h(1) > 256
          h(1) = 256;
        end
        if h(2) > 256
          h(2) = 256;
          end
        K(h(1),h(2))=H(i,j);

    end

end
% pad de lam min anh
figure;
imagesc(K); colormap(gray); axis('image')
iter = 10
for l=1:iter
  for i=1:size(K, 1)
    for j=1:size(K, 2)
      if K(i, j) == 0
        s = 0;
        cnt = 0;
        if i + 1 <= 256
          s = s + K(i + 1, j);
          cnt = cnt + 1;
        end
        if i - 1 >= 1
          s = s + K(i - 1, j);
          cnt = cnt + 1;
        end
        if j + 1 <= 256
          s = s + K(i, j + 1);
          cnt = cnt + 1;
        end
        if j - 1 >= 1
          s = s + K(i, j - 1);
          cnt = cnt + 1;
        end
        if cnt > 0
          K(i, j) = ceil(s / cnt);
        end
      end
    end
  end
end

figure;
imagesc(K); colormap(gray); axis('image')
