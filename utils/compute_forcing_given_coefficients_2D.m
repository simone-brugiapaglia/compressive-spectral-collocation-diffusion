function y = compute_forcing_given_coefficients_2D(c,diffusion,grad_diffusion,collocation_grid)
N = length(c);
n = sqrt(N);

if(size(collocation_grid,1) < size(collocation_grid,2))
    collocation_grid = collocation_grid';
end

x1 = collocation_grid(:,1);
x2 = collocation_grid(:,2);
m = length(x1);
y = zeros(m,1);
C = reshape(c,n,n)';
for k1 = 1:n
    for k2 = 1:n
        y = y + C(k1,k2) * ( ...
            -((pi * k1) * grad_diffusion{1}(x1,x2) .* cos(pi*k1*x1) .*sin(pi*k2*x2) ...
            +(pi * k2) * grad_diffusion{2}(x1,x2) .* sin(pi*k1*x1) .*cos(pi*k2*x2)) ...
            /(pi^2 * (k1^2+k2^2)) ...
            + diffusion(x1,x2) .* sin(k1*pi*x1) .* sin(k2*pi*x2) ...
            );
    end
end
y = sqrt(N/m) * (2/(n+1)) * y;

