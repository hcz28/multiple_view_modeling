function [ refNormal ] = normalRefine( normal,lambda,sigma )
[vv,~]=icosphere(5);
N=vv(vv(:,3)>0,:);
amplify=10000;
[m,n,~]=size(normal);
renormal=zeros(m*n,3);
for i=1:3
    renormal(:,i)=reshape(normal(:,:,i)',[m*n,1]);
end

% datacost=zeros(size(N,1),m*n);
% for i=1:size(datacost,1)
%     for j=1:size(datacost,2)
%         datacost(i,j)=norm(N(i,:)-normal(j,:));
%     end
% end
datacost=pdist2(N,renormal);
datacost=int32(amplify*datacost);

% smoothcost=zeros(size(N,1),size(N,1));
% sigma=0.4;
% for i=1:size(smoothcost,1)
%     for j=1:size(smoothcost,2)
%         smoothcost(i,j)=log(1+norm(N(i,:)-N(j,:))/(2*sigma^2));
%     end
% end
smoothMat=pdist2(N,N);
smoothcost=log(1+smoothMat/(2*sigma*sigma));
smoothcost=int32(amplify*lambda*smoothcost);


AdjMatrix = getAdj([m,n]);
mrf=GCO_Create(size(renormal,1),size(N,1));
GCO_SetDataCost(mrf,datacost);
GCO_SetSmoothCost(mrf,smoothcost);
GCO_SetNeighbors(mrf,AdjMatrix);
GCO_Expansion(mrf);
Labeling = GCO_GetLabeling(mrf);
GCO_Delete(mrf);

refNormal=zeros(m,n,3);
for i=1:m
    for j=1:n        
    refNormal(i,j,:)=N(Labeling((i-1)*n+j),:);
    end
end

end

