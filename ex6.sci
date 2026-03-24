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
function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    yn = conv(xn, hn);
    Nx = length(xn);
    Nh = length(hn);
    Ny = length(yn);
    n_start_y = (1 - xorigin) + (1 - horigin);
    yorigin   = 1 - n_start_y;
    nx = (1:Nx) - xorigin;
    nh = (1:Nh) - horigin;
    ny = (1:Ny) - yorigin;
    scf();
    subplot(3, 1, 1);
    plot_stem_discrete(nx, xn, 'b');
    xtitle('x(n)  [xorigin = ' + string(xorigin) + ']', 'n', 'Amplitude');
    subplot(3, 1, 2);
    plot_stem_discrete(nh, hn, 'g');
    xtitle('h(n)  [horigin = ' + string(horigin) + ']', 'n', 'Amplitude');
    subplot(3, 1, 3);
    plot_stem_discrete(ny, yn, 'r');
    xtitle('y(n) = x(n)*h(n)  [yorigin = ' + string(yorigin) + ']', 'n', 'Amplitude');
endfunction
