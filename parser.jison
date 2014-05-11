
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   				/* skip whitespace */
[0-9]{5}\b			 					return 'CP'
<<EOF>>               					return 'EOF'
[;]										return 'SEPNL'
[,]										return 'SEPDIR'

'Calle'|'calle'|'C/'|'c/'		    	return 'CALLE'
'Vía'|'vía'			  					return 'VIA'
'Paseo'|'paseo'		  					return 'PASEO'
'Plaza'|'plaza'|'Plazoleta'|'plazoleta'	return 'PLAZA'

[A-Z][a-z]+\b		  					return 'WORD'

.                     					return 'INVALID'

/lex

%start letter

%left WORD
%left CALLE VIA PASEO PLAZA

%% /* language grammar */

letter
    : dest SEPNL dir EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

dest
    :words
		{$$ = 'DESTINATARIO: ' + $1 }
    ;
	
words
	: WORD words
		{$$ = $1 + ' ' + $2}
	| /* empty */
		{$$ = ' '}
	;
	
dir
	: dirstreet
		{$$ = '\n DIRECCION: ' + $1}
	;
	
dirstreet
	: CALLE words
		{$$ = 'CALLE ' + $2}
	| VIA words
		{$$ = 'VIA ' + $2}
	| PASEO words
		{$$ = 'PASEO ' + $2}
	| PLAZA words
		{$$ = 'PLAZA ' + $2}
	;

