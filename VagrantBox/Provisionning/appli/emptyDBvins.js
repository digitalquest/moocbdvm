
try {

    if (!window.openDatabase) {
        alert('not supported');
    } else {
        var shortName = 'bdvins';
        var version = '1.0';
        var displayName = 'Base de données vins';
        var maxSize = 65536 * 4; // in bytes
        db = window.openDatabase(shortName, version, displayName, maxSize);
        // You should have a database instance in db.
        document.getElementById('dbacces').innerHTML = 'Accès base de données OK';
    }
} catch(e) {
    // Error handling code goes here.
    if (e == 2) {
        // Version number mismatch.
        alert("Invalid database version.");
    } else {
        alert("Unknown error "+e+".");
    }
}

 db.transaction(
 	function (tx) {
		tx.executeSql(
			'DROP TABLE IF EXISTS RECOLTES',
			null,
			function (t, r) {
 		 		document.getElementById('deleterecoltes').innerHTML = 'Suppression table RECOLTES OK'; 
	 	 	},
	    	function (t, err) {
 		 		document.getElementById('deleterecoltes').innerHTML = 'Erreur suppression RECOLTES ' + err.message; 
 	 		} 
 	 	);
    	tx.executeSql(
    		'DROP TABLE IF EXISTS VINS',
    		null,
    		function (t, r) {
	 	 		document.getElementById('deletevins').innerHTML = 'Suppression table VINS OK'; 
 		 	},
 		 	function (t, err) {
 		 		document.getElementById('deletevins').innerHTML = 'Erreur suppression VINS ' + err.message;
 		 	}
 		);
    	tx.executeSql(
    		'DROP TABLE IF EXISTS PRODUCTEURS',
    		null,
    		function (t, r) {
	 	 		document.getElementById('deleteproducteurs').innerHTML = 'Suppression table PRODUCTEURS OK'; 
 		 	},
    		function (tx, err) {
		  		document.getElementById('deleteproducteurs').innerHTML = 'Erreur suppression PRODUCTEURS ' + err.message;});
			}
		);


