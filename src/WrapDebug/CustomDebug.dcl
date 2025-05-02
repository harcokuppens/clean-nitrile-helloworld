definition module CustomDebug;

(<<-) infixl 0 :: .a !.b -> .a;

(->>) infixl 0 :: !.a .b -> .a;


<<->> :: !.a -> .a;

print_graph :: !.a -> Bool;

(->>-) infixl 0 :: !.a .b -> .a;