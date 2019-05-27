#!/usr/bin/gnuplot -persist

set title "Perf data"
set xlabel "Round"
set ylabel "ct"
set grid
plot "grouped.txt" u (column(0)):2:xtic(1) w l title "","grouped.txt" u (column(0)):3:xtic(1) w l title ""