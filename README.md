MailParser
==========

This repo will developt a parser for ordinary mail.
Directions will be expressed in Spanish format (see details below).

##Spanish Direction Format

Optional fields indicates with *

cp format: /^\d{5}$/

* LETTER -> PERSON_NAME DIR LOCATION* CP

* PERSONNAME -> NAME SURNAMES

* DIR -> DIRTYPE street_name DIR_NUMBER EDF_NAME B_NAME* FLOOR
* EDF_NAME -> ('Edf.'|'Edificio')* b_name
* DIR_NUMBER -> ('nº'|'Número')* number | 's/n'
* B_NAME -> 'Portal' number|letter
* FLOOR -> number 'º' ('Dcha|Izq|Derecha|Izquierda|letter')*
* LOCATION -> town...
* CP -> cp localidad, provincia

* DIRTYPE

##Author

Laura A. Gomez Gonzalez
