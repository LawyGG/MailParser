var assert = chai.assert;

suite('Direccion', function() {
    test('Calle completa', function() {
         var result = parser.parse('Cristian; Calle Algun Lado , N. 23 Edificio A, portal B, piso 1, puerta dcha; Narnia ;38008 Santa cruz, tenerife');
         assert.equal(result, "DESTINATARIO: Cristian \n\nDIRECCION: \n\tCALLE Algun Lado \n\tNUMERO: 23\n\tEDIFICIO A\n\tPORTAL B\n\tPISO: 1 \n\tPUERTA: dcha\n\nOPCIONAL: Narnia \n\nCP: 38008\nLOCALIDAD: Santa cruz \nPROVINCIA: tenerife ");
       
    });
      
    test('Calle sin opcional', function() {
        var result = parser.parse('Cristian; Calle Algun Lado , N. 23 Edificio A,portal B, piso 1, puerta dcha;38008 Santa cruz, tenerife');
        assert.equal(result, "DESTINATARIO: Cristian \n\nDIRECCION: \n\tCALLE Algun Lado \n\tNUMERO: 23\n\tEDIFICIO A\n\tPORTAL B\n\tPISO: 1 \n\tPUERTA: dcha\n\nCP: 38008\nLOCALIDAD: Santa cruz \nPROVINCIA: tenerife ");
           
    });

});