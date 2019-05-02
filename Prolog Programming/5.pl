%%-----creating knowledge base about the bus routes.-----%%
bus(1, kameng, hospital, 8, 8.75, 2, 3).
bus(2, hospital, subansiri, 8, 8.5, 5, 1).
bus(2, subansiri, panbazar, 8.5, 9.75, 15, 20).
bus(4, panbazar, kameng, 8, 9, 10, 20).
bus(5, hospital ,panbazar, 13, 15, 25, 11).
bus(3, kameng, subansiri, 14, 17, 1, 50).


%%-----checking for cycles in bus routes found.-----%%
check([], X).
check([[T, Y]|L], X):- not(T=X), check(L, X).

%%-----finding the bus routes based on distance.-----%%
rout_dist([], L, 0, 0, 0, Et, P, P).
rout_dist([[P1,I1]|R], L, T, C, D, CurTime, P1, P2):-
	bus(I1, P1, X, St, Et, F, Dist),
 	check(L, X),
 	opt_dist(R, [[P1,I1]|L], T1, C1, D1, Et, X, P2),
 	C is C1+F,
	D is D1+Dist,
	((St>=CurTime, T is T1+(Et-CurTime)) |
	(St<CurTime, T is T1+(24+Et-CurTime))).

%%-----optimising the bus routes based on distance.-----%%
opt_dist([], L, 0, 0, 0, Et, P, P).
opt_dist(R, L, T, C, D, CurTime, P1, P2):-not(P1=P2),
	rout_dist(R, L, T, C, D, CurTime, P1, P2),
	forall(
		rout_dist(R1,L,T1,C1,D1,CurTime,P1,P2),
		(D=<D1)
		).

%%-----finding the bus routes based on time taken for the journey.-----%%
rout_time([], L, 0, 0, 0, Et, P, P).
rout_time([[P1,I1]|R], L, T, C, D, CurTime, P1, P2):-
	bus(I1, P1, X, St, Et, F, Dist),
 	check(L, X),
 	opt_time(R, [[P1,I1]|L], T1, C1, D1, Et, X, P2),
 	C is C1+F,
	D is D1+Dist,
	((St>=CurTime, T is T1+(Et-CurTime)) |
	(St<CurTime, T is T1+(24+Et-CurTime))).

%%-----optimising the bus routes based on time.-----%%
opt_time([], L, 0, 0, 0, Et, P, P).
opt_time(R, L, T, C, D, CurTime, P1, P2):-not(P1=P2),
	rout_time(R, L, T, C, D, CurTime, P1, P2),
	forall(
		rout_time(R1,L,T1,C1,D1,CurTime,P1,P2),
		(T=<T1)
		).

%%-----finding the bus routes based on cost-incurred during the journey.-----%%
rout_fare([], L, 0, 0, 0, Et, P, P).
rout_fare([[P1,I1]|R], L, T, C, D, CurTime, P1, P2):-
	bus(I1, P1, X, St, Et, F, Dist),
 	check(L, X),
 	opt_fare(R, [[P1,I1]|L], T1, C1, D1, Et, X, P2),
 	C is C1+F,
	D is D1+Dist,
	((St>=CurTime, T is T1+(Et-CurTime)) |
	(St<CurTime, T is T1+(24+Et-CurTime))).

%%-----optimising the bus routes based on cost.-----%%
opt_fare([], L, 0, 0, 0, Et, P, P).
opt_fare(R, L, T, C, D, CurTime, P1, P2):-not(P1=P2),
	rout_fare(R, L, T, C, D, CurTime, P1, P2),
	forall(
		rout_fare(R1,L,T1,C1,D1,CurTime,P1,P2),
		(C=<C1)
		).

print_r([X|[]]):-write(X), !.
print_r([X|Z]):- write(X), write("-->"), print_r(Z).

print_t(T):- H is floor(T), M is integer(60*(T - H)), write(H), write(" hrs "), ((M>0, write(M), write(" mins"))|M=0).

route(X, Y, Curr_time):-
	opt_fare(R1, [], T1, C1, D1, Curr_time, X, Y),
	write("Minimum cash needed on route: "), print_r(R1),
	write("\n  Time     : "), print_t(T1),
	write("\n  Money    : Rs"), write(C1),
	write("\n  Distance : "), write(D1),
	opt_dist(R2, [], T2, C2, D2, Curr_time, X, Y),
	write("\n\nMinimum distance needed on route: "), print_r(R2),
	write("\n  Time     : "), print_t(T2),
	write("\n  Money    : Rs"), write(C2),
	write("\n  Distance : "), write(D2),
	opt_time(R3, [], T3, C3, D3, Curr_time, X, Y), 
	write("\n\nMinimum time needed on route: "), print_r(R3),
	write("\n  Time     : "), print_t(T3),
	write("\n  Money    : Rs"), write(C3),
	write("\n  Distance : "), write(D3).
