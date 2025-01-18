<!doctype html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Toy Static</title>
  <link href="inc/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>

<body>
  <main id="signup">
    <div class="container">
      <form class="form" action="userController" method="POST">
        <h2 class="title">Create your own account</h2>
     <div class="account">
        <span>Don't have an account yet? Make one!</span>
       </div>
        <div class="input-group">
          <label for="name">Name</label>
          <input type="text" name="name" required/>
        </div>
        <div class="input-group">
          <label for="email">Email</label>
          <input type="email" name="email" required/>
        </div>
        <div class="input-group">
          <label for="address">Address</label>
          <input type="address" name="address" required/>
        </div>
        <div class="input-group">
          <label for="password">Password</label>
          <input type="password" name="password"required />
        </div>
        <div class="input-group">
          <label for="password">Confirm Password</label>
          <input type="password" name="confirmPassword" required />
        </div>
        <div class="account">
          <input type="hidden" name="action" value="signup">
          <input type="submit" class="btn-login" name="register" value="SIGN UP">
        </div>

      </form>
        <p style="font-family: 'Outfit', sans-serif; font-size: 1rem; color: #555; text-align: center; margin-top: 1rem;">
               Already have an account?
                <a href="login.jsp" style="color: #000; font-weight: bold; text-decoration: none; transition: color 0.3s ease, text-shadow 0.3s ease;"
                   onmouseover="this.style.color='#007BFF'; this.style.textShadow='0 1px 3px rgba(0, 123, 255, 0.5)'; this.style.textDecoration='underline';"
                   onmouseout="this.style.color='#000'; this.style.textShadow='none'; this.style.textDecoration='none';">
                    Log in
                </a>
            </p>
    </div>
  </main>
</body>

</html>