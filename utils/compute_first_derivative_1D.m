function Df = compute_first_derivative_1D(f)

% Symbolic differentiation
syms x_sym; 
Df_sym = diff(f(x_sym)); 
clear x_sym 

% Conversion to function handle
Df = matlabFunction(Df_sym); 
if nargin(Df) == 0
    Df = @(x) 0*x + Df(); 
end

end

