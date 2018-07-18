function f = compute_forcing_given_solution_1D(diffusion,D_diffusion,u)
syms x
Du_sym = diff(u(x),x);
D2u_sym = diff(Du_sym,x);
f_sym = - D_diffusion(x) * Du_sym - diffusion(x) * D2u_sym;
clear x

% Conversion to function handle
f = matlabFunction(f_sym); 
if nargin(f) == 0
    f = @(x) 0*x + f(); 
end

end

