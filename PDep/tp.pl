:- module(tp, [esSpoiler/2, leSpoileo/3,
    televidenteResponsable/1, vieneZafando/2,
    malaGente/1, fullSpoil/2, fuerte/2, popular/1]).

%% PUNTO A
%% Armar base de conocimiento aquí

% mira(Persona, Serie)
mira(juan, himym).
mira(juan, futurama).
mira(juan, got).
mira(maiu, starWars).
mira(maiu, onePiece).
mira(maiu, got).
mira(nico, starWars).
mira(nico, got).
mira(nico, futurama).
mira(gaston, hoc).
mira(pedro, got).

% quiereVer(Persona, Serie)
quiereVer(juan, hoc).
quiereVer(aye, got).
quiereVer(gaston, himym).

% interesadoEn(Persona, Serie)
interesadoEn(Persona, Serie):-
    mira(Persona, Serie).
interesadoEn(Persona, Serie):-
    quiereVer(Persona, Serie).

% episodiosPorTemporada(Serie, Temporada, CantidadDeEpisodios)
episodiosPorTemporada(got, 2, 10).
episodiosPorTemporada(got, 3, 12).
episodiosPorTemporada(himym, 1, 23).
episodiosPorTemporada(drHouse, 8, 16).

% amigo(Amigo, Persona)
amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

%% PUNTO B

% paso(Serie, Temporada, Episodio, LoQuePaso)
paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).
paso(got, 2, 10, plotTwist([suenio, sinPiernas])).
paso(got, 3, 12, plotTwist([fuego, boda])).
paso(superCampeones, 9, 9, plotTwist([suenio, coma, sinPiernas])).
paso(drHouse, 8, 7, plotTwist([coma, pastillas])).

% leDijo(ElQueDijoAlgo, AQuien, Serie, LoQuePaso)
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(nico, juan, futurama, muerte(seymourDiera)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(pedro, aye, got, relacion(amistad, tyrion, dragon)).
leDijo(pedro, nico, got, relacion(parentesco, tyrion, dragon)).
leDijo(nico, pedro, got, plotTwist([boda, fuego])).
leDijo(nico, pedro, got, plotTwist([boda, suenio])).
leDijo(aye, juan, himym, plotTwist([boda, fuego])).

% esSpoiler(Serie, AlgoQueTalVezPaso)
esSpoiler(Serie,AlgoQueTalVezPaso):-
    paso(Serie, _, _, AlgoQueTalVezPaso).
esSpoiler(Serie, plotTwist(Lista)):-
    paso(Serie, _, _, plotTwist(ListaPaso)),
    forall(member(Hecho, Lista), member(Hecho, ListaPaso)).

%% PUNTO C

% leSpoileo(Spoileador, Spoileado, Serie)
leSpoileo(Spoileador, Spoileado, Serie):-
    leDijo(Spoileador, Spoileado, Serie, PosibleSpoiler),
    riesgoDeSpoiler(Spoileado, Serie, PosibleSpoiler).

% riesgoDeSpoiler(Persona, Serie, Spoiler)
riesgoDeSpoiler(Persona, Serie, Spoiler):-
    interesadoEn(Persona, Serie),
    esSpoiler(Serie, Spoiler).

%% PUNTO D

% televidenteResponsable(Persona)
televidenteResponsable(Persona):-
    cinefilo(Persona),
    not(leSpoileo(Persona,_,_)).

% cinefilo(Persona)
cinefilo(Persona):-
    interesadoEn(Persona,_).
cinefilo(Persona):-
    leDijo(_,Persona,_,_).
cinefilo(Persona):-
    leDijo(Persona,_,_,_).
    
%% PUNTO E

% vieneZafando(Persona, Serie)
vieneZafando(Persona, Serie):-
    interesadoEn(Persona, Serie),
    serieInteresante(Serie),
    not(leSpoileo(_, Persona, Serie)).
    
% serieInteresante(Serie)
serieInteresante(Serie):-
    popular(Serie).
serieInteresante(Serie):-
    serieFuerte(Serie).

% serieFuerte(Serie)
serieFuerte(Serie):-
    temporadasConocidas(Serie, _),
    forall(temporadasConocidas(Serie, Temporada),
    sucesoFuerte(Serie, Temporada)).

% sucesoFuerte(Serie, Temporada)
sucesoFuerte(Serie, Temporada):-
    paso(Serie, Temporada, _, Suceso),
	fuerte(Serie, Suceso).

% temporadasConocidas(Serie, Temporada)
temporadasConocidas(Serie, Temporada):-
    episodiosPorTemporada(Serie, Temporada, _).


%% ENTREGA 2

%% PUNTO A

% malaGente(Persona)
malaGente(Persona):-
    cinefilo(Persona),
    forall(leDijo(Persona, OtraPersona, _, _),
    leSpoileo(Persona, OtraPersona, _)).
malaGente(Persona):-
    leSpoileo(Persona, _, Serie),
    not(mira(Persona, Serie)).

%% PUNTO B

% fullSpoil(Spoilero, Spoileado)
fullSpoil(Spoilero, Spoileado):-
    leSpoileo(Spoilero, Spoileado, _).
fullSpoil(Spoilero, Spoileado):-
    leSpoileo(Spoilero, AmigoDeSpoileado, _),
    amigoDeAmigo(AmigoDeSpoileado, Spoileado),
    Spoilero \= Spoileado.

amigoDeAmigo(Amigo, Persona):-
    amigo(Amigo, Persona).
amigoDeAmigo(AmigoDeAmigo, Persona):-
    amigo(Amigo, Persona),
    amigoDeAmigo(AmigoDeAmigo, Amigo).

%% PUNTO C

% fuerte(Serie, Suceso)
fuerte(_, muerte(_)).
fuerte(_, relacion(parentesco, _, _)).
fuerte(_, relacion(amorosa, _, _)).
fuerte(Serie, PlotTwist):-
    episodiosPorTemporada(Serie, Temporada, EpisodioFinal),
	paso(Serie, Temporada, EpisodioFinal, PlotTwist),
	not(esCliche(PlotTwist)).

esCliche(plotTwist(PalabrasClave)):-
    forall(member(PalabraClave, PalabrasClave), palabraCliche(PalabraClave)).

palabraCliche(Palabra):-
    paso(Serie1, _, _, plotTwist(PlotTwist1)),
	paso(Serie2, _, _, plotTwist(PlotTwist2)),
	member(Palabra, PlotTwist1),
	member(Palabra, PlotTwist2),
	Serie1 \= Serie2.

%% PUNTO D

% popular(Serie)
popular(hoc).

popular(Serie):-
    esSerie(Serie),
    popularidad(Serie, Popularidad),
	popularidad(starWars, PopularidadStarWars),
	Popularidad >= PopularidadStarWars.

% popularidad(Serie, Popularidad)
popularidad(Serie, Popularidad):-
    findall(Televidente, mira(Televidente, Serie), Televidentes),
	length(Televidentes, CantidadDeTelevidentes),
	findall(Conversador, leDijo(Conversador, _, Serie, _), Conversadores),
	length(Conversadores, CantidadDeConversadores),
	Popularidad is CantidadDeTelevidentes * CantidadDeConversadores.

% esSerie(Serie)
esSerie(Serie):-
    mira(_, Serie).
esSerie(Serie):-
    temporadasConocidas(Serie, _).