function f = compute_forcing_given_solution_2D(diffusion,grad_diffusion,u)
x = sym('x',[2,1]);
grad_u{1} = diff(u(x(1),x(2)), x(1));
grad_u{2} = diff(u(x(1),x(2)), x(2));
Laplacian_u = diff(grad_u{1},x(1)) + diff(grad_u{2},x(2));
f_sym = - grad_diffusion{1}(x(1),x(2)) * grad_u{1} - grad_diffusion{2}(x(1),x(2)) * grad_u{2} - diffusion(x(1),x(2)) * Laplacian_u;
for j = 1:2
    if isAlways(diff(f_sym, x(j)) == 0)
        Is_f_constant_wrt_xj(j) = 1;
    end
end
clear x

% Conversion to function handle
f = matlabFunction(f_sym); 
switch nargin(f)
    case 0 % constant function handle
        f = @(x1,x2) 0*x1 + f();
    case 1 % function handle depending on one variable
        if Is_f_constant_wrt_xj(1) == 1
            f = @(x1,x2) 0*x1 + f(x2);
        elseif Is_f_constant_wrt_xj(2) == 1
            f = @(x1,x2) f(x1) + 0*x2;
        end
end

end

