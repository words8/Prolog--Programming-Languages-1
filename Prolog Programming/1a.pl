%%----- Finding if first argument to IsPref is prefix of second argument.   -----%%
%%----- base case, empty list is prefix of all strings(empty or non_empty). -----%%
isPref([],[]).
isPref([],[_|Y]).

%%----- Find if tail of first argument is still a prefix   -----%%
%%----- of tail of second argument                         -----%%
isPref([X|S1],[X|S2]) :- isPref(S1,S2).

%%-----Check if X is substring of tail of second argument. -----%%
isSubl(X,[_|S1]) :- isSubl(X,S1).

%%----- Check if tail(remaining part) of first argument is -----%% 
%%----- prefix of second argument since their heads match  -----%%
isSubl([X|S1],[X|S2]) :- isPref(S1,S2).

%%----- Change the string into a list of characters to use -----%%
%%----- above defined predicates                           -----%%
isSub(S1,S2) :- string_chars(S1,X), string_chars(S2,Y), isSubl(X,Y).