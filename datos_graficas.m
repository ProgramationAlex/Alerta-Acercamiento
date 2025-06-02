# datos para las gráficas
# Ground track
# Cálculo de la proyección del satélite sobre la superficie de la tierra 
tic
pha1=0;
reje=norm([max(max(z(1,:))) max(max(z(3,:)))]); 
xgt = zeros(length(t),1);
ygt = zeros(length(t),1);
zgt = zeros(length(t),1);
proy = zeros(length(t),3);
  for i=1:length(t)
    proy(i,:)=rt*[ECFtrue(1,i) ECFtrue(3,i) ECFtrue(5,i)]./norm([ECFtrue(1,i) ECFtrue(3,i) ECFtrue(5,i)]);
    end    
    xgt=proy(:,1);
    ygt=proy(:,2);
    zgt=proy(:,3);
    toc