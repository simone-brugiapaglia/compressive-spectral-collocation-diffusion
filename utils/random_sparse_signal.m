function x = random_sparse_signal(N,s)

x = zeros(N,1); 
support = randi([1,N],s,1); 
x(support) = randn(s,1); 
end

