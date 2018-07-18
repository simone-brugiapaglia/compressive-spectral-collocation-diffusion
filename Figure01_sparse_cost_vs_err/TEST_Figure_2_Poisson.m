clear all;
close all;

addpath ../utils

% Fix N and the ration m = s log(N). Then assess the cost vs error plot for
% different values of s (and N)
n = 32; % dimension
s_vals = 2.^(1:5);
N = n^2;
m_vals = ceil(2*s_vals*log(N));
N_runs = 5;
%diffusion = @(x) 1 + abs(x-1/2); % Diffusion coefficient a(x)
diffusion = @(x1,x2) 1 + 0*x1 + 0*x2;
grad_diffusion = compute_gradient_2D(diffusion);
    
rel_l2_error_full  = zeros(length(s_vals),N_runs);
time_assembly_full = zeros(length(s_vals),N_runs);
time_recovery_full = zeros(length(s_vals),N_runs);
rel_l2_error_CS  = zeros(length(s_vals),N_runs);
time_assembly_CS = zeros(length(s_vals),N_runs);
time_recovery_CS = zeros(length(s_vals),N_runs);

i_s = 0;
for s = s_vals
    fprintf('%d ',s)
    i_s = i_s + 1;
    
    m = m_vals(i_s);
    
    for i_run = 1:N_runs
        
        x = random_sparse_signal(N,s);
        
        %% Fourier Spectral Collocation
        % Assembly
        tic;
        full_grid = generate_full_grid_2D(n);
        A = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,full_grid);
        f = compute_forcing_given_coefficients_2D(x,diffusion,grad_diffusion,full_grid);
        time_assembly_full(i_s,i_run) = toc;
        
        % Recovery
        tic;
        x_full = A\f;
        time_recovery_full(i_s,i_run) = toc;
        rel_l2_error_full(i_s,i_run) = norm(x_full - x, 2) / norm(x,2);
        
        %% CORSING Fourier Spectral Collocation
        % Assembly
        tic;
        full_grid = generate_full_grid_2D(n);
        random_grid = full_grid(randi([1,N],1,m), :);
        A_CS = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,random_grid);
        f_CS = compute_forcing_given_coefficients_2D(x,diffusion,grad_diffusion,random_grid);
        time_assembly_CS(i_s,i_run) = toc;
        
        % Recovery
        tic;
        x_CS = my_omp(A_CS,f_CS,s);
        time_recovery_CS(i_s,i_run) = toc;
        
        rel_l2_error_CS(i_s,i_run) = norm(x_CS - x,2) / norm(x,2);
    end
end

fprintf('\n')

save(['DATA_Figure_2_left_',date],...
    'time_recovery_full','time_assembly_full','rel_l2_error_full',...
    'time_recovery_CS','time_assembly_CS','rel_l2_error_CS',...
    'N','s_vals','diffusion','N_runs')
