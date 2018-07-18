function A = collocation_matrix_diffusion_1D(diffusion,D_diffusion,N,collocation_grid)
m = length(collocation_grid);
freq = (1:N); % frequencies 
A1 =  diag(diffusion(collocation_grid)) * sin(pi * collocation_grid(:) * freq); % - a(x) psi_k''(x)
A2 = - diag(D_diffusion(collocation_grid)) * cos(pi * collocation_grid(:) * freq) * diag(1./(pi*freq)); % - a'(x) psi_k'(x)
A = sqrt(N/m) * sqrt(2/(N+1)) * (A1 + A2);

end

