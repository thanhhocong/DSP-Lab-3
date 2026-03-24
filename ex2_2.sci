function plot_stem_discrete(n_axis, values, line_color)
    if argn(2) < 3 then line_color = 'b'; end
    N     = length(n_axis);
    n_min = min(n_axis);   n_max = max(n_axis);
    x_seg = zeros(1, 3*N);   y_seg = zeros(1, 3*N);
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
function [x1p, x2p, ns, Ny, yorigin] = align2(x1n, x1o, x2n, x2o)
    N1 = length(x1n);   N2 = length(x2n);
    n1s = 1-x1o;  n1e = N1-x1o;
    n2s = 1-x2o;  n2e = N2-x2o;
    ns  = min(n1s, n2s);
    ne  = max(n1e, n2e);
    Ny  = ne - ns + 1;
    yorigin = 1 - ns;
    x1p = zeros(1, Ny);   x2p = zeros(1, Ny);
    x1p(n1s-ns+1 : n1s-ns+N1) = x1n;
    x2p(n2s-ns+1 : n2s-ns+N2) = x2n;
endfunction
xn      = [0, 0, 1, 1, 1, 1, 0.5, 0.5, 0, 0];
xorigin = 4;
N       = length(xn);
nx      = (1:N) - xorigin;
yn_a  = xn;
yo_a  = xorigin - 2;
ny_a  = (1:N) - yo_a;
yn_fold = xn($:-1:1);
yo_fold = N + 1 - xorigin;
yn_b    = yn_fold;
yo_b    = yo_fold - 4;
ny_b    = (1:N) - yo_b;
yn_c  = xn;
yo_c  = xorigin + 2;
ny_c  = (1:N) - yo_c;
yn_d  = xn;
yn_d(xorigin+3 : N) = 0;
yo_d  = xorigin;
ny_d  = (1:N) - yo_d;
val_e = xn(2 + xorigin);
yn_e  = [val_e];
yo_e  = 1 - 3;
ny_e  = (1:1) - yo_e;
n_f_range = -3:3;
Nf   = length(n_f_range);
yo_f = 4;
yn_f = zeros(1, Nf);
for i = 1:Nf
    nv  = n_f_range(i);
    idx = nv^2 + xorigin;
    if idx >= 1 & idx <= N then
        yn_f(i) = xn(idx);
    end
end
ny_f = (1:Nf) - yo_f;
yn_fold_g = xn($:-1:1);
yo_fold_g = N + 1 - xorigin;
[x_pad_g, xf_pad_g, ns_g, Ny_g, yo_g] = align2(xn, xorigin, yn_fold_g, yo_fold_g);
yn_g = (x_pad_g + xf_pad_g) / 2;
ny_g = (1:Ny_g) - yo_g;
yn_h = (x_pad_g - xf_pad_g) / 2;
ny_h = ny_g;
yo_h = yo_g;
scf();
subplot(4, 1, 1);
plot_stem_discrete(nx, xn, 'b');
xtitle('x(n)  [original, xorigin=4]', 'n', 'Amplitude');
subplot(4, 1, 2);
plot_stem_discrete(ny_a, yn_a, 'r');
xtitle('(a)  x(n-2)   [delay by 2]', 'n', 'Amplitude');
subplot(4, 1, 3);
plot_stem_discrete(ny_b, yn_b, 'g');
xtitle('(b)  x(4-n)   [fold then delay 4]', 'n', 'Amplitude');
subplot(4, 1, 4);
plot_stem_discrete(ny_c, yn_c, 'm');
xtitle('(c)  x(n+2)   [advance by 2]', 'n', 'Amplitude');
scf();
subplot(4, 1, 1);
plot_stem_discrete(ny_d, yn_d, 'r');
xtitle('(d)  x(n)*u(2-n)   [zero-out n>2]', 'n', 'Amplitude');
subplot(4, 1, 2);
plot_stem_discrete(ny_e, yn_e, 'g');
xtitle('(e)  x(n-1)*delta(n-3)   [single sample at n=3, value=x(2)=1]', 'n', 'Amplitude');
subplot(4, 1, 3);
plot_stem_discrete(ny_f, yn_f, 'm');
xtitle('(f)  x(n^2)   [nonlinear index substitution]', 'n', 'Amplitude');
subplot(4, 1, 4);
plot_stem_discrete(ny_g, yn_g, 'b');
xtitle('(g)  xe(n) = [x(n)+x(-n)]/2   [even part]', 'n', 'Amplitude');
set(gca(), 'auto_clear', 'off');
plot_stem_discrete(ny_h, yn_h, 'r');
scf();
subplot(2, 1, 1);
plot_stem_discrete(ny_g, yn_g, 'b');
xtitle('(g)  Even part  xe(n)', 'n', 'Amplitude');
subplot(2, 1, 2);
plot_stem_discrete(ny_h, yn_h, 'r');
xtitle('(h)  Odd part   xo(n)', 'n', 'Amplitude');
disp('=== Exercise 2.2 ===');
disp('(a) yn = x(n-2):');  disp(yn_a);  disp('yorigin ='); disp(yo_a);
disp('(b) yn = x(4-n):');  disp(yn_b);  disp('yorigin ='); disp(yo_b);
disp('(c) yn = x(n+2):');  disp(yn_c);  disp('yorigin ='); disp(yo_c);
disp('(d) yn = x(n)u(2-n):'); disp(yn_d); disp('yorigin ='); disp(yo_d);
disp('(e) yn = x(n-1)delta(n-3): value=' + string(val_e) + ' at n=3');
disp('(f) yn = x(n^2):'); disp(yn_f); disp('n-axis ='); disp(ny_f);
disp('(g) even part:'); disp(yn_g);
disp('(h) odd  part:'); disp(yn_h);
