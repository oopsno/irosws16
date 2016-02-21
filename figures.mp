input boxes

vardef cuta(suffix a, b) expr p =
    drawarrow p cutbefore bpath a cutafter bpath b;
    point .5*length p of p
enddef;

vardef dcuta(suffix a, b) expr p =
    drawdblarrow p cutbefore bpath a cutafter bpath b;
    point .5*length p of p
enddef;

vardef cutac(suffix a, b) (expr p, c) =
    drawarrow p cutbefore bpath a cutafter bpath b withcolor c;
    point .5*length p of p
enddef;

vardef dcutac(suffix a, b) (expr p, c) =
    drawdblarrow p cutbefore bpath a cutafter bpath b withcolor c;
    point .5*length p of p
enddef;

vardef cutared(suffix a, b) expr p = 
    cutac(a, b, p, red)
enddef;

vardef cutared(suffix a, b) expr p = 
    cutac(a, b, p, red)
enddef;

vardef cutared(suffix a, b) expr p = 
    cutac(a, b, p, red)
enddef;

vardef self@# expr p =
    cuta(@#,@#) @#.c{curl0}..@#.c+p..{curl0}@#.c
enddef;

interim defaultdx:=5;
interim defaultdy:=5;

% Goblin
beginfig(1);
    % Components
    boxjoin(a.ne=b.nw - (30, 0) ; a.se=b.sw - (30, 0));
    boxit.shadow(btex Shadow etex);
    boxit.illumint(btex Illumint etex);
    boxit.daemon(btex Daemon etex);

    boxjoin(a.c = b.c + (0, 30));
    boxit.mid(btex Middleman etex);
    illumint.c = origin;
    mid.c = daemon.c + (0, 40);
    drawboxed(shadow, illumint, daemon, mid);
    % Logic
    label.top(btex(a)etex, dcuta(shadow, illumint) shadow.e .. illumint.w);
    label.top(btex(b)etex, dcuta(illumint, daemon) illumint.e .. daemon.w);
    label.rt(btex(c)etex, dcuta(daemon, mid) daemon.n .. mid.s);
endfig;

% Illumint
beginfig(3);
    % Illumint cross, Shadow - Illumint - Daemon / Master / Cells
    % Client-side access, Shadow or original
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.vdots0(btex $\cdots$ etex);
    boxit.lksrv(btex  lookupService etex);
    boxit.vdots1(btex $\cdots$ etex);
    boxit.other(btex other APIs etex);
    boxit.vdots2(btex $\cdots$ etex);

    % Master
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.master(btex Master etex);

    %% Illumint
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.illumint(btex Illumint etex);
    master.c = illumint.c + (0, 50);
    xpart lksrv.c = xpart illumint.c -150;
    xpart vdots1.e - xpart vdots1.w = 80;
    drawboxed(vdots0, lksrv, vdots1, other, vdots2);
    drawboxed(illumint);
    drawboxed(master);

    %% Cells, h-boxes
    boxjoin(a.se=b.sw; a.ne=b.nw);
    boxit.c0(btex $\cdots$ etex);
    boxit.n1(btex $name_1$ etex);
    boxit.c1(btex $\cdots$ etex);
    boxit.nn(btex $name_n$ etex);
    boxit.c2(btex $\cdots$ etex);
    c1.c = illumint.c + (0, -50);
    drawboxed(c0, c1, c2, n1, nn);

    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.n11(btex $cell_{1,1}$ etex);
    boxit.n12(btex $\vdots$     etex);
    boxit.n1j(btex $cell_{1,j}$ etex);
    boxit.n14(btex $\vdots$     etex);
    n11.c = n1.c + (0, -30);
    drawboxed(n11, n12, n1j, n14);

    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.nn1(btex $cell_{n,1}$ etex);
    boxit.nn2(btex $\vdots$     etex);
    boxit.nnk(btex $cell_{n,k}$ etex);
    boxit.nn4(btex $\vdots$     etex);
    nn1.c = nn.c + (0, -30);
    drawboxed(nn1, nn2, nnk, nn4);

    drawarrow n1.s -- n11.n;
    drawarrow nn.s -- nn1.n;

    % Daemon-side access
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.regc(btex registerCell etex);
    boxit.unregc(btex unregisterCell etex);
    regc.c = illumint.c + (100, 0);
    drawboxed(regc, unregc);

    % Logic
    drawarrow other.e{dir0}..{dir0}illumint.w withcolor red;
    drawarrow illumint.n{dir60}..{dir120}master.s withcolor red;
    drawarrow lksrv.e{dir0}..{dir0}illumint.w withcolor green;
    drawarrow illumint.n{dir120}..{dir60}master.s withcolor green;
    drawarrow illumint.s{dir-120}..{dir-60}c1.n withcolor green;
    drawarrow regc.w{dir180}..{dir180}illumint.e withcolor blue;
    drawarrow unregc.w{dir180}..{dir180}illumint.e withcolor blue;
    drawarrow illumint.s{dir-60}..{dir-120}c1.n withcolor blue;
    % Labels
    label.top(btex Client side API calls etex, vdots0.n);
endfig;

% Daemon and Middleman
beginfig(5);
    % Components
    %interim defaultdx := 10;
    boxit.mid(btex Middleman etex);
    boxit.daemon(btex Daemon etex);
    boxit.srv(btex ROS Service etex);

    boxit.p30k(btex Port 30000 etex);
    boxit.pat(btex Service Port etex);

    boxit.docker(btex Docker etex);
    boxit.illumint(btex Illumint etex);

    daemon.c = origin;
    srv.c = daemon.c + (120, 0);
    p30k.nw = daemon.sw + (0, -30);

    mid.c = daemon.c + (-100, 0);
    illumint.c = daemon.c + (0, 30);
    xpart docker.c = xpart mid.c;
    ypart docker.c = ypart p30k.c;
    ypart pat.c = ypart p30k.c;
    xpart pat.nw = xpart srv.nw;
    pair tsw, tnw, tne, tse;
    tsw := p30k.sw + (-20, -20);
    tnw := daemon.nw + (-20, 20);
    tne := srv.ne + (20, 20);
    tse := tne + (0, -(ypart tnw - ypart tsw));
    drawboxed(pat, p30k, srv, daemon, mid, docker, illumint);
    label.lft("bind", cuta(srv, pat) srv.s--pat.n);
    label.top("map to", cuta(pat, p30k) pat.w--p30k.e);
    % Logic -- reg
    label.top("(a)", dcutac(srv, daemon, srv.w--daemon.e, red));
    label.top("(b)", dcutac(daemon, mid, daemon.w--mid.e, red));
    label.rt("(c)", dcutac(docker, mid, docker.n--mid.s, red));
    label.rt("(d)", cutac(daemon, illumint, daemon.n--illumint.s, red));
    drawarrow daemon.w--mid.e withcolor red;
    
endfig;

% Shadow - private & remote
beginfig(7);
    boxit.shadow(btex Shadow etex);
    boxit.illumint(btex Illumint etex);
    boxit.master(btex Local Master etex);

    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.lksrv(btex  lookupService etex);
    boxit.regsrv(btex (un)register* etex);
    boxit.vdots1(btex $\cdots$ etex);
    boxit.otrclt(btex other APIs etex);
    boxit.vdots2(btex $\cdots$ etex);

    shadow.c = origin;
    master.c = shadow.c + (0, 50);
    illumint.c = shadow.c + (100, 0);
    xpart vdots2.c = xpart shadow.c - 120;
    xpart vdots1.e - xpart vdots1.w = 80;
    drawboxed(vdots1, lksrv, otrclt, vdots2, regsrv);
    drawboxed(shadow, illumint, master);
    label.top(btex API calls etex, lksrv.n);

    label.top("(a)", cutac(lksrv,  shadow, lksrv.e{dir0}..{dir0}shadow.w, red));
    label.lft("(b)", cutac(shadow, master, shadow.n{dir120}..{dir60}master.s, red));
    label.top("(c)", cutac(shadow, illumint, shadow.e{dir60}..{dir-60}illumint.w, red));
    label.top("(d)", cutac(regsrv, shadow, regsrv.e{dir0}..{dir0}shadow.w, green));
    label.rt("(e)",  cutac(shadow, master, shadow.n{dir60}..{dir120}master.s, green));
    label("(f)", cutac(shadow, illumint, shadow.e--illumint.w, green));
    label.top("(g)", cutac(otrclt, shadow, otrclt.e{dir0}..{dir0}shadow.w, blue));
    label.bot("(h)", cutac(shadow, illumint, shadow.e{dir-60}..{dir60}illumint.w, blue));
endfig;

end
