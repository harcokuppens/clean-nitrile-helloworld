implementation module CustomDebug;

import Debug;
import StdMisc;

// these examples use double arrow syntax (->>, <<- and <<->>)
(<<-) infixl 0 :: .a !.b -> .a;
(<<-) value debugValue
	=	debugBefore debugValue show value;

(->>) infixl 0 :: !.a .b -> .a;
(->>) value debugValue
	=	debugAfter debugValue show value;

<<->> :: !.a -> .a;
<<->> value
	=	debugValue show value;

// show function with default debug options ( no limits and as print terminator \n)
show =	debugShowWithOptions [];

// // show function with debug options (limit length of output and depth of nested structures)
// show
// 	=	debugShowWithOptions
// 			[DebugMaxChars 79, DebugMaxDepth 5, DebugMaxBreadth 20];


print_graph :: !.a -> Bool;
print_graph a = code {
	.d 1 0
	jsr _print_graph
	.o 0 0
	pushB TRUE
};

(->>-) infixl 0 :: !.a .b -> .a;
(->>-) value msg 
		| print_graph msg  // prints msg (on rhs of operator) to  stdout
			=  value;       // returns value (on lhs of operator, as in situation wher operator and rhs were not there)
		| otherwise      // never reached      
			= undef;      // note:  The function undef represents an undefined value, 
						//        evaluating this undefined value yields a runtime error. 
