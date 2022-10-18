satrak_mx(NM, Fs, Ss, Mx) :-
    N-M = NM,
    get_tent_positions(Fs, Ss, N, M, Tents),
    no_touching_tents(Tents),
    init_tent_matrix(N, M, Matrix),
    add_tents_to_matrix(Matrix, Tents, Mx).

get_tent_positions([], _Directions, _N, _M, []).

get_tent_positions(Trees, Directions, N, M, [First_Tent | Other_Tents]) :-
    [First_Tree | Other_Trees] = Trees,
    [First_Direction | Other_Directions] = Directions,
    get_tent_position(First_Tree, First_Direction, N, M, First_Tent),
    get_tent_positions(Other_Trees, Other_Directions, N, M, Other_Tents).

get_tent_position(Tree, n, _N, _M, Tent) :-
    I-J = Tree,
    I2 is I - 1,
    I2 >= 1,
    Tent = I2-J.

get_tent_position(Tree, e, _N, M, Tent) :-
    I-J = Tree,
    J2 is J + 1,
    J2 =< M,
    Tent = I-J2.

get_tent_position(Tree, s, N, _M, Tent) :-
    I-J = Tree,
    I2 is I + 1,
    I2 =< N,
    Tent = I2-J.

get_tent_position(Tree, w, _N, _M, Tent) :-
    I-J = Tree,
    J2 is J - 1,
    J2 >= 1,
    Tent = I-J2.

no_touching_tents(Tents).

init_tent_matrix(0, _M, []).

init_tent_matrix(N, M, [First_Row | Other_Rows]) :-
    N > 0,
    init_matrix_row(M, First_Row),
    N1 is N - 1,
    init_tent_matrix(N1, M, Other_Rows).

init_matrix_row(0, []).

init_matrix_row(M, [0 | Other_Items]) :-
    M > 0,
    M1 is M - 1,
    init_matrix_row(M1, Other_Items).

add_tents_to_matrix(M, [], M).

add_tents_to_matrix(Matrix, Tents, Mx) :-
    [First_Tent | Other_Tents] = Tents,
    add_tent_to_matrix(Matrix, First_Tent, Updated_Matrix),
    add_tents_to_matrix(Updated_Matrix, Other_Tents, Mx).

add_tent_to_matrix([First_Row | Other_Rows], Tent, [Updated_First_Row | Other_Rows]) :-
    1-J = Tent,
    add_tent_to_row(First_Row, J, Updated_First_Row).

add_tent_to_matrix([[]], _, [[]]).

add_tent_to_matrix(Matrix, Tent, [First_Row | Updated_Other_Rows]) :-
    I-J = Tent,
    I > 1,
    I1 is I - 1,
    [First_Row | Other_Rows] = Matrix,
    add_tent_to_matrix(Other_Rows, I1-J, Updated_Other_Rows).

add_tent_to_row([_First_Item | Other_Items], 1, [1 | Other_Items]).

add_tent_to_row([], _, []).

add_tent_to_row(Row, Col, [First_Item | Updated_Other_Items]) :-
    Col > 1,
    Col1 is Col - 1,
    [First_Item | Other_Items] = Row,
    add_tent_to_row(Other_Items, Col1, Updated_Other_Items).


