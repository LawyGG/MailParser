
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   				/* skip whitespace */
[0-9]{5}\b			 					return 'CP'
<<EOF>>               					return 'EOF'

[;]										return 'SEPNL'
[,]										return 'SEPDIR'

'Calle'|'calle'|'C/'|'c/'	   								return 'CALLE'
'Vía'|'vía'			  										return 'VIA'
'Paseo'|'paseo'		  										return 'PASEO'
'Plaza'|'plaza'|'Plazoleta'|'plazoleta'						return 'PLAZA'

'Edf.'|'Edificio'|'edicifio'|'edf.'							return 'EDF'
'n.'|'nº'|'número'|'Número'|'N.'|'Nº'						return 'NUM'
'Portal'|'portal'|'Bloque'|'bloque'							return 'PORTAL'
'Piso'|'piso'|'Planta'|'planta'								return 'PISO'
'Puerta'|'puerta'											return 'PUERTA'
'Izquierda'|'Derecha'|'izq'|'dcha'|'izquierda'|'derecha'	return 'PUERTA_W'

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
		{$$ = $1 + "\n\n" + $3 + "\n\n" + $5 + "\n\n"+ $7;}
    | dest SEPNL dir SEPNL cp EOF
		{$$ = $1 + "\n\n" + $3 + "\n\n" + $5;}
	;
	
dest
    :words
		{$$ = 'DESTINATARIO: ' + $1;}
    ;
	
words
	: WORD words
		{$$ = $1 + ' ' + $2;}
	| /* empty */
		{$$ = ''}
	;
	
dir
	: dirstreet SEPDIR dirid dirop
		{$$ = 'DIRECCION: ' + "\n\t" + $1 + "\n\t" + $3 + $4;}
	;
	
/*estado para controlar las opcionnales del dir*/
dirop 
		: SEPDIR block
			{$$ = "\n\t" + $2;}
		| SEPDIR floorgen
			{$$ = "\n\t" + $2;}
		| SEPDIR block SEPDIR floorgen
			{$$ = "\n\t" + $2 + "\n\t" + $4;}
		| /* empty */
			{$$ = '';}
	;
	
dirstreet
	: CALLE WORD words
		{$$ = 'CALLE ' + $2 + ' ' + $3;}
	| VIA WORD words
		{$$ = 'VIA ' + $2 + ' ' + $3;}
	| PASEO WORD words
		{$$ = 'PASEO ' + $2 + ' ' + $3;}
	| PLAZA WORD words
		{$$ = 'PLAZA ' + $2 + ' ' + $3;}
	;

dirid: EDF WORD words
		{$$ = 'EDIFICIO ' + $2;}
	| EDF LETTER
		{$$ = 'EDIFICIO ' + $2;}
	| num
		{$$ = $1;}
	| num EDF WORD words
		{$$ = $1 + "\n\t" + 'EDIFICIO ' + + $3 + $4;}
	| num EDF LETTER
		{$$ = $1 + "\n\t" + 'EDIFICIO ' + $3;}
	;
	
	
num : NUM NUMBER
		{$$ = 'NUMERO: ' + $2}
	| NUM NUMBER LETTER
		{$$ = 'NUMERO: ' + $2 + $3}
	;
	
block: PORTAL LETTER
		{$$ = 'PORTAL ' + $2;}
	| PORTAL NUMBER
		{$$ = 'PORTAL ' + $2;}
	;
	
floorgen: floor SEPDIR puerta
			{$$ = $1 + ' ' + "\n\t" + $3;}
		| floor
			{$$ = $1;}
	;
	
floor: PISO NUMBER
		{$$ = 'PISO: ' + $2;}
	;
	
puerta: PUERTA LETTER
		{$$ = 'PUERTA: ' + $2;}
	| PUERTA NUMBER
		{$$ = 'PUERTA: ' + $2;}
	| PUERTA PUERTA_W
		{$$ = 'PUERTA: ' + $2;}
	;

locat: WORD words
        {$$ = 'OPCIONAL: ' + $1 + ' ' + $2;}
    ;

cp: CP WORD words SEPDIR WORD words
        {$$ = 'CP: ' + $1 + "\n" + 'LOCALIDAD: ' + $2 + ' ' + $3 + "\n" + 'PROVINCIA: ' + $5 + ' ' + $6;}
    ;