clear all
close all

addpath ../utils

load DATA_Figure_1_14-Jul-2018.mat

colors = {rgb('Red'), rgb('ForestGreen'),rgb('Blue'),rgb('DarkMagenta'),rgb('DarkOrange'),'c','y' };
markers = {'d','+','^','x','>','*','<','o','v','s'};
MARKER_SIZE = 15;
FONT_SIZE = 20;
success_threshold = 1e-10;

for i_s = 1:length(s_vals)
    
    successful_runs = find(rel_l2_error_CS(i_s,:) <= success_threshold);
    num_failures(i_s) = N_runs - length(successful_runs) ;
    
    
    figure(1)
    loglog(time_recovery_full(i_s,:),rel_l2_error_full(i_s,:),markers{2*(i_s-1) + 1},'color',colors{i_s},'markersize',MARKER_SIZE)
    hold on
    loglog(time_recovery_CS(i_s,successful_runs),rel_l2_error_CS(i_s,successful_runs),markers{2*(i_s-1) + 2},'color',colors{i_s},'markersize',MARKER_SIZE)
    
    if s_vals(i_s) < 10
        legend_recovery(2*(i_s-1) + 1,:) = ['Full, s =   ',num2str(s_vals(i_s))];%,'                 ','   ',' '];
        legend_recovery(2*(i_s-1) + 2,:) = ['CS,   s =   ',num2str(s_vals(i_s))];%,' (failure rate = ',num2str(num_failures(i_s)/N_runs,'%1.1f'),')'];
    elseif s_vals(i_s) < 100
        legend_recovery(2*(i_s-1) + 1,:) = ['Full, s =  ',num2str(s_vals(i_s))];%,'                 ','   ',' '];
        legend_recovery(2*(i_s-1) + 2,:) = ['CS,   s =  ',num2str(s_vals(i_s))];%,' (failure rate = ',num2str(num_failures(i_s)/N_runs,'%1.1f'),')'];
    else
        legend_recovery(2*(i_s-1) + 1,:) = ['Full, s = ',num2str(s_vals(i_s))];%,'                 ','   ',' '];
        legend_recovery(2*(i_s-1) + 2,:) = ['CS,   s = ',num2str(s_vals(i_s))];%,' (failure rate = ',num2str(num_failures(i_s)/N_runs,'%1.1f'),')'];       
    end
    grid on
    title(['Accuracy vs. Recovery Cost'],'interpreter','latex')
    xlabel('Recovery cost (sec)','interpreter','latex')
    ylabel('Accuracy (relative $\ell^2$-error)','interpreter','latex')
    
    %xlim([0.01,0.04])
    %ylim([9e-15, 2e-13])
   
    
    figure(2)
    loglog(time_assembly_full(i_s,:),rel_l2_error_full(i_s,:),markers{2*(i_s-1) + 1},'color',colors{i_s},'markersize',MARKER_SIZE)
    hold on
    loglog(time_assembly_CS(i_s,successful_runs),rel_l2_error_CS(i_s,successful_runs),markers{2*(i_s-1) + 2},'color',colors{i_s},'markersize',MARKER_SIZE)

    grid on
    title(['Accuracy vs. Assembly Cost'],'interpreter','latex')
    xlabel('Assembly cost (sec)','interpreter','latex')
    ylabel('Accuracy (relative $\ell^2$-error)','interpreter','latex')
    
    %xlim([9e-3, 4e-1])
    %ylim([9e-15, 2e-13])
end

f1 = figure(1);
%hl = legend(legend_recovery,'location','best');
set(gca,'fontsize',FONT_SIZE);
set(gca,'ticklabelinterpreter','latex')
%set(hl,'interpreter','latex','fontsize',FONT_SIZE-2)

saveas(gcf,'Figure_1_a','epsc')


f2 = figure(2);
set(gca,'fontsize',FONT_SIZE);
set(gca,'ticklabelinterpreter','latex','fontsize',FONT_SIZE)

saveas(gcf,'Figure_1_b','epsc')

title('')
hl = legend(legend_recovery,'location','best');
set(hl,'interpreter','latex');
SaveLegendToImage(f2, hl, 'Figure_1_legend','epsc')
