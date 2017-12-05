function f = gaussianf(sigma, rows, cols)

    [x,y] = meshgrid( [1:cols]-(fix(cols/2)+1), [1:rows]-(fix(rows/2)+1));
    r = sqrt(x.^2 + y.^2);
    f = fftshift(exp(-r.^2/(2*sigma^2)));