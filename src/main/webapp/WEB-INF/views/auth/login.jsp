<<<<<<< HEAD
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
>>>>>>> fb844a2af79b55394aa02ce33b43c2031182c9b8
<!DOCTYPE html>
<html>
<head>
    <title>Login - MindWell</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
<<<<<<< HEAD
        :root{
            --teal:#6fd7cc;
            --teal-dark:#3fb9a8;
            --muted:#7b8794;
            --card-bg:#ffffff;
            --page-bg:#f4f7f8;
            --radius:14px;
        }
        html,body{height:100%;margin:0;font-family:Inter, "Segoe UI", Roboto, Arial, sans-serif;background:var(--page-bg);color:#123;}
        .wrap{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding:40px 20px;
        }
        .container{
            width:420px;
            max-width:94%;
            background:var(--card-bg);
            border-radius:calc(var(--radius) + 6px);
            box-shadow:0 12px 30px rgba(18,24,33,0.08);
            overflow:hidden;
        }

        .hero-head{
            padding:28px 28px 18px;
            display:flex;
            align-items:center;
            gap:12px;
            border-bottom:1px solid #f0f3f4;
            background:linear-gradient(180deg, rgba(111,215,204,0.06), transparent 60%);
        }
        .logo-circle{
            width:48px;height:48px;border-radius:12px;background:var(--teal);display:flex;align-items:center;justify-content:center;flex-shrink:0;
            box-shadow:0 6px 18px rgba(111,215,204,0.18);
        }
        .logo-circle svg{width:24px;height:24px;fill:#fff;opacity:0.98}
        .brand{line-height:1;}
        .brand h1{margin:0;font-size:18px;color:#0f2d2a;}
        .brand p{margin:2px 0 0;font-size:12px;color:var(--muted);}

        .card-body{padding:22px;}
        .tabs{
            display:flex;
            gap:8px;
            background:#f7faf9;
            padding:6px;
            border-radius:12px;
            width:100%;
            margin-bottom:18px;
            box-sizing:border-box;
        }
        .tab{
            flex:1;
            text-align:center;
            padding:8px 6px;
            border-radius:10px;
            text-decoration:none;
            color:var(--muted);
            font-weight:600;
            font-size:13px;
            border:1px solid transparent;
        }
        .tab.active{
            background:linear-gradient(180deg,var(--teal),var(--teal-dark));
            color:#fff;
            box-shadow:inset 0 -2px 0 rgba(0,0,0,0.03);
        }

        form .field{margin-bottom:14px;}
        label{display:block;font-size:12px;color:#0f2d2a;margin-bottom:6px;}

        .input-icon{
            position:relative;
        }
        .input-icon input,
        .input-icon select{
            width:100%;
            padding:12px 12px 12px 40px;
            border-radius:10px;
            border:1px solid #e8eef0;
            background:#fbfeff;
            outline:none;
            font-size:14px;
            box-sizing:border-box;
            transition:box-shadow .12s, border-color .12s;
            color: #27433f; /* darker input text, but slightly lighter than label (#0f2d2a) */
        }
        .input-icon input::placeholder{color:#8fa29f}
        .input-icon svg{
            position:absolute;
            left:12px;
            top:50%;
            transform:translateY(-50%);
            width:18px;height:18px;
            fill:#98a6ab;
            opacity:0.95;
        }
        .input-icon input:focus,
        .input-icon select:focus{
            border-color:var(--teal-dark);
            box-shadow:0 6px 20px rgba(63,185,168,0.08);
        }

        .right-link{display:block;text-align:right;font-size:13px;margin-top:6px;color:var(--muted);}
        .right-link a{color:var(--teal-dark);text-decoration:none;font-weight:600;}

        .btn{
            display:inline-block;
            width:100%;
            padding:12px 14px;
            border-radius:10px;
            text-align:center;
            text-decoration:none;
            font-weight:700;
            border:none;
            cursor:pointer;
            font-size:15px;
        }
        .btn-primary{
            background:linear-gradient(180deg,var(--teal),var(--teal-dark));
            color:#ffffff;
            box-shadow:0 8px 20px rgba(63,185,168,0.14);
        }
        .small{
            font-size:13px;
            color:var(--muted);
            text-align:center;
            margin-top:12px;
        }
        .error{
            background:#ffefef;
            color:#8b1717;
            padding:8px 10px;
            border-radius:8px;
            font-size:13px;
            margin-bottom:12px;
            border:1px solid #ffd3d3;
        }
        .info{
            background:#f0fbf9;
            color:#0f6b60;
            padding:8px 10px;
            border-radius:8px;
            font-size:13px;
            margin-bottom:12px;
            border:1px solid rgba(111,215,204,0.3);
        }
=======
        :root{ --teal:#6fd7cc; --teal-dark:#3fb9a8; --muted:#7b8794; --card-bg:#ffffff; --page-bg:#f4f7f8; --radius:14px; }
        html,body{height:100%;margin:0;font-family:Inter, "Segoe UI", Roboto, Arial, sans-serif;background:var(--page-bg);color:#123}
        .wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 20px}
        .container{width:420px;max-width:94%;background:var(--card-bg);border-radius:calc(var(--radius) + 6px);box-shadow:0 12px 30px rgba(18,24,33,0.08);overflow:hidden}
        .hero-head{padding:28px 28px 18px;display:flex;align-items:center;gap:12px;border-bottom:1px solid #f0f3f4;background:linear-gradient(180deg, rgba(111,215,204,0.06), transparent 60%)}
        .logo-circle{width:48px;height:48px;border-radius:12px;background:var(--teal);display:flex;align-items:center;justify-content:center;flex-shrink:0;box-shadow:0 6px 18px rgba(111,215,204,0.18)}
        .logo-circle svg{width:24px;height:24px;fill:#fff;opacity:0.98}
        .brand h1{margin:0;font-size:18px;color:#0f2d2a}
        .brand p{margin:2px 0 0;font-size:12px;color:var(--muted)}
        .card-body{padding:22px}
        .tabs{display:flex;gap:8px;background:#f7faf9;padding:6px;border-radius:12px;width:100%;margin-bottom:18px;box-sizing:border-box}
        .tab{flex:1;text-align:center;padding:8px 6px;border-radius:10px;text-decoration:none;color:var(--muted);font-weight:600;font-size:13px;border:1px solid transparent}
        .tab.active{background:linear-gradient(180deg,var(--teal),var(--teal-dark));color:#fff;box-shadow:inset 0 -2px 0 rgba(0,0,0,0.03)}
        form .field{margin-bottom:14px}label{display:block;font-size:12px;color:#0f2d2a;margin-bottom:6px}
        .input-icon{position:relative}
        .input-icon input,.input-icon select{width:100%;padding:12px 12px 12px 40px;border-radius:10px;border:1px solid #e8eef0;background:#fbfeff;outline:none;font-size:14px;box-sizing:border-box;transition:box-shadow .12s, border-color .12s;color:#27433f}
        .input-icon input::placeholder{color:#8fa29f}.input-icon svg{position:absolute;left:12px;top:50%;transform:translateY(-50%);width:18px;height:18px;fill:#98a6ab;opacity:0.95}
        .input-icon input:focus,.input-icon select:focus{border-color:var(--teal-dark);box-shadow:0 6px 20px rgba(63,185,168,0.08)}
        .right-link{display:block;text-align:right;font-size:13px;margin-top:6px;color:var(--muted)}.right-link a{color:var(--teal-dark);text-decoration:none;font-weight:600}
        .btn{display:inline-block;width:100%;padding:12px 14px;border-radius:10px;text-align:center;text-decoration:none;font-weight:700;border:none;cursor:pointer;font-size:15px}
        .btn-primary{background:linear-gradient(180deg,var(--teal),var(--teal-dark));color:#ffffff;box-shadow:0 8px 20px rgba(63,185,168,0.14)}
        .small{font-size:13px;color:var(--muted);text-align:center;margin-top:12px}
        .error{background:#ffefef;color:#8b1717;padding:8px 10px;border-radius:8px;font-size:13px;margin-bottom:12px;border:1px solid #ffd3d3}
        .info{background:#f0fbf9;color:#0f6b60;padding:8px 10px;border-radius:8px;font-size:13px;margin-bottom:12px;border:1px solid rgba(111,215,204,0.3)}
>>>>>>> fb844a2af79b55394aa02ce33b43c2031182c9b8
    </style>
</head>
<body>
<div class="wrap">
    <div class="container">
        <div class="hero-head">
            <div class="logo-circle" aria-hidden="true">
<<<<<<< HEAD
                <!-- simple brain icon -->
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 3c1.5 0 2.2.4 3 1 .8.6 1.5 1.5 2 3 .5 1.5.5 3 .5 4.5S16 15 16 16.5 16.8 19 15 21c-1.8 2-3.5 0-3.5 0S11 19 9 17c-2-2-3 0-3 0S4 14 4 11.5 5 7 6.5 5.5 10.5 3 12 3z"/>
                </svg>
=======
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 3c1.5 0 2.2.4 3 1 .8.6 1.5 1.5 2 3 .5 1.5.5 3 .5 4.5S16 15 16 16.5 16.8 19 15 21c-1.8 2-3.5 0-3.5 0S11 19 9 17c-2-2-3 0-3 0S4 14 4 11.5 5 7 6.5 5.5 10.5 3 12 3z"/></svg>
>>>>>>> fb844a2af79b55394aa02ce33b43c2031182c9b8
            </div>
            <div class="brand">
                <h1>MindWell Hub</h1>
                <p>Your journey to wellness starts here</p>
            </div>
        </div>

        <div class="card-body">
            <div class="tabs" role="tablist" aria-label="auth tabs">
                <a class="tab active" href="${pageContext.request.contextPath}/auth/login">Login</a>
                <a class="tab" href="${pageContext.request.contextPath}/auth/register">Sign Up</a>
            </div>

            <c:if test="${not empty error}">
<<<<<<< HEAD
                <div class="error">${error}</div>
            </c:if>

            <c:if test="${not empty msg}">
                <div class="info">${msg}</div>
=======
                <div class="error"><c:out value="${error}"/></div>
            </c:if>

            <c:if test="${not empty msg}">
                <div class="info"><c:out value="${msg}"/></div>
>>>>>>> fb844a2af79b55394aa02ce33b43c2031182c9b8
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/login" method="post" novalidate>
                <div class="field">
                    <label for="email">Email</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                        <input id="email" type="email" name="username" placeholder="your.email@example.com" required/>
                    </div>
                </div>

                <div class="field">
                    <label for="password">Password</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 17a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm6-8h-1V7a5 5 0 0 0-10 0v2H6c-1.1 0-2 .9-2 2v7c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2v-7c0-1.1-.9-2-2-2zM9 7a3 3 0 0 1 6 0v2H9V7z"/></svg>
                        <input id="password" type="password" name="password" placeholder="Enter your password" required/>
                    </div>
                    <a class="right-link" href="${pageContext.request.contextPath}/auth/forgot">Forgot password?</a>
                </div>

                <div class="field" style="margin-top:8px;">
                    <button type="submit" class="btn btn-primary">Log In</button>
                </div>

<<<<<<< HEAD
                <div class="small">
                    By continuing, you agree to our <a href="#" style="color:var(--teal-dark);text-decoration:none;">Terms of Service</a> and <a href="#" style="color:var(--teal-dark);text-decoration:none;">Privacy Policy</a>.
                </div>

                <div style="text-align:center;margin-top:12px;font-size:13px;color:var(--muted);">
                    Don't have an account? <a href="${pageContext.request.contextPath}/auth/register" style="color:var(--teal-dark);font-weight:600;">Sign Up</a>
                </div>
=======
                <div class="small">By continuing, you agree to our <a href="#" style="color:var(--teal-dark);text-decoration:none;">Terms of Service</a> and <a href="#" style="color:var(--teal-dark);text-decoration:none;">Privacy Policy</a>.</div>

                <div style="text-align:center;margin-top:12px;font-size:13px;color:var(--muted);">Don't have an account? <a href="${pageContext.request.contextPath}/auth/register" style="color:var(--teal-dark);font-weight:600;">Sign Up</a></div>
>>>>>>> fb844a2af79b55394aa02ce33b43c2031182c9b8
            </form>
        </div>
    </div>
</div>
</body>
<<<<<<< HEAD
</html>
=======
</html>
>>>>>>> fb844a2af79b55394aa02ce33b43c2031182c9b8
