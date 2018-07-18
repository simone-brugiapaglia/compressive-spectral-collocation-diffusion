function [k1,k2] = generate_frequency_arrays_2D(N)

freq_1 = 1:N;
freq_2 = 1:N;
[FREQ_1, FREQ_2] = meshgrid(freq_1,freq_2);
k1 = FREQ_1(:)';
k2 = FREQ_2(:)';

end

