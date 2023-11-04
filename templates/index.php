<!DOCTYPE html>
<html>

<head>
    <title>Conecting PHP with MySQL</title>
</head>

<body>

    <?php
    // Database credentials
    $servername = "{{ mysql_db_host }}";
    $username = "{{ mysql_db_user }}";
    $password = "{{ mysql_db_pass }}";
    $database = "{{ mysql_db_name }}";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $database);

    // Verify connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    echo "Connection with MySQL sucessful!";

    // Close connection
    $conn->close();
    ?>

</body>

</html>
