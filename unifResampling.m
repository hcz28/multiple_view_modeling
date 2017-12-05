function [ urimages,LightR ] = unifResampling( datapath )
[LightO,~] = icosphere(4);
[lightI(:,1),lightI(:,2),lightI(:,3)]=textread(fullfile(datapath,'lightvec.txt'),'%f %f %f',-1);

image_files = dir( fullfile( datapath, '*.bmp') );
num_images = length(image_files);
% images=cell(num_images,1);
[m,n,~]=size(imread(fullfile(datapath,image_files(1).name)));
images=zeros(m,n,num_images);
for i=1:num_images
    image_name=fullfile(datapath,image_files(i).name);
%     images{i}=rgb2gray(mat2gray(imread(image_name)));
    temp_image=double(imread(image_name));
    images(:,:,i)=0.2989 * temp_image(:,:,1) + 0.5870 * temp_image(:,:,2) + 0.1140 * temp_image(:,:,3);
end  
ind = nearestneighbour(lightI', LightO');
urimages=zeros(m,n,0);
LightR=zeros(0,3);
for i=1:size(LightO,1)
    ind2=find(ind==i);
    if ~isempty(ind2)
        Io=zeros(m,n);
        deno=0;
        for j=1:size(ind2)
            deno=deno+LightO(i,:)*lightI(ind2(j),:)';
        end

        for j=1:size(ind2)
            Io=Io+LightO(i,:)*lightI(ind2(j),:)'/deno*images(:,:,ind2(j));
        end
        urimages(:,:,size(urimages,3)+1)=Io;
        LightR=[LightR;LightO(i,:)];
    end
end


end

