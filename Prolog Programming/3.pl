%%----- Reading lines from text file        -----%%
read_in(Lines) :-
    open('input.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    write(Lines), nl.
%%----- check if at the end of input stream        -----%%
read_file(Stream,[]) :-
    at_end_of_stream(Stream).
%%----- Change integer codes extracted from the input text to characters -----%%
read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    get_code(Stream,Y),
    char_code(X,Y),
    read_file(Stream,L).

%%----- Predicate for finding number of duplicate characters        -----%%
%%----- Base case        -----%%
dup([],[]).
%%----- If multiple duplicates are found        -----%%
dup([X,X,X|S1], Y) :- dup([X,X|S1], [[U,X]|Z]), Y=[[T,X]|Z], T is U+1.
dup([X,X|S1], Y) :- dup(S1,U), Y=[[2,X]|U].
%%----- Single character case       -----%%
dup([X|S1], Y) :- dup(S1,U), Y=[X|U]. 

%%----- Print list to Stream Str-----%%
printl(Str,[]).
printl(Str,[X|[]]) :- write(Str, X).
printl(Str,[X|S]) :- write(Str, X), write(Str, ", "), printl(Str,S).

%%----- read from the file, find characters and their frequency,
%%----- stored in list Y, open output file, and print the list in the output stream
%%----- close the opened file.        -----%%
dupw() :- read_in(S), dup(S,Y), open('output.txt', write, Str), printl(Str,Y), nl(Str), close(Str).
