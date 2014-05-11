
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

%start init

%left WORD
%left CALLE VIA PASEO PLAZA

%% /* language grammar */

init
    : letter
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

letter
	:dest SEPNL dir EOF
		{$$ = $1 + '\\n' + $3 }
	;
	
dest
    :words
		{$$ = 'DESTINATARIO: ' + $1 }
    ;
	
words
	: WORD words
		{$$ = $1 + ' ' + $2}
	| /* empty */
		{$$ = ''}
	;
	
dir
	: dirstreet
		{$$ = 'DIRECCION: ' + '\\t\\n' + $1}
	;
	
dirstreet
	: CALLE WORD words
		{$$ = 'CALLE ' + $2 + ' ' + $3}
	| VIA WORD words
		{$$ = 'VIA ' + $2 + ' ' + $3}
	| PASEO WORD words
		{$$ = 'PASEO ' + $2 + ' ' + $3}
	| PLAZA WORD words
		{$$ = 'PLAZA ' + $2 + ' ' + $3}
	;

