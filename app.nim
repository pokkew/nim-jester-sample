import jester
import strutils

const REGISTER_FORM = """<html>
    <head>
        <title> book club! </title>
    </head>
    <body>
        <h3>Register</h3>
        Enter your email address to signup.
        <p>
            <b>$1</b>
        </p>
        <form action="/register-form" method="POST">
            <input type="text" name="email" />
            <button type="submit">Send Email Address</button>
        </form>
    </body>
</html>
"""

# settings:
#     port = Port(5001)

routes:
    get "/":
        resp "hello world"
    get "/register-form":
        resp REGISTER_FORM.format("")
    get "/register-form/@err":
        resp REGISTER_FORM.format(@"err")
    post "/register-form":
        if request.params["email"] == "":
            redirect "/register-form/$1".format("NeedEmailAddress")
        else:
            redirect "/hello/$1".format(request.params["email"])
    get "/hello/@email":
        if @"email" == "123":
            resp Http404
        else:
            resp "hello $1".format(@"email")
    post "/":   
        resp "something else"