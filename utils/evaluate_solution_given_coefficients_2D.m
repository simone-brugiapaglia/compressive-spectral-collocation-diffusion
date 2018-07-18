function ux = evaluate_solution_given_coefficients_2D(c,x1,x2)
N = length(c);
n = sqrt(N);
if mod(n,1) ~= 0
    error('c must have dimension n^2')
end

if ~isequal(size(x1),size(x2))
    error('x1 and x2 must have the same size')
end

% frequencies
[k1,k2] = generate_frequency_arrays_2D(n);

ux = zeros(size(x1));
for j = 1:length(c)
    ux = ux + c(j) * sin(pi * k1(j) * x1) .* sin(pi * k2(j) * x2) / (pi^2 * (k1(j)^2 + k2(j)^2));
end
ux = ux * (2/(n+1));

