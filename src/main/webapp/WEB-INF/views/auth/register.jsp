<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - MindWell</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
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
        .brand{
            line-height:1;
        }
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
        /* inputs: make entered text darker but still a little lighter than labels */
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
        /* placeholder slightly muted relative to the input value */
        .input-icon input::placeholder{color:#8fa29f}
        /* custom select trigger label should match input color */
        .custom-select__trigger .label { color: #27433f; }
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

        /* --- ROLE SELECT SPECIFIC STYLING --- */
        /* apply rounded select and move dropdown indicator slightly left only for the role field */
        .input-icon.role { position: relative; }

        /* custom styled select (modern, rounded dropdown menu) */
        .custom-select {
            position: relative;
            width: 100%;
            font-size: 14px;
            outline: none;
        }
        .custom-select__trigger {
            /* make padding match other inputs: text starts at 40px */
            position: relative;               /* allow absolute icon like other inputs */
            display:flex;
            align-items:center;
            gap:12px;
            padding:12px 44px 12px 40px; /* room for icon left and arrow right */
            border-radius:12px;
            border:1px solid #e8eef0;
            background:#fbfeff;
            cursor:pointer;
            box-sizing:border-box;
            transition: box-shadow .12s, border-color .12s;
        }
        .custom-select__trigger .icon {
            /* align icon exactly like other .input-icon svg */
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            width:20px;
            height:20px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            color: #98a6ab;
            flex-shrink:0;
        }
        .custom-select__trigger .label {
            /* remove extra gap so label lines up with other input text */
            margin-left: 0;
            padding-left: 0;
            flex:1;
            color:#0f2d2a;
        }
        /* arrow moved to the right and vertically centered */
        .custom-select__trigger .arrow {
            position: absolute;
            right: 12px;                     /* right aligned */
            top: 50%;
            transform: translateY(-50%) rotate(45deg);
            width:12px;
            height:12px;
            display:inline-block;
            border-right: 1.5px solid #98a6ab;
            border-bottom: 1.5px solid #98a6ab;
            margin-left: 0px;
            align-self:center;
        }

        .custom-options {
            position: absolute;
            left: 0;
            right: 0;
            margin-top:10px;
            background: #ffffff;
            border-radius: 10px;
            border: 1px solid rgba(18,24,33,0.06);
            box-shadow: 0 12px 30px rgba(18,24,33,0.08);
            z-index: 60;
            overflow: hidden;
            max-height: 220px;
            overflow-y: auto;
            display: none;
        }
        .custom-select.open .custom-options { display:block; }

        .custom-option {
            padding:12px 16px;
            cursor:pointer;
            color:#0f2d2a;
            background: #fff;
            transition: background .08s;
            user-select: none;
        }
        .custom-option:hover,
        .custom-option[aria-selected="true"] {
            background: linear-gradient(90deg, rgba(111,215,204,0.06), rgba(63,185,168,0.03));
        }

        /* hide native select visually but keep it for form submission */
        select.hidden-native {
            position: absolute !important;
            width:1px; height:1px;
            padding:0; margin:-1px;
            overflow:hidden; clip:rect(0 0 0 0);
            border:0;
        }

        /* small scrollbar polish (webkit) */
        .custom-options::-webkit-scrollbar { width:8px; }
        .custom-options::-webkit-scrollbar-thumb { background: rgba(0,0,0,0.06); border-radius:6px; }
        .custom-options::-webkit-scrollbar-track { background: transparent; }
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
    </style>
</head>
<body>
<div class="wrap">
    <div class="container">
        <div class="hero-head">
            <div class="logo-circle" aria-hidden="true">
                <!-- simple brain icon -->
                <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 3c1.5 0 2.2.4 3 1 .8.6 1.5 1.5 2 3 .5 1.5.5 3 .5 4.5S16 15 16 16.5 16.8 19 15 21c-1.8 2-3.5 0-3.5 0S11 19 9 17c-2-2-3 0-3 0S4 14 4 11.5 5 7 6.5 5.5 10.5 3 12 3z"/>
                </svg>
            </div>
            <div class="brand">
                <h1>MindWell Hub</h1>
                <p>Your journey to wellness starts here</p>
            </div>
        </div>

        <div class="card-body">
            <div class="tabs" role="tablist" aria-label="auth tabs">
                <a class="tab" href="${pageContext.request.contextPath}/auth/login">Login</a>
                <a class="tab active" href="${pageContext.request.contextPath}/auth/register">Sign Up</a>
            </div>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/register" method="post" novalidate>
                <div class="field">
                    <label for="fullName">Full Name:</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v1h16v-1c0-2.66-5.33-4-8-4z"/></svg>
                        <input id="fullName" type="text" name="fullName" placeholder="John Doe" required/>
                    </div>
                </div>

                <div class="field">
                    <label for="email">Email:</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>
                        <input id="email" type="email" name="email" placeholder="your.email@example.com" required/>
                    </div>
                </div>

                <div class="field">
                    <label for="username">Username:</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 12c2.7 0 5-2.3 5-5s-2.3-5-5-5-5 2.3-5 5 2.3 5 5 5zm0 2c-3.3 0-10 1.7-10 5v3h20v-3c0-3.3-6.7-5-10-5z"/></svg>
                        <input id="username" type="text" name="username" placeholder="username" required/>
                    </div>
                </div>

                <div class="field">
                    <label for="role">I am a...</label>

                    <!-- native select kept but hidden for form submission -->
                    <select id="role" name="role" class="hidden-native" required>
                        <option value="" disabled selected>Select your role</option>
                        <option value="STUDENT">Student</option>
                        <option value="MHP">Mental Health Professional</option>
                        <option value="ADMIN">Admin</option>
                    </select>

                    <!-- custom select UI -->
                    <div class="custom-select" id="customRole" tabindex="0" role="listbox" aria-haspopup="listbox" aria-expanded="false">
                        <div class="custom-select__trigger" aria-label="Select role">
                            <span class="icon" aria-hidden="true">
                                <svg viewBox="0 0 24 24" width="18" height="18" fill="#98a6ab" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 2L3 7v6c0 5 3.8 9.7 9 10 5.2-.3 9-5 9-10V7l-9-5z"/>
                                </svg>
                            </span>
                            <span class="label">Select your role</span>
                            <span class="arrow" aria-hidden="true"></span>
                        </div>

                        <div class="custom-options" role="presentation" aria-label="Role options">
                            <div class="custom-option" data-value="STUDENT" role="option" tabindex="-1">Student</div>
                            <div class="custom-option" data-value="MHP" role="option" tabindex="-1">Mental Health Professional</div>
                            <div class="custom-option" data-value="ADMIN" role="option" tabindex="-1">Admin</div>
                        </div>
                    </div>
                </div>

                <div class="field">
                    <label for="password">Password:</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 17a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm6-8h-1V7a5 5 0 0 0-10 0v2H6c-1.1 0-2 .9-2 2v7c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2v-7c0-1.1-.9-2-2-2zM9 7a3 3 0 0 1 6 0v2H9V7z"/></svg>
                        <input id="password" type="password" name="password" placeholder="Create a strong password" required/>
                    </div>
                </div>

                <div class="field">
                    <label for="confirm">Confirm Password:</label>
                    <div class="input-icon">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 17a2 2 0 1 0 0-4 2 2 0 0 0 0 4zM20 7h-1V6a7 7 0 1 0-14 0v1H4c-1.1 0-2 .9-2 2v7c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V9c0-1.1-.9-2-2-2zM7 6a5 5 0 0 1 10 0v1H7V6z"/></svg>
                        <input id="confirm" type="password" name="confirmPassword" placeholder="Confirm your password" required/>
                    </div>
                </div>

                <div class="field" style="margin-top:8px;">
                    <button type="submit" class="btn btn-primary">Create Account</button>
                </div>

                <div class="small">
                    Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Login</a>
                </div>
            </form>
        </div>
    </div>
</div>
    <!-- add a small script to wire the custom select -->
    <script>
        (function(){
            const custom = document.getElementById('customRole');
            if(!custom) return;
            const trigger = custom.querySelector('.custom-select__trigger');
            const optionsWrap = custom.querySelector('.custom-options');
            const options = Array.from(custom.querySelectorAll('.custom-option'));
            const native = document.getElementById('role');
            const label = custom.querySelector('.label');

            function openClose(toggle){
                const isOpen = custom.classList.contains('open');
                if(typeof toggle === 'boolean') {
                    toggle ? custom.classList.add('open') : custom.classList.remove('open');
                } else {
                    custom.classList.toggle('open');
                }
                custom.setAttribute('aria-expanded', custom.classList.contains('open'));
            }

            trigger.addEventListener('click', function(e){
                openClose();
            });

            // click an option
            options.forEach(opt => {
                opt.addEventListener('click', function(){
                    const v = this.getAttribute('data-value');
                    const t = this.textContent.trim();
                    // update label
                    label.textContent = t;
                    // set native select
                    native.value = v;
                    // mark selected
                    options.forEach(o => o.setAttribute('aria-selected', 'false'));
                    this.setAttribute('aria-selected', 'true');
                    openClose(false);
                });
            });

            // close when clicking outside
            document.addEventListener('click', function(e){
                if(!custom.contains(e.target)) openClose(false);
            });

            // keyboard support: Enter/Space opens, Arrow keys navigate, Enter selects
            custom.addEventListener('keydown', function(e){
                const open = custom.classList.contains('open');
                const focused = document.activeElement;
                const currentIndex = options.findIndex(o=>o.getAttribute('aria-selected')==='true');
                if(e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    if(!open) { openClose(true); options[0].focus(); }
                    else if(focused.classList.contains('custom-option')) focused.click();
                } else if(e.key === 'ArrowDown') {
                    e.preventDefault();
                    if(!open){ openClose(true); options[0].focus(); }
                    else {
                        let next = 0;
                        if(focused.classList.contains('custom-option')) {
                            const idx = options.indexOf(focused);
                            next = Math.min(options.length -1, idx +1);
                        }
                        options[next].focus();
                    }
                } else if(e.key === 'ArrowUp') {
                    e.preventDefault();
                    if(open){
                        let prev = options.length -1;
                        if(focused.classList.contains('custom-option')) {
                            const idx = options.indexOf(focused);
                            prev = Math.max(0, idx -1);
                        }
                        options[prev].focus();
                    }
                } else if(e.key === 'Escape') {
                    openClose(false);
                    trigger.focus();
                }
            });

            // ensure focus moves into options when opened by click
            options.forEach(o => o.addEventListener('keydown', function(e){
                if(e.key === 'Enter' || e.key === ' ') { e.preventDefault(); this.click(); }
            }));
        })();
    </script>
</body>
</html>