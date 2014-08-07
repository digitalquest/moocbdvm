try {

    if (!window.openDatabase) {
        alert('not supported');
    } else {
        var db = window.openDatabase('mydb', '1.0', 'my first database', 2 * 1024 * 1024);

        // You should have a database instance in db.
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
alert("Database is: "+db);

		db.transaction(function (tx) {
		  tx.executeSql('CREATE TABLE IF NOT EXISTS foo (id unique, text)');
		});
		alert("After table creation");
		db.transaction(function (tx) {
		  tx.executeSql("INSERT INTO foo (id, text) VALUES (1, 'synergies')");
		});
		alert("After row insertion");