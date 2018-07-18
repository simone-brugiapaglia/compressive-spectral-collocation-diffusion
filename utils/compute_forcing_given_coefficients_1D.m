function y = compute_forcing_given_coefficients_1D(c,diff,diff_der,x)
N = length(c);
m = length(x);
y = zeros(m,1);
for k = 1:N
    y = y + c(k) * (-cos(k*pi*x)/(k*pi) .* diff_der(x) + sin(k*pi*x) .* diff(x));
end
y = sqrt(N/m) * sqrt(2/(N+1)) * y;

