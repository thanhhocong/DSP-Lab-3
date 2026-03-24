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
function v = lookup(xn, xorigin, n_val)
    idx = n_val + xorigin;
    if idx >= 1 & idx <= length(xn) then
        v = xn(idx);
    else
        v = 0;
    end
endfunction
xn      = [0, 0, 1, 1, 1, 1, 0.5, 0.5, 0, 0];
xorigin = 4;
N       = length(xn);
nx      = (1:N) - xorigin;
n_sq_range = -3:3;
Ns   = length(n_sq_range);
yn   = zeros(1, Ns);
for i = 1:Ns
    nv    = n_sq_range(i);
    yn(i) = lookup(xn, xorigin, nv^2);
end
yorigin = 4;
ny      = (1:Ns) - yorigin;
yn1    = yn;
yo1    = yorigin - 2;
ny1    = (1:Ns) - yo1;
xorigin2 = xorigin - 2;
yn2 = zeros(1, Ns);
for i = 1:Ns
    nv     = n_sq_range(i);
    yn2(i) = lookup(xn, xorigin2, nv^2);
end
yo2 = yorigin;
ny2 = (1:Ns) - yo2;
nc  = -3:5;
Nc  = length(nc);
y1c = zeros(1, Nc);
y2c = zeros(1, Nc);
for i = 1:Ns
    idx1 = ny1(i) - nc(1) + 1;   if idx1 >= 1 & idx1 <= Nc then y1c(idx1) = yn1(i); end
    idx2 = ny2(i) - nc(1) + 1;   if idx2 >= 1 & idx2 <= Nc then y2c(idx2) = yn2(i); end
end
are_equal = and(y1c == y2c);
scf();
subplot(4, 1, 1);
plot_stem_discrete(nx, xn, 'b');
xtitle('x(n)  [original input]', 'n', 'Amplitude');
subplot(4, 1, 2);
plot_stem_discrete(ny, yn, 'b');
xtitle('y(n) = T[x(n)] = x(n^2)', 'n', 'Amplitude');
subplot(4, 1, 3);
plot_stem_discrete(ny1, yn1, 'r');
xtitle('Path A:  y1(n) = y(n-2)   [delay OUTPUT by 2]', 'n', 'Amplitude');
subplot(4, 1, 4);
plot_stem_discrete(ny2, yn2, 'g');
xtitle('Path B:  y2(n) = T[x(n-2)] = x(n^2-2)   [delay INPUT then apply T]', 'n', 'Amplitude');
scf();
subplot(2, 1, 1);
plot_stem_discrete(nc, y1c, 'r');
xtitle('y1(n) = y(n-2)   [Path A]', 'n', 'Amplitude');
subplot(2, 1, 2);
plot_stem_discrete(nc, y2c, 'g');
xtitle('y2(n) = T[x(n-2)]   [Path B]', 'n', 'Amplitude');
disp('=== Exercise 2.6  -  Time Invariance of y(n) = x(n^2) ===');
disp(' ');
disp('y(n) = x(n^2) for n in [-3..3]:');
disp(yn);   disp('n-axis:'); disp(ny);
disp(' ');
disp('Path A  -  y1(n) = y(n-2)  [delay OUTPUT by 2]:');
disp(yn1);  disp('n-axis:'); disp(ny1);
disp(' ');
disp('Path B  -  y2(n) = T[x(n-2)] = x(n^2 - 2)  [delay INPUT then apply T]:');
disp(yn2);  disp('n-axis:'); disp(ny2);
disp(' ');
disp('Signals on common axis [-3..5]:');
disp('  y1 ='); disp(y1c);
disp('  y2 ='); disp(y2c);
disp(' ');
if are_equal then
    disp('RESULT: y1 == y2  ->  System is TIME-INVARIANT (unexpected)');
else
    disp('RESULT: y1 != y2  ->  System y(n) = x(n^2) is TIME-VARIANT.');
    disp('        Delaying the output != delaying the input then applying T.');
end
