function plot_stem_discrete(n_axis, values, line_color)
    if argn(2) < 3 then line_color = 'b'; end
    N     = length(n_axis);
    n_min = min(n_axis);
    n_max = max(n_axis);
    x_seg = zeros(1, 3*N);
    y_seg = zeros(1, 3*N);
    for i = 1:N
        x_seg(3*i-2) = n_axis(i);  x_seg(3*i-1) = n_axis(i);  x_seg(3*i) = %nan;
        y_seg(3*i-2) = 0;          y_seg(3*i-1) = values(i);  y_seg(3*i) = %nan;
    end
    plot([n_min-1, n_max+1], [0, 0], 'k-');
    set(gca(), 'auto_clear', 'off');
    plot(x_seg, y_seg, line_color + '-');
    set(gca(), 'auto_clear', 'off');
    plot(n_axis, values, line_color + 'o');
endfunction
function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    N1 = length(x1n);   N2 = length(x2n);
    n1s = 1 - x1origin;   n1e = N1 - x1origin;
    n2s = 1 - x2origin;   n2e = N2 - x2origin;
    ns = min(n1s, n2s);
    ne = max(n1e, n2e);
    Ny = ne - ns + 1;
    yorigin = 1 - ns;
    x1p = zeros(1, Ny);   x2p = zeros(1, Ny);
    i1  = n1s - ns + 1;   i2  = n2s - ns + 1;
    x1p(i1 : i1+N1-1) = x1n;
    x2p(i2 : i2+N2-1) = x2n;
    yn = x1p + x2p;
    nx1 = (1:N1) - x1origin;
    nx2 = (1:N2) - x2origin;
    ny  = (1:Ny) - yorigin;
    scf();
    subplot(3, 1, 1);
    plot_stem_discrete(nx1, x1n, 'b');
    xtitle('x1(n)  [x1origin = ' + string(x1origin) + ']', 'n', 'Amplitude');
    subplot(3, 1, 2);
    plot_stem_discrete(nx2, x2n, 'g');
    xtitle('x2(n)  [x2origin = ' + string(x2origin) + ']', 'n', 'Amplitude');
    subplot(3, 1, 3);
    plot_stem_discrete(ny, yn, 'r');
    xtitle('y(n) = x1(n) + x2(n)  [yorigin = ' + string(yorigin) + ']', 'n', 'Amplitude');
endfunction
