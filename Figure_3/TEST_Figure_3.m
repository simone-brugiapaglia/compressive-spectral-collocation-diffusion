clear all;
close all;

addpath utils

% 1D Example
n = 32; % dimension
s = 32;
N = n^2;
m = ceil(2*s*log(N));


%u_exact = @(x1,x2) x1.*(1-x1).*x2.^2.*(1-x2).^3 .* sin(10*pi*x1);
%u_exact = @(x1,x2) 3* sin(5*pi*x1) .* sin(6*pi*x2) + 2* sin(10*pi*x1) .* sin(20*pi*x2) + 1 * sin(15*pi*x1) .* sin(25*pi*x2);
%u_exact = @(x1,x2) (x1 .* (1-x1)/(0.5)).^2 .* (x2 .* (1-x2) / (0.5) ).^2 + sin(32*pi*x1) .* sin(23*pi*x2);% .* cos(8*pi*x1.*x2) ;
u_exact = @(x1,x2) (16 * x1 .* x2 .* (1-x1) .* (1-x2)).^2;
%u_exact = @(x1,x2) sin(4*pi*x1.*x2).^3
diffusion = @(x1,x2) 1 + 1/4*(x1 + x2); % Diffusion coefficient a(x)

grad_diffusion = compute_gradient_2D(diffusion); % a'(x)
forcing_term = compute_forcing_given_solution_2D(diffusion, grad_diffusion, u_exact);


%% Fourier Spectral Collocation
tic
full_grid = generate_full_grid_2D(n);
A = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,full_grid);
f = forcing_term(full_grid(:,1),full_grid(:,2));
time_full_assembly = toc

tic; 
x_full = A\f; 
time_backslash = toc
I = eye(N);

u_full = @(x,y) evaluate_solution_given_coefficients_2D(x_full, x,y);
u_full_grid = u_full(full_grid(:,1),full_grid(:,2));
u_exact_grid = u_exact(full_grid(:,1),full_grid(:,2));
rel_err_backslash = norm(u_full_grid - u_exact_grid, Inf)/ norm(u_exact_grid,Inf)

%% CORSING Fourier Spectral Collocation
tic;
full_grid = generate_full_grid_2D(n);
random_grid = full_grid(randi([1,N],1,m), :);
A_CS = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,random_grid);
f_CS = sqrt(N/m) * forcing_term(random_grid(:,1),random_grid(:,2)) ;
time_assemly_CS = toc

tic; 
x_CS = my_omp(A_CS,f_CS,s); 
time_OMP = toc

u_CS = @(x,y) evaluate_solution_given_coefficients_2D(x_CS, x,y);
u_CS_grid = u_CS(full_grid(:,1),full_grid(:,2));
u_exact_grid = u_exact(full_grid(:,1),full_grid(:,2));
rel_err_OMP = norm(u_CS_grid - u_exact_grid, Inf)/ norm(u_exact_grid,Inf)

% Visualization
h_vis = 1/65;
vis_grid = 0:h_vis:1;
[X1,X2] = meshgrid(vis_grid,vis_grid);


figure(1)
h = pcolor(X1,X2,u_exact(X1,X2));
set(h,'edgecolor','none')
colorbar
title('exact')

figure(2)
h = pcolor(X1,X2,u_full(X1,X2));
set(h,'edgecolor','none')
colorbar
title('Full')

figure(3)
h= pcolor(X1,X2,u_CS(X1,X2));
set(h,'edgecolor','none')
colorbar
title('CS')


figure(4)
stem(x_full,'o');
hold on
stem(x_CS,'x');
hold off
legend('full','CS')
%set(gca,'yscale','log')
%set(gca,'yscale','log')


h_int = 0.01;
x_int = 0:h_int:1-h_int;
[X1_int, X2_int] = meshgrid(x_int,x_int);
u_exact_grid_int = u_exact(X1_int,X2_int);
u_full_grid_int  = u_full(X1_int,X2_int);
u_CS_grid_int    = u_CS(X1_int,X2_int);

u_L2_norm       = h_int * norm(u_exact_grid_int(:),2);
rel_L2_error_full = h_int * norm(u_exact_grid_int(:) - u_full_grid_int(:),2) / u_L2_norm
rel_L2_error_CS = h_int * norm(u_exact_grid_int(:) - u_CS_grid_int(:),2) / u_L2_norm

figure
subplot(1,2,1);imagesc(abs(reshape(x_full,n,n))); colorbar
set(gca,'ydir','normal')
subplot(1,2,2);imagesc(abs(reshape(x_CS,n,n))); colorbar
set(gca,'ydir','normal')

clear A
clear A_CS

save(['DATA_Figure_3_',date])
