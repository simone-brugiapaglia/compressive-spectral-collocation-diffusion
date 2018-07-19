clear all;
close all;

addpath ../utils


% Fix N and the ration m = s log(N). Then assess the cost vs error plot for
% different values of s (and N)
n = 32; % dimension
N = n^2;
s_vals = 2.^(1:6);
m_vals = ceil(2*s_vals*log(N));
N_runs = 100;

u_exact = @(x1,x2) (4 * x1 .* x2 .* (1-x1) .* (1-x2)).^2;
diffusion = @(x1,x2) 1 + 0*x1 + 0* x2; % Diffusion coefficient 

grad_diffusion = compute_gradient_2D(diffusion); % a'(x)
forcing_term = compute_forcing_given_solution_2D(diffusion, grad_diffusion, u_exact);

    
rel_L2_error_full  = zeros(length(s_vals),N_runs);
rel_L2_error_full_omp  = zeros(length(s_vals),N_runs);
rel_L2_error_CS  = zeros(length(s_vals),N_runs);
time_recovery_full = zeros(length(s_vals),N_runs);
time_recovery_full_omp = zeros(length(s_vals),N_runs);
time_recovery_CS = zeros(length(s_vals),N_runs);
time_assembly_full = zeros(length(s_vals),N_runs);
time_assembly_CS = zeros(length(s_vals),N_runs);


h_int = 1/(4*n+1);
x_int = 0:h_int:1-h_int;
[X1_int, X2_int] = meshgrid(x_int,x_int);
u_exact_grid_int = u_exact(X1_int,X2_int);


i_s = 0;
for s = s_vals
    fprintf('%d ',s)
    i_s = i_s + 1;
    
    m = m_vals(i_s);
    
    for i_run = 1:N_runs
        

        
        %% Fourier Spectral Collocation
        % Assembly
        tic;
        full_grid = generate_full_grid_2D(n);
        A_full = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,full_grid);
        f_full = forcing_term(full_grid(:,1),full_grid(:,2));
        time_assembly_full(i_s,i_run) = toc;
        
        % Recovery
        tic;
        x_full = A_full\f_full;
        time_recovery_full(i_s,i_run) = toc;

        
        tic;
        x_full_omp = my_omp(A_full,f_full,s);
        time_recovery_full_omp(i_s,i_run) = toc;
        
        
        
        %% CORSING Fourier Spectral Collocation
        % Assembly
        tic;
        full_grid = generate_full_grid_2D(n);
        random_grid = full_grid(randi([1,N],1,m), :);
        A_CS = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,random_grid);
        f_CS = sqrt(N/m) * forcing_term(random_grid(:,1),random_grid(:,2));
        time_assembly_CS(i_s,i_run) = toc;
        
        % Recovery
        tic;
        x_CS = my_omp(A_CS,f_CS,s);
        time_recovery_CS(i_s,i_run) = toc;
        
        u_full = @(x,y) evaluate_solution_given_coefficients_2D(x_full, x,y);
        u_full_omp = @(x,y) evaluate_solution_given_coefficients_2D(x_full_omp, x,y);
        u_CS = @(x,y) evaluate_solution_given_coefficients_2D(x_CS, x,y);
        
        u_full_grid_int  = u_full(X1_int,X2_int);
        u_full_omp_grid_int = u_full_omp(X1_int,X2_int);
        u_CS_grid_int    = u_CS(X1_int,X2_int);
        
        u_L2_norm                        = h_int * norm(u_exact_grid_int(:),2);
        rel_L2_error_full(i_s,i_run)     = h_int * norm(u_exact_grid_int(:) - u_full_grid_int(:),2) / u_L2_norm;
        rel_L2_error_full_omp(i_s,i_run) = h_int * norm(u_exact_grid_int(:) - u_full_omp_grid_int(:),2) / u_L2_norm;
        rel_L2_error_CS(i_s,i_run)       = h_int * norm(u_exact_grid_int(:) - u_CS_grid_int(:),2) / u_L2_norm;
        
    end
end

fprintf('\n')

save(['DATA_Figure_5_',date],...
    'time_recovery_full','time_assembly_full','rel_L2_error_full',...
    'rel_L2_error_full_omp','time_recovery_full_omp',...
    'time_recovery_CS','time_assembly_CS','rel_L2_error_CS',...
    'N','s_vals','m_vals','diffusion','N_runs','u_exact','h_int')
