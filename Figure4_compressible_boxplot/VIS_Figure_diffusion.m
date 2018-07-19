clear all
close all

addpath ../export_fig

load DATA_Figure_6_15-Jul-2018.mat

colors = {rgb('Red'), rgb('ForestGreen'),rgb('Blue'),rgb('DarkMagenta'),rgb('DarkOrange'),'c','y' };
markers = {'d','+','^','x','>','*','<','o','v','s'};
MARKER_SIZE = 10;
FONT_SIZE = 25;

% Accuracy

figure(1)
boxplot(rel_L2_error_full','labels',s_vals)

figure(2)
boxplot(rel_L2_error_full_omp','labels',s_vals)

figure(3)
boxplot(rel_L2_error_CS','labels',s_vals)

% Recovery time
figure(4)
boxplot(time_recovery_full','labels',s_vals)

figure(5)
boxplot(time_recovery_full_omp','labels',s_vals)

figure(6)
boxplot(time_recovery_CS','labels',s_vals)

figure(7)
boxplot(time_assembly_full','labels',s_vals)

figure(8)
boxplot(time_assembly_full','labels',s_vals)

figure(9)
boxplot(time_assembly_CS','labels',s_vals)

for i_fig = 1:9
    figure(i_fig)
    pbaspect([1 1 1])
    if i_fig <= 3
        ylim([min(min([rel_L2_error_full; rel_L2_error_full_omp; rel_L2_error_CS])),...
            max(max([rel_L2_error_full; rel_L2_error_full_omp; rel_L2_error_CS]))]);
        if i_fig == 1
            ylabel('Relative $L^2(\Omega)$-error','interpreter','latex')
        else
            set(gca,'yticklabels',[]);
        end
        %xlabel('$s$','interpreter','latex')
    elseif i_fig <= 6        
        ylim([min(min([time_recovery_full; time_recovery_full_omp; time_recovery_CS])),...
            max(max([time_recovery_full; time_recovery_full_omp; time_recovery_CS]))]);
        if i_fig == 4
            ylabel('Recovery time (sec)','interpreter','latex')
        else
            set(gca,'yticklabels',[]);
        end
        %xlabel('$s$','interpreter','latex')
    elseif i_fig <= 9
        ylim([min(min([time_assembly_full; time_assembly_CS])),...
            max(max([time_assembly_full; time_assembly_CS]))]);
        if i_fig == 7
            ylabel('Assembly time (sec)','interpreter','latex')
        else
            set(gca,'yticklabels',[]);
        end
        xlabel('$s$','interpreter','latex')
    end
    set(gca,'yscale','log')
    grid on
   
    set(gca,'fontsize',FONT_SIZE)
    set(gca,'ticklabelinterpreter','latex')
    set(gcf,'color','white')
    
    export_fig(['Figure_6_',num2str(i_fig)],'-eps')
end



%f1 = figure(1);
%hl = legend(legend_recovery,'location','best');
%set(gca,'fontsize',FONT_SIZE);
%set(gca,'ticklabelinterpreter','latex')
%set(hl,'interpreter','latex','fontsize',FONT_SIZE-2)

%saveas(gcf,'Figure_3_right_a','epsc')



