%%----- Increasing Sub-sequence.-----%%
%%----- base case: empty subsequence has an empty increasing subsequence.-----%%
inc_subseq([],[],A).

%%-----Skip first number of subsequence to get an increasing subsequence.-----%%
inc_subseq([_|S1], S2, Val):- inc_subseq(S1, S2, Val).

%%----- Take first number of subsequence and check if greater than whatever       -----%%
%%----- number you already have in your sequence to get an increasing subsequence.-----%%
inc_subseq([X|S1], [X|S2], A):- (X>A), inc_subseq(S1, S2, X).


%%-----predicate to get length of a list-----%%
get_length(0,[]).
get_length(L, [X|S]) :- get_length(K, S), L is K+1.


%%-----predicate that compares all the subsequences to get the longest one.-----%%
lis(S1) :- inc_subseq(S1,X,0), get_length(Z,X), forall((inc_subseq(S1,Y,0), get_length(W,Y)), Z>=W ), write(X).