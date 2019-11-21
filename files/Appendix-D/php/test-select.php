<html>
<head><title>SQL query</title></head>
<body>

<?php
// This is an include file that will pull the information of endpoint, username, password, and default database
include("connection-info.php");

echo "begin database<br />";
$link = mysqli_connect($endpoint,$user,$password,$dbname) or die("Error " . mysqli_error($link));

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$link->real_query("SELECT * FROM comment");
$res = $link->use_result();

echo "Result set order...<br />";
while ($row = $res->fetch_assoc()) {
    echo " id = " . $row['ID'] . "<br />";
    echo " Name = " . $row['PosterName'] . "<br />";
    echo " Title = " . $row['Title'] . "<br />";
    echo " Content = " . $row['Content'] . "<br />";
    echo " <hr />";
}


$link->close();

?>

</body>
</html>