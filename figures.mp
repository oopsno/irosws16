input boxes

% Goblin
beginfig(1);

endfig;

% Illumint
beginfig(3);
    % Illumint cross, Shadow - Illumint - Daemon / Master / Cells
 
    %interim defaultdx:=20bp;
    %interim defaultdy:=20bp;

    % Client-side access, Shadow or original
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.vdots1(btex $\cdots$ etex);
    boxit.lksrv(btex  lookupService etex);
    boxit.otrclt(btex other APIs etex);
    boxit.vdots2(btex $\cdots$ etex);
    boxit.regsrv(btex registerService etex);
    boxit.unregsrv(btex unregisterService etex);

    % Master
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.master(btex Master etex);

    %% Illumint
    boxjoin(a.sw=b.nw; a.se=b.ne);
    boxit.illumint(btex Illumint etex);
    master.c = illumint.c + (0, 50);
    regsrv.c = illumint.c + (-100, 0);
    drawboxed(vdots1, lksrv, regsrv, unregsrv, vdots2);
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
    drawarrow regsrv.e -- illumint.w withcolor red;
    drawarrow regc.w .. illumint.e withcolor blue;
    drawarrow unregc.w .. illumint.e withcolor blue;
    drawarrow illumint.s .. c1.n withcolor blue;
    drawarrow otrclt.w -- illumint.w withcolor red;
    drawarrow illumint.n{right}..{curl0}master.s cutafter bpath master withcolor red;
    drawarrow lksrv.n -- illumint.w --master.s -- c1.n withcolor green;
endfig;

% Daemon
beginfig(5);
 draw fullcircle scaled 3cm withpen pencircle scaled 1cm;
endfig;

% Shadow
beginfig(7);
 draw fullcircle scaled 3cm withpen pencircle scaled 1cm;
endfig;

end
