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
n_x  = -3:3;
N    = length(n_x);
xn   = zeros(1, N);
for i = 1:N
    nv = n_x(i);
    if nv >= -3 & nv <= -1 then
        xn(i) = 1 + nv/3;
    elseif nv >= 0 & nv <= 3 then
        xn(i) = 1;
    end
end
xorigin = 4;
yn_fold   = xn($:-1:1);
yo_fold   = N + 1 - xorigin;
yn_b1     = yn_fold;
yo_b1     = yo_fold - 4;
ny_b1     = (1:N) - yo_b1;
yn_del4   = xn;
yo_del4   = xorigin - 4;
yn_b2     = yn_del4($:-1:1);
yo_b2     = N + 1 - yo_del4;
ny_b2     = (1:N) - yo_b2;
yn_c   = yn_b1;
yo_c   = yo_b1;
ny_c   = ny_b1;
nx = (1:N) - xorigin;
scf();
subplot(4, 1, 1);
plot_stem_discrete(nx, xn, 'b');
xtitle('x(n)  [original]', 'n', 'Amplitude');
subplot(4, 1, 2);
plot_stem_discrete(ny_b1, yn_b1, 'r');
xtitle('(b1) fold then delay 4  ->  x(-n+4)', 'n', 'Amplitude');
subplot(4, 1, 3);
plot_stem_discrete(ny_b2, yn_b2, 'g');
xtitle('(b2) delay 4 then fold  ->  x(-n-4)', 'n', 'Amplitude');
subplot(4, 1, 4);
plot_stem_discrete(ny_c, yn_c, 'm');
xtitle('(c) x(-n+4) directly  [same as b1 -> rule confirmed]', 'n', 'Amplitude');
disp('=== Exercise 2.1 ===');
disp('x(n) values:');  disp(xn);
disp('x(n) n-axis:');  disp(nx);
disp(' ');
disp('(b1) fold then delay by 4  =>  x(-n+4)');
disp('  yn  ='); disp(yn_b1);
disp('  n-axis ='); disp(ny_b1);
disp(' ');
disp('(b2) delay by 4 then fold  =>  x(-n-4)');
disp('  yn  ='); disp(yn_b2);
disp('  n-axis ='); disp(ny_b2);
disp(' ');
disp('(c)  x(-n+4) directly: identical to (b1) -- rule confirmed');
disp(' ');
disp('(d) RULE: to get x(-n+k), always FOLD first, then DELAY by k.');
disp('    Reversing the order (delay then fold) gives x(-n-k) instead.');
disp(' ');
n_e  = -4:5;
Ne   = length(n_e);
u_p2 = double(n_e >= -2);
u_p1 = double(n_e >= -1);
u_0  = double(n_e >= 0);
u_m4 = double(n_e >= 4);
xe = (1/3) * (u_p2 + u_p1 + u_0) - u_m4;
xn_padded = zeros(1, Ne);
for i = 1:Ne
    nv = n_e(i);
    if nv >= -3 & nv <= -1 then
        xn_padded(i) = 1 + nv/3;
    elseif nv >= 0 & nv <= 3 then
        xn_padded(i) = 1;
    end
end
scf();
subplot(2, 1, 1);
plot_stem_discrete(n_e, xn_padded, 'b');
xtitle('x(n)  [original, extended view]', 'n', 'Amplitude');
subplot(2, 1, 2);
plot_stem_discrete(n_e, xe, 'r');
xtitle('(e) x(n) = (1/3)[u(n+2)+u(n+1)+u(n)] - u(n-4)  [reconstructed]', 'n', 'Amplitude');
disp('(e) x(n) expressed via u(n):');
disp('    x(n) = (1/3)[u(n+2) + u(n+1) + u(n)] - u(n-4)');
disp(' ');
disp('    Verification — reconstructed values:'); disp(xe);
disp('    Original values (extended):');          disp(xn_padded);
if max(abs(xe - xn_padded)) < 1e-10 then
    disp('    => Match confirmed.');
else
    disp('    => MISMATCH — check formula.');
end
