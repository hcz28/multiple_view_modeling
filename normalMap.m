function normalMap( normal,datapath,titlename )
L=[1/sqrt(3),1/sqrt(3),1/sqrt(3)];
[m,n,~]=size(normal);
normMap=zeros(m,n);
for i=1:m
    for j=1:n
        a=squeeze(normal(i,j,:));
        normMap(i,j)=L*a;
    end
end
figure;
imshow(normMap);
title(titlename);
imwrite(normMap,[datapath titlename '.jpg']);
end

