<html>

<head>
<meta charset="utf-8">
<title>Toy Static</title>
<link href="inc/style.css" rel="stylesheet" type="text/css">
</head>
<body>
    <main id="signup">
      <div class="container">
        <form class="form" action="userController" method="post">
        <h2 class="title">Welcome to Toy Static</h2>
        <div class="account">
          <span>You can log in back into your account!</span>
        </div>
          <div class="input-group">
            <label for="email">Email</label>
            <input type="email" name="email" required />
          </div>
          <div class="input-group">
            <label for="password">Password</label>
            <input type="password" name="password" required />
          </div>
          <div class="account">
          <input type="hidden" name="action" value="login">
          <input type="submit" class="btn-login" value="LOG IN">
        </div>
        </form>
            <p style="font-family: 'Outfit', sans-serif; font-size: 1rem; color: #555; text-align: center; margin-top: 1rem;">
                Don't have an account yet?
                <a href="register.jsp" style="color: #000; font-weight: bold; text-decoration: none; transition: color 0.3s ease, text-shadow 0.3s ease;"
                   onmouseover="this.style.color='#007BFF'; this.style.textShadow='0 1px 3px rgba(0, 123, 255, 0.5)'; this.style.textDecoration='underline';"
                   onmouseout="this.style.color='#000'; this.style.textShadow='none'; this.style.textDecoration='none';">
                    Sign Up
                </a>
            </p>
      </div>
  </main>
</body>
</html>
