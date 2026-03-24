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
xn      = [2, 3, 4, 5, 6];
xorigin = 3;
N       = length(xn);
nx      = (1:N) - xorigin;
xn_fold   = xn($:-1:1);
xo_fold   = N + 1 - xorigin;
nx_fold   = (1:N) - xo_fold;
n1s = 1 - xorigin;     n1e = N - xorigin;
n2s = 1 - xo_fold;    n2e = N - xo_fold;
ns  = min(n1s, n2s);   ne  = max(n1e, n2e);
Ny  = ne - ns + 1;     yorigin = 1 - ns;
x_pad  = zeros(1, Ny);
xf_pad = zeros(1, Ny);
x_pad(n1s - ns + 1  :  n1s - ns + N)  = xn;
xf_pad(n2s - ns + 1 :  n2s - ns + N)  = xn_fold;
ny = (1:Ny) - yorigin;
xe = (x_pad + xf_pad) / 2;
xo = (x_pad - xf_pad) / 2;
x_reconstructed = xe + xo;
scf();
subplot(3, 1, 1);
plot_stem_discrete(nx, xn, 'b');
xtitle('x(n)  =  {2, 3, 4<--, 5, 6}', 'n', 'Amplitude');
subplot(3, 1, 2);
plot_stem_discrete(ny, xe, 'r');
xtitle('xe(n) = [x(n) + x(-n)] / 2   [even part]', 'n', 'Amplitude');
subplot(3, 1, 3);
plot_stem_discrete(ny, xo, 'g');
xtitle('xo(n) = [x(n) - x(-n)] / 2   [odd part]', 'n', 'Amplitude');
disp('=== Exercise 2.4  -  Even/Odd Decomposition ===');
disp('x(n)   = '); disp(xn);   disp('  n-axis ='); disp(nx);
disp('xe(n)  = '); disp(xe);   disp('  n-axis ='); disp(ny);
disp('xo(n)  = '); disp(xo);   disp('  n-axis ='); disp(ny);
disp(' ');
disp('Verification: xe + xo = '); disp(x_reconstructed);
disp('  (should equal x(n) on same n-axis)');
disp(' ');
disp('Note: xo(0) = ' + string(xo(yorigin)) + '   (always 0 for odd signals)');
disp(' ');
disp('Uniqueness: if two decompositions existed, their difference');
disp('would be simultaneously even and odd, forcing it to be zero.');
