color_line=[255,0,255]./255;    % color de la linea
figure(4,'name','Control Box','NumberTitle','off','units','normalized','position',[0.353,0.19,0.3,0.3])
clf
hold on
grid on
title('Station Keeping')
xlabel('Longitud (degrees)')
ylabel('Latitud (degrees)')
axis ([-0.06 0.06 -0.06 0.06],'equal')
ylim([-0.06 0.06])
line([-0.06 0.06],[0 0],'linestyle','-.','color',color_line,'linewidth',2) % eje horizontal
line([-0.05 0.05],[0.05 0.05],'color',color_line,'linewidth',2) % eje horizontal
line([-0.05 0.05],[-0.05 -0.05],'color',color_line,'linewidth',2) % eje horizontal
line([0 0],[-0.06 0.06],'linestyle','-.','color',color_line,'linewidth',2) % eje vertical
line([-0.05 -0.05],[-0.05 0.05],'color',color_line,'linewidth',2) % eje vertical
line([0.05 0.05],[-0.05 0.05],'color',color_line,'linewidth',2) % eje vertical
plot(THreltrue,deltatrue)  
plt_gcb1 = plot(THreltrue(t_cb_i),deltatrue(t_cb_i),'.k','markersize',20);


% Guardar gráfico
print("grafico_encuentro.jpg", "-djpg");



