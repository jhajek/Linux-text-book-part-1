<html>
<head><title>SQL query</title></head>
<body>

<?php

# Get FQDN, User, dbname (comments) and Password from ENV 
echo "Begin database<br />";
$link = mysqli_connect("dbhost.example.com",$_ENV["DBUSER"],$_ENV["WORKERPASS"],"comments") or die("Error " . mysqli_error($link));

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