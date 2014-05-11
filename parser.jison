
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   				/* skip whitespace */
[0-9]{5}\b			 				return 'CP'
[A-Z][a-z]+\b		  				return 'WORD'
<<EOF>>               				return 'EOF'
;									return 'SEP'

'Calle'|'calle'|'C/'|'c/'		    return CALLE
'Vía'|'vía'			  				return VIA
'Paseo'|'paseo'		  				return PASEO
'Plaza'|'plaza|Plazoleta|plazoleta'	return PLAZA


.                     				return 'INVALID'

/lex

/* CALLE, VIA, PLAZA, PASEO area WORDS so */

%left WORD
%right CALLE VIA PASEO PLAZA
%left SEP

%start letter

%% /* language grammar */

letter
    : dest SEP dest EOF
        { typeof console !== 'undefined' ? console.log($1) : print($1);
          return $1; }
    ;

dest
    : WORD surnames
		{$$ = 'DESTINATARIO: ' + $1 + ' ' + $2}
    ;
	
surnames
	: WORD surnames
		{$$ = $1 + ' ' + $2}
	| /* empty */
		{$$ = ''}
	;
	
dir
	: dirtype surnames
		{$$ = 'DIRECCION: ' + $1 + ' ' + $2}
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

