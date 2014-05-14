
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
[A-Za-z]+\b                             return 'WORD'
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
		{$$ = $1 + "\n\n" + $3 + "\n\n" + $5 + "\n\n"+ $7}
    | dest SEPNL dir SEPNL cp EOF
		{$$ = $1 + "\n\n" + $3 + "\n\n" + $5}
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
		{$$ = 'DIRECCION: ' + "\n\t" + $1 + "\n\t" + $3 + "\n\t" + $5}
    | dirstreet SEPDIR dirid
		{$$ = 'DIRECCION: ' + "\n\t" + $1 + "\n\t" + $3}
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
		{$$ = 'NUMERO ' + $2 + "\n\t" + 'EDIFICIO ' + $4}
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
        {$$ = 'CP: ' + $1 + "\n" + 'LOCALIDAD: ' + $2 + ' ' + $3 + "\n" + 'PROVINCIA: ' + $5 + ' ' + $6}
    ;