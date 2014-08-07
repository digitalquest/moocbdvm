try {

    if (!window.openDatabase) {
        alert('not supported');
    } else {
        var maxSize = 65536 * 4; // in bytes
        var db = window.openDatabase('bdvins', '1.0', 'Base de données vins', maxSize);
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