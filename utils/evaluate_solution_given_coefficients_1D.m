function ux = evaluate_solution_given_coefficients_1D(c,eval_grid)
ux = zeros(size(eval_grid));
N = length(c);
for k = 1:N
    ux = ux + c(k) * sin(pi * k * eval_grid) / (k*pi)^2;
end
ux = sqrt(2/(N+1)) * ux;
end

