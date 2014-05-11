
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]{5}\b			  return 'CP'
[A-Z][a-z]+\b		  return 'WORD'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%start letter

%% /* language grammar */

letter
    : dest EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

dest
    : WORD surnames
    ;
	
surnames
	: WORD surnames
	| /* empty */
	;

