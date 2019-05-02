%%-----Fibonacci sequence.-----%%
%%-----base case.-----%%
fib(X1,Y1,X2,Y2,0,1):- !.
fib(X1,Y1,X2,Y2,1,1):- !.

%%-----recursive definition.-----%%
fib(X1,Y1,X2,Y2,X3,Y3) :- var(Y3), X3>X2, X4 is X2 + 1, Y4 is Y1 + Y2, fib(X2,Y2,X4,Y4,X3,Y3).
fib(X1,Y1,X2,Y2,X3,Y3) :- var(Y3), X3=X2, Y3 is Y2.
fib(X1,Y1,X2,Y2,X3,Y3) :- var(X3), Y2<Y3, X4 is X2 + 1, Y4 is Y1 + Y2, fib(X2,Y2,X4,Y4,X3,Y3).
fib(X1,Y1,X2,Y2,X3,Y3) :- var(X3), Y3=Y2, X3 is X2.
fib(X1,Y1,X2,Y2,X3,Y3) :- var(X3), Y3<Y2, X3 is -1.

%%----- Lucas sequence. -----%%
%%----- base case.      -----%%
luc(X1,Y1,X2,Y2,0,2) :- !.
luc(X1,Y1,X2,Y2,1,1) :- !.

%%----- recursive definition.-----%%
luc(X1,Y1,X2,Y2,X3,Y3) :- var(Y3), X3>X2, X4 is X2 + 1, Y4 is Y1 + Y2, luc(X2,Y2,X4,Y4,X3,Y3).
luc(X1,Y1,X2,Y2,X3,Y3) :- var(Y3), X3=X2, Y3 is Y2.
luc(X1,Y1,X2,Y2,X3,Y3) :- var(X3), Y2<Y3, X4 is X2 + 1, Y4 is Y1 + Y2, luc(X2,Y2,X4,Y4,X3,Y3).
luc(X1,Y1,X2,Y2,X3,Y3) :- var(X3), Y3=Y2, X3 is X2.
luc(X1,Y1,X2,Y2,X3,Y3) :- var(X3), Y3<Y2, X3 is -1.

%%----- Tribonacci sequence.-----%%
%%----- base case.-----%%
trib(X1,Y1,X2,Y2,X3,Y3,0,0) :- !.
trib(X1,Y1,X2,Y2,X3,Y3,1,1) :- !.
trib(X1,Y1,X2,Y2,X3,Y3,2,1) :- !.
%%----- recursive definition.-----%%
trib(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- var(Y4), X4>X3, X5 is X3 + 1, Y5 is Y1 + Y2 + Y3, trib(X2,Y2,X3,Y3,X5,Y5,X4,Y4).
trib(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- var(Y4), X4=X3, Y4 is Y3.
trib(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- var(X4), Y4>Y3, X5 is X3 + 1, Y5 is Y1 + Y2 + Y3, trib(X2,Y2,X3,Y3,X5,Y5,X4,Y4).
trib(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- var(X4), Y4=Y3, X4 is X3.
trib(X1,Y1,X2,Y2,X3,Y3,X4,Y4) :- var(X4), Y4<Y3, X4 is -1.



%%----- defintion that writes the complete fibbonacci sequence until index V.-----%%
fib_full(-1).
fib_full(V):- V>=0, V1 is V-1, fib_full(V1), fib(0,1,1,1,V,X1), write(X1), write(", "). 

%%----- defintion that writes the complete lucas sequence until index V.     -----%%
luc_full(-1).
luc_full(V):- V>=0, V1 is V-1, luc_full(V1), luc(0,2,1,1,V,X1), write(X1), write(", "). 

%%----- defintion that writes the complete tribbonacci sequence until index V.-----%%
trib_full(-1).
trib_full(V):- V>=0, V1 is V-1, trib_full(V1), trib(0,1,1,1,2,1,V,X1), write(X1), write(", ").


%%----- predicate that writes the corresponding sequence it is asked -----%%
%%----- for (using its first argument), until index given by its    -----%%
%%----- second argument, here variable denoting it is Ind.          -----%%
sequence(lucas, Ind):- luc_full(Ind).
sequence(fibonacci, Ind):- fib_full(Ind).
sequence(tribonacci, Ind):- trib_full(Ind).

%%-----predicate that returns the Ind indexed term of the  -----%%
%%-----corresponding sequence (chosen using its first      -----%%
%%-----argument) in the variable X.					   -----%%
nterm(lucas, Ind, X) :- luc(0,2,1,1,Ind,X).
nterm(fibonacci, Ind, X) :- fib(0,1,1,1,Ind,X).
nterm(tribonacci, Ind, X) :- trib(0,1,1,1,2,1,Ind,X).