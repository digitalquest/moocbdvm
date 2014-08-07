<?php
$server='localhost';
$database=strtolower($_POST['database']);
$user='pg_reader';
//$pass="whatever";
$pass='tpinfint';
$chaine_cx='host='.$server.' dbname='.$database.' user='.$user.' password='.$pass;
//print "<p><b>".$chaine_cx."</b></p>";
//print_r($chaine_cx);
$dbconn = pg_connect($chaine_cx)
    or die('Could not connect: ' . pg_last_error());
//print_r($_POST);
// Performing SQL query
$query = $_POST['reqsql'];
$query=stripslashes($query);

if ($query[strlen($query)-1] != ";")
{ $query=$query.";"; }


$codesql=explode(";", $query);
for ($j=0; $j<count($codesql)-1; $j++)
{
$reqsql1=ltrim($codesql[$j]);
print "<p><b>$reqsql1</b></p>";




$result = pg_query($reqsql1) or die('Query failed: ' . pg_last_error());
print '<p>Nombre de tuples = '.pg_num_rows($result);

// Printing results in HTML
echo "<table border=1>\n";
while ($line = pg_fetch_array($result, null, PGSQL_ASSOC)) {
    echo "\t<tr>\n";
    foreach ($line as $col_value) {
        echo "\t\t<td>$col_value</td>\n";
    }
    echo "\t</tr>\n";
}
echo "</table>\n";

// Free resultset
pg_free_result($result);
}
// Closing connection
pg_close($dbconn);
?>

