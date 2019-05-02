%%----- creating knowledge base about the couples married,        -----%%
marriedTo('jatin', 'payal').
marriedTo('pawan', 'sheetal').
marriedTo('lucky', 'priya').
marriedTo('amit', 'suchi').
%%----- creating knowledge base about the person X loving person Y.-----%% 
loves('payal', 'pawan').
loves('amit', 'payal').
loves('lucky', 'payal').
loves('jatin', 'priya').
loves('suchi', 'pawan').

%%----- predicate defining married, which is symmetric.            -----%%
married(X,Y) :- marriedTo(X,Y) | marriedTo(Y,X).
%%-----predicate defining on the rocks.-----%%
onrocks(X,Y) :- married(X,Y), loves(X,Z), loves(Y,U), not(Z=Y), not(U=Z).
%%-----predicate for the jealous relationship(mathematical).-----%%
jealous(X) :- loves(X,Z), (loves(Y,Z) | married(Y,Z)), not(X=Y).