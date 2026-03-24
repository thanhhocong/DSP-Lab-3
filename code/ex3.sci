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
function [yn, yorigin] = fold(xn, xorigin)
    N       = length(xn);
    yn      = xn($:-1:1);
    yorigin = N + 1 - xorigin;
    nx = (1:N) - xorigin;
    ny = (1:N) - yorigin;
    scf();
    subplot(2, 1, 1);
    plot_stem_discrete(nx, xn, 'b');
    xtitle('x(n)  [xorigin = ' + string(xorigin) + ']', 'n', 'Amplitude');
    subplot(2, 1, 2);
    plot_stem_discrete(ny, yn, 'r');
    xtitle('y(n) = x(-n)  [yorigin = ' + string(yorigin) + ']', 'n', 'Amplitude');
endfunction
