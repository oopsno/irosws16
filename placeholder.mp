prologues := 3; % set up MetaPost for EPS generation
beginfig(1)
z0 = origin; % short form for (0,0)
z1 = (60,40); z2 = (40,90);
z3 = (10,70); z4 = (30,50);
pickup pencircle scaled 1mm;
draw z0; draw z1; draw z2;
draw z3; draw z4;
pickup defaultpen;
draw z0--z1--z2--z3--z4 withcolor blue;
draw z0..z1..z2..z3..z4 withcolor red;
draw z0..z1..z2..z3..z4..z0 withcolor green;
endfig;
end % end of MetaPost run
