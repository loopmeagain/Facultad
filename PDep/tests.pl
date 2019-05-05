:- use_module(tp).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tests - para correrlos:
%%% run_tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- begin_tests(spoiler_alert).

    % Test Entrega 1 - Punto B - Es spoiler
    test(esSpoilerMuerteEmperorEnStarWars, nondet) :-
        esSpoiler(starWars, muerte(emperor)).

    test(esSpoilerMuertePedroEnStarWars, nondet) :-
        not(esSpoiler(starWars, muerte(pedro))).

    test(esSpoilerParentescoAnakinReyEnStarWars, nondet) :-
        esSpoiler(starWars, relacion(parentesco, anakin, rey)).

    test(esSpoilerParentescoAnakinLavezziEnStarWars, nondet) :-
        not(esSpoiler(starWars, relacion(parentesco, anakin, lavezzi))).

    % Test Entrega 1 - Punto C - Le spoileo
    test(leSpoileoGastonAMaiuGoT, nondet) :-
        leSpoileo(gaston, maiu, got).

    test(leSpoileoNicoAMaiuStarWars, nondet) :-
        leSpoileo(nico, maiu, starWars).

    % Test Entrega 1 - Punto D - Televidente responsable
    test(nicoNoEsResponsable, nondet):-
        not(televidenteResponsable(nico)).

    test(gastonNoEsResponsable, nondet):-
        not(televidenteResponsable(gaston)).

    test(ayeSoloEsUnaTroll, nondet):-
        televidenteResponsable(aye).

    test(televidenteResponsableEsInversible, set(Televidente == [juan, maiu, aye])):-
        televidenteResponsable(Televidente).

    % Test Entrega 1 - Punto E - Viene zafando
    test(maiuNoVieneZafando, nondet):-
        not(vieneZafando(maiu, _)).
    test(juanVieneZafando, set(Serie == [himym, got, hoc])):-
        vieneZafando(juan, Serie).
    test(soloNicoVieneZafandoConStarWars, set(Persona == [nico])):-
        vieneZafando(Persona, starWars).

    % Test Entrega 2

    % Punto A - malaGente
    test(gastonSpoileoUnaSerieQueNoMira, nondet):-
        malaGente(gaston).
    test(nicoLeSpoileoATodosLosQueLeHablo, nondet):-
        malaGente(nico).
    test(pedroNoLlegaASerMalaGente, nondet):-
        not(malaGente(pedro)).

    % Punto B - fullSpoil
    test(fullSpoil, set(Quienes = [gaston, aye, juan, maiu, pedro])):-
        fullSpoil(nico, Quienes).

    test(fullSpoil2, set(Quienes = [aye, juan, maiu])):-
        fullSpoil(gaston, Quienes).

    test(fullSpoil3, set(Quienes = [])):-
        fullSpoil(maiu, Quienes).

    % Punto C1 - Plot twist
    test(esUnSpoilerBodaYFuegoParaGOT, nondet):-
        esSpoiler(got, plotTwist([boda, fuego])).

    test(noEsUnSpoilerBodaYSuenioParaGOT, nondet):-
        not(esSpoiler(got, plotTwist([boda, suenio]))).

    test(esUnSpoilerComaYSinPiernasParaSuperCampeones, nondet):-
        esSpoiler(superCampeones, plotTwist([coma, sinPiernas])).

    test(nicoLeSpoileoAPedroUnPlotTwistDeGOT, nondet):-
        leSpoileo(nico, pedro, got).

    test(ayeTrolleoAJuanConUnPlotTwistDeHIMYM, nondet):-
        not(leSpoileo(aye, juan, himym)).

    % Punto C2 - esFuerte
    test(fuerte1, nondet):-
        fuerte(futurama, muerte(seymourDiera)).

    test(fuerte2, nondet):-
        fuerte(starWars, muerte(emperor)).

    test(fuerte3, nondet):-
        fuerte(starWars, relacion(parentesco, anakin, rey)).

    test(fuerte4, nondet):-
        fuerte(starWars, relacion(parentesco, vader, luke)).

    test(fuerte5, nondet):-
        fuerte(himym, relacion(amorosa, ted, robin)).

    test(fuerte6, nondet):-
        fuerte(himym, relacion(amorosa, swarley, robin)).

    test(fuerte7, nondet):-
        fuerte(got, plotTwist([fuego, boda])).

    test(fuerte8, nondet):-
        not(fuerte(got, plotTwist([suenio]))).

    test(fuerte9, nondet):-
        not(fuerte(drHouse, plotTwist([coma, pastillas]))).

    test(fuerte10, nondet):-
        not(fuerte(superCampeones, plotTwist([suenio, coma, sinPiernas]))).

    % Punto D - popularidad
    test(starWarsEsPopular, nondet):-
        popular(starWars).

    test(hocEsPopular, nondet):-
        popular(hoc).

    test(gotEsPopular, nondet):-
        popular(got).

    test(himymNoEsPopular, nondet):-
        not(popular(himym)).

    test(pedroNoVieneZafandoConGOT, nondet):-
        not(vieneZafando(pedro, got)).
:- end_tests(spoiler_alert).