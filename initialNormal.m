function [ iniNormal ] = initialNormal( images,lightVec )
[m,n,numImages]=size(images);
rank_images=zeros(m,n,numImages);

for i=1:m
    for j=1:n
        pixels=images(i,j,:);
        [~,I]=sort(pixels);
        rank_images(i,j,I)=1:numImages;
    end
end

RL=0.7*numImages;
RH=0.9*numImages;
count=0;
numDeno=0;
for i=1:numImages
    rank_image=rank_images(:,:,i);
    rank_image=rank_image(rank_image>RL);
    if mean(rank_image)<RH && size(rank_image,1)>count
        count=length(rank_image);       
        numDeno=i;
    end
end
imageDeno=images(:,:,numDeno);
images(:,:,numDeno)=[];
lightDeno=lightVec(numDeno,:);
lightVec(numDeno,:)=[];

%% initial normal estimation
% A=zeros(numImages,3);
% B=zeros(num_images,1);
iniNormal=zeros(m,n,3);
for i=1:m
    for j=1:n
        Ii=squeeze(images(i,j,:));
        Ik=imageDeno(i,j);
        A=Ii*lightDeno-Ik*lightVec;
        [~,~,v]=svd(A,0);
        x=v(:,end);        
        if x(3)<0
            x=-x;
        end     
        iniNormal(i,j,:)=x;
        
    end
end

end

