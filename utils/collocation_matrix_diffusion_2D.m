function A = collocation_matrix_diffusion_2D(diffusion,grad_diffusion,n,collocation_grid)

m = max(size((collocation_grid)));
N = n^2;

if m <= 2
    error('Use more than 2 collocation points')
end

if(size(collocation_grid,1) < size(collocation_grid,2))
    collocation_grid = collocation_grid';
end

[k1,k2] = generate_frequency_arrays_2D(n); % generated as row vectors

x1 = collocation_grid(:,1);
x2 = collocation_grid(:,2);

% - < grad[a], grad[psi_k] > 
A11 = (grad_diffusion{1}(x1,x2) * pi * k1) .* cos(pi*x1*k1) .* sin(pi*x2*k2);
A12 = (grad_diffusion{2}(x1,x2) * pi * k2) .* sin(pi*x1*k1) .* cos(pi*x2*k2);
A1 = - (A11 + A12) * diag(1./(pi^2 * (k1.^2 + k2.^2))); 

% - a Laplacian[psi_k] 
A2 =  diag(diffusion(x1,x2)) * (sin(pi*x1*k1) .* sin(pi*x2*k2)); 

A = sqrt(N/m) * (2/(n+1)) * (A1 + A2);

end

