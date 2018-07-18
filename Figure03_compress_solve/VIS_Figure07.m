clear all
close all
addpath ../export_fig
addpath ../utils

load DATA_TEST_Diffusion_2D_u_exact_14-Jul-2018.mat

% FONTSIZE = 15;
% MARKERSIZE = 10;
% LINEWIDTH = 1.5;
% 
% % Visualization
% h_vis = 1/33;
% vis_grid = 0:h_vis:1;
% [X1,X2] = meshgrid(vis_grid,vis_grid);
% 
% figure(1)
% hf{1} = surfc(X1,X2,u_exact(X1,X2));
% ht{1} = title('Exact solution');
% 
% figure(2)
% hf{2} = surfc(X1,X2,u_full(X1,X2));
% ht{2} = title('Full spectral collocation');
% 
% figure(3)
% hf{3} = surfc(X1,X2,u_CS(X1,X2));
% ht{3} = title('Compressive spectral collocation');
% for i_fig = 1:3
%     figure(i_fig)
%     %set(hf{i_fig},'edgecolor','none')
%     set(ht{i_fig},'interpreter','latex')
%     set(gca,'ticklabelinterpreter','latex')
%     hc = colorbar;
%     xlabel('$z_1$','interpreter','latex')
%     ylabel('$z_2$','interpreter','latex')
%     set(hc,'ticklabelinterpreter','latex')
%     axis square
%     set(gcf,'color','white')
%     set(gca,'fontsize',FONTSIZE)
%     colormap autumn
%     %zlim([0,1])
% end
% 
% figure(1)
% export_fig('Figure_7_exact','-eps')
% figure(2)
% export_fig('Figure_7_full','-eps')
% figure(3)
% export_fig('Figure_7_CSC','-eps')
% 
% figure(4)
% stem(x_full,'o','markersize',MARKERSIZE,'linewidth',LINEWIDTH);
% hold on
% stem(x_CS,'x','markersize',MARKERSIZE,'linewidth',LINEWIDTH);
% hold off
% ht = title('Coefficients');
% set(ht,'interpreter','latex');
% hl = legend('Full spectral collocation','Compressive spectral collocation');
% set(hl,'interpreter','latex');
% set(gca,'ticklabelinterpreter','latex')
% grid on
% axis tight
% axis square
% set(gca,'fontsize',FONTSIZE)
% set(gcf,'color','white')
% export_fig('Figure_7_coefficients','-eps')

tic
h_int = 1/(8*(n+1));
x_int = 0:h_int:1-h_int;
[X1_int, X2_int] = meshgrid(x_int,x_int);
u_exact_grid_int = u_exact(X1_int,X2_int);
u_full_grid_int  = u_full(X1_int,X2_int);
u_CS_grid_int    = u_CS(X1_int,X2_int);

u_L2_norm       = h_int * norm(u_exact_grid_int(:),2);
rel_L2_error_full = h_int * norm(u_exact_grid_int(:) - u_full_grid_int(:),2) / u_L2_norm
rel_L2_error_CS = h_int * norm(u_exact_grid_int(:) - u_CS_grid_int(:),2) / u_L2_norm
toc

h_inf = 1/(10*(n+1));
x_inf = 0:h_inf:1;
[X1_inf, X2_inf] = meshgrid(x_inf,x_inf);
u_Linf_norm = max(max(abs(u_exact(X1_inf,X2_inf))))
rel_Linf_err_full = max(max(abs(u_exact(X1_inf,X2_inf)-u_full(X1_inf,X2_inf))))/u_Linf_norm
rel_Linf_err_CS = max(max(abs(u_exact(X1_inf,X2_inf)-u_CS(X1_inf,X2_inf))))/u_Linf_norm