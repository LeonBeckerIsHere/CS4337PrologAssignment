%File: lab160730.pl
%Author: Leon Becker
%E-Mail: lab160730@utdallas.edu
%Class: CS4337.503

%Signature: oddMultOf3(Integer)/1
%Returns true if Integer is an odd multiple of 3, false otherwise 

	%Check if term I is an int
	oddMultOf3(I) :-
		\+ integer(I),
		!,
		print("ERROR, The given paramter is not an integer"),
		fail.
		
	%If x mod 3 and x mod 2 means it is an odd mult of 3
	oddMultOf3(X) :- 
		0 is mod(X,3), 
		1 is mod(X,2).


%Signature: list_prod(List,Number)/2
%Returns the product of the elements in the list
	
	%Base case
	list_prod([],0).
	
	%For each element H in the list call list_prod/3
	list_prod([H|T],P) :-
		list_prod(T,H,P).
	
	%When the list is empty
	list_prod([], P, P).
	
	%Recursively multiply elements until P is the final product
	list_prod([H|T], H0, P) :-
		list_prod(T, H, P0),
		P is P0 * H0.
	
%Signature: segregate(List, Even, Odd)/3
%Segregates List into evens and odds
	
	%Base case
	segregate([],[],[]).
	
	%H of the list is even if H mod 2 is 0
	%If mod 2 evaluates to false then all other elements are filtered to odd
	
	segregate([H|T], [H|E], O):-
		0 is mod(H,2),
		!,
		segregate(T,E,O).

	segregate([H|T], E, [H|O]):-
		segregate(T,E,O).

%Signature: route(CityA, CityB, Route)/3
%Returns all possible routes from CityA to CityB
%visiting each city no more than once

	%Build the graph
	adjacent(fresno, seattle).
	adjacent(fresno, albany).
	adjacent(fresno, boston).
	adjacent(seattle, omaha).
	adjacent(seattle, dallas).
	adjacent(omaha, atlanta).
	adjacent(omaha, albany).
	adjacent(albany, seattle).
	adjacent(albany,dallas).
	adjacent(dallas, seattle).
	adjacent(dallas, albany).
	adjacent(atlanta, dallas).
	adjacent(atlanta, albany).
	adjacent(atlanta, boston).
	
	%Call helper function travel/4 to traverse the graph
	%travel/4 contains the result in Q but in reverse, so reverse Q to Route
	route(A,B,Route) :- 
		travel(A,B,[A],Q), 
		reverse(Q,Route).
	
	%if B is adjacent to A then
	%Append B to the Visited cities and
	%Output to Route 
	travel(A,B,P,[B|P]):-
		adjacent(A,B).
	
	%For each city C adjacent to A
	%Check if C is not identical to B and
	%Check if C is not a member of the Visited cities
	%Then add C to visited and make a recursive travel call with C
	travel(A,B,Visited,Route):-
		adjacent(A,C),
		C\==B,
		\+member(C,Visited),
		travel(C,B,[C|Visited],Route).
		
%Genealogy
		
	% Knowledge Base
	male(adam).
	male(bob).
	male(benson).
	male(brett).
	male(charles).
	male(chris).
	male(clay).
	female(ava).
	female(barbara).
	female(betty).
	female(colette).
	female(carrie).
	parent(adam,bob).
	parent(adam,barbara).
	parent(adam,benson).
	parent(ava,bob).
	parent(ava,barbara).
	parent(bob,clay).
	parent(barbara,colette).
	
	mother(X,Y):-
		female(X),
		parent(X,Y).
	
	father(X,Y):-
		male(X),
		parent(X,Y).
		
	child(X,Y):-
		parent(Y,X).
		
	sibling(X,Y):-
		setof((X,Y),  P^(parent(P,X),parent(P,Y),X\=Y),S),
		member((X,Y), S),
		\+ (Y@<X, member((Y,X), S)).
	
	grandparent(X,Y):-
		parent(Z,Y),
		parent(X,Z).
	
	grandmother(X,Y):-
		female(X),
		grandparent(X,Y).
		
	grandfather(X,Y):-
		male(X),
		grandparent(X,Y).
		
	grandchild(X,Y):-
		grandparent(Y,X).
	
	grandson(X,Y):-
		male(X),
		grandchild(X,Y).
		
	granddaughter(X,Y):-
		female(X),
		grandchild(X,Y).
		
	
	

	
	

 
