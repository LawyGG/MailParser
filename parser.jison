
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   				/* skip whitespace */
[0-9]{5}\b			 				return 'CP'
[A-Z][a-z]+\b		  				return 'WORD'
<<EOF>>               				return 'EOF'
[;]									return 'SEPNL'
[,]									return 'SEPDIR'

'Calle'|'calle'|'C/'|'c/'		    return CALLE
'Vía'|'vía'			  				return VIA
'Paseo'|'paseo'		  				return PASEO
'Plaza'|'plaza|Plazoleta|plazoleta'	return PLAZA
.                     				return 'INVALID'

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
		{$$ = 'DESTINATARIO: ' + $1 + ' ' + $2}
    ;
	
words
	: WORD words
		{$$ = $1 + ' ' + $2}
	| /* empty */
		{$$ = ' '}
	;
	
dir
	: dirtype words
		{$$ = '\n DIRECCION: ' + $1 + ' ' + $2}
	;
	
dirtype 
	: CALLE
		{$$ = 'CALLE'}
	| VIA
		{$$ = 'VIA'}
	| PASEO
		{$$ = 'PASEO'}
	| PLAZA
		{$$ = 'PLAZA'}
	;

