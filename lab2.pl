man(h1).
man(h2).
man(h3).
man(h4).
man(h5).

women(w1).
women(w2).
women(w3).
women(w4).
women(w5).

add(X,L,[X|L]).

writelist([]).
writelist([Element|RestList]):-
	write(Element), nl,
	writelist(RestList).

start1:-
    travel([left, [h1,w1,h2,w2,h3,w3, h4, w4, h5, w5],[]]).
start2:-
    travel([left, [h1,h2,h3,h4,h5, w1,w2,w3,w4,w5],[]]).
start3:-
    travel([left, [w1,w2,w3,w4,w5,h1,h2,h3,h4,h5],[]]).
start4:-
    travel([left, [w1,w2,h4,h5],[w3,w4,w5,h1,h2,h3]]).
start5:-
    travel([right, [h5],[w1,w2,w3,w4,w5,h1,h2,h3,h4]]).
start6:-
    travel([right, [w1],[w2,w3,w4,w5,h1,h2,h3,h4,h5]]).
start7:-
    travel([left, [w1],[w2,w3,w4,w5,h1,h2,h3,h4,h5]]).
start8:-
    travel([left, [w2,w3,w4,w5,h1,h2,h3,h4,h5],[w1]]).
start9:-
    travel([right, [w1,w2,w3,w4,w5,h1,h2,h3,h4,h5],[w1]]).
start10:-
    travel([right, [], [h1,w1,h2,w2,h3,w3, h4, w4, h5, w5]]).
start11:-
    travel([left, [], [h1,w1,h2,w2,h3,w3, h4, w4, h5, w5]]).

travel(StartingState):-
    travel(StartingState, []).

travel([left, [], _],_):-fail.

travel([right, [], RightPersons],PastIterations):-
	add([right,[],RightPersons], PastIterations, NewPastIterations),
	reverse(NewPastIterations, SortedPastIterations),
	writelist(SortedPastIterations).

travel(CurrentState,
       PastIterations):-
    move(CurrentState, NewState),
    add(CurrentState, PastIterations, NewPastIterations),
    travel(NewState,  NewPastIterations).

move([left, LeftPersons, RightPersons],
     [right, NewLeftPersons2, NewRightPersons]):-
    validstates([LeftPersons, RightPersons]),
    length(LeftPersons, 2),
    member(FirstPerson,  LeftPersons),
	rest(FirstPerson, LeftPersons, RestLeftPersons),
	member(SecondPerson, RestLeftPersons),
	delete(LeftPersons, FirstPerson, NewLeftPersons),
	delete(NewLeftPersons, SecondPerson, NewLeftPersons2),
	append([FirstPerson, SecondPerson], RightPersons, NewRightPersons),
	validstates([NewLeftPersons2, NewRightPersons]).

move([left, LeftPersons, RightPersons],
     [right, NewLeftPersons3, NewRightPersons]):-
    validstates([LeftPersons, RightPersons]),
	member(FirstPerson,  LeftPersons),
	rest(FirstPerson, LeftPersons, RestLeftPersons),
	member(SecondPerson, RestLeftPersons),
    rest(SecondPerson, RestLeftPersons, RestLeftPersons3),
	member(ThirdPerson, RestLeftPersons3),
	delete(LeftPersons, FirstPerson, NewLeftPersons),
	delete(NewLeftPersons, SecondPerson, NewLeftPersons2),
    delete(NewLeftPersons2, ThirdPerson, NewLeftPersons3),
	append([FirstPerson, SecondPerson, ThirdPerson], RightPersons, NewRightPersons),
	validstates([NewLeftPersons3, NewRightPersons]).

move([right, LeftPersons, RightPersons],
     [left, [RightPerson|LeftPersons], NewRightPersons]):-
	member(RightPerson, RightPersons),
    man(RightPerson),
    validstates([LeftPersons, RightPersons]),
	delete(RightPersons, RightPerson, NewRightPersons),
	validstates([[RightPerson|LeftPersons], NewRightPersons]).

rest(Element, [Element | RestOfList], RestOfList).
rest(Element, [_ | RestOfList], Result) :-
	rest(Element, RestOfList, Result).

validstates([LeftPersons, RightPersons]):-
	validstate(LeftPersons),
	validstate(RightPersons).

validstate(Persons):-
    member(X, Persons),
    man(X).

validstate(Persons):-
   length(Persons, 0).
