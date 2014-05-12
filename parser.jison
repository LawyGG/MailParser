
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   				/* skip whitespace */
[0-9]{5}\b			 					return 'CP'
<<EOF>>               					return 'EOF'

[;]										return 'SEPNL'
[,]										return 'SEPDIR'

'Calle'|'calle'|'C/'|'c/'		    						return 'CALLE'
'Vía'|'vía'			  										return 'VIA'
'Paseo'|'paseo'		  										return 'PASEO'
'Plaza'|'plaza'|'Plazoleta'|'plazoleta'						return 'PLAZA'

'Edf.'|'Edificio'|'edicifio'|'edf.'							return 'EDF'
'n.'|'nº'|'número'|'Número'|'N.'|'Nº'						return 'NUM'
'Portal'|'portal'|'Bloque'|'bloque'							return 'PORTAL'

[A-Z]\b		  							return 'LETTER'
[A-Z][a-z]+\b		  					return 'WORD'
[0-9]+\b								return 'NUMBER'

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
	: dest SEPNL dir SEPNL locat SEPNL cp EOF
		{$$ = $1 + '\n' + $3 + '\n' + $5 + $7}
    | dest SEPNL dir SEPNL cp EOF
		{$$ = $1 + '\n' + $3 + $5}
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
	: dirstreet SEPDIR dirid SEPDIR block
		{$$ = 'DIRECCION: ' + '\t\n' + $1 + '\t\n' + $3 + '\t\n' + $5}
    | dirstreet SEPDIR dirid
		{$$ = 'DIRECCION: ' + '\t\n' + $1 + '\t\n' + $3}
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

dirid: EDF WORD words
		{$$ = 'EDIFICIO ' + $2}
	| NUM NUMBER
		{$$ = 'NUMERO ' + $2}
	| NUM NUMBER EDF WORD words
		{$$ = 'NUMERO ' + $2 + '\t\n' + 'EDIFICIO ' + $4}
	;
	
block: PORTAL LETTER
		{$$ = 'PORTAL ' + $2}
	| PORTAL NUMBER
		{$$ = 'PORTAL ' + $2}
	;

locat: WORD words
        {$$ = 'CIUDAD: ' + $1 + ' ' + $2}
    ;

cp: CP WORD words SEPDIR WORD words
        {$$ = '\nCP: ' + $1 + '\nLOCALIDAD: ' + $2 + ' ' + $3 + '\nPROVINCIA: ' + $4 + ' ' + $5}
    ;