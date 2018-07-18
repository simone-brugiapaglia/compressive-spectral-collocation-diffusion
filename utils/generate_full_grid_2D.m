function full_grid = generate_full_grid_2D(N)
full_grid_1D = (1:N)/(N+1); % 1D grid
[FULL_GRID_X1, FULL_GRID_X2] = meshgrid(full_grid_1D,full_grid_1D);
full_grid = [FULL_GRID_X1(:),FULL_GRID_X2(:)];
end

