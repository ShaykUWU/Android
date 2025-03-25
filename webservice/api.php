<?php
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "root";
$dbname = "arras_gaming";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Log pour confirmer la connexion
    error_log("Connexion réussie à la base de données : $dbname");

    if (isset($_GET['login']) && isset($_GET['pwd'])) {
        $login = $_GET['login'];
        $pwd = $_GET['pwd'];

        error_log("Login reçu : '$login'");
        error_log("Mot de passe reçu : '$pwd'");

        $stmt = $conn->prepare("SELECT * FROM users WHERE login = :login AND pwd = :pwd");
        $stmt->execute(['login' => $login, 'pwd' => $pwd]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            error_log("Utilisateur trouvé : " . json_encode($user));

            $stmt = $conn->prepare("SELECT u.id,
                   u.user_id,
                   u.package_id,
                   u.code,
                   u.reservation_date,
                   u.duration,
                   p.name AS forfait_nom 
            FROM users_packages u 
            LEFT JOIN packages p ON u.package_id = p.id
                                   WHERE u.user_id = :user_id");
            $stmt->execute(['user_id' => $user['id']]);
            $reservations = $stmt->fetchAll(PDO::FETCH_ASSOC);

            echo json_encode([
                "message" => "Authentification réussie",
                "user_id" => $user['id'],
                "login" => $user['login'],
                "pseudo" => $user['pseudo'],
                "reservations" => $reservations
            ]);
        } else {
            error_log("Aucun utilisateur trouvé pour login='$login' et pwd='$pwd'");
            echo json_encode([
                "message" => "Identifiants incorrects",
                "user_id" => -1
            ]);
        }
    } else {
        echo json_encode([
            "message" => "Paramètres manquants",
            "user_id" => -1
        ]);
    }
} catch (PDOException $e) {
    error_log("Erreur de connexion PDO : " . $e->getMessage());
    echo json_encode([
        "message" => "Erreur de connexion à la base de données : " . $e->getMessage(),
        "user_id" => -1
    ]);
}
?>