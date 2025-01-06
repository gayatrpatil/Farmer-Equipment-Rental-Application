<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            width: 30%;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #2e7d32;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            max-width: 250px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            margin-bottom: 10px;
        }
        input[type="submit"],
        input[type="reset"] {
            padding: 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            color: #fff;
            background-color: #2e7d32;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 10px;
        }
        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #1b5e20;
        }
        .register-link {
            text-align: center;
            margin-top: 15px;
        }
        .register-link a {
            text-decoration: none;
            color: #2e7d32;
            font-weight: bold;
            transition: color 0.3s;
        }
        .register-link a:hover {
            color: #1b5e20;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1>Login</h1>
    <form action="LoginServlet" method="post">
        <div>
            <label for="login-username">Username:</label>
            <input type="text" id="login-username" name="txtName" required>
        </div>
        <div>
            <label for="login-password">Password:</label>
            <input type="password" id="login-password" name="txtPwd" required>
        </div>
        <div>
            <input type="submit" value="Login">
            <input type="reset" value="Reset">
        </div>
    </form>
    <div class="register-link">
        <p>Don't have an account? <a href="Register.jsp">Register here</a></p>
    </div>
</div>
</body>
</html>

