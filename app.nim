import jester
import strutils
import httpcore

import karax/ [karaxdsl, vdom]

proc registerForm(errList: seq[string]): string = 
  let vnode = buildHtml(html):
    head:
      title: text "book club"
    body:
      h3: text "Register"
      text "Enter your email address to sign up."
      if errList.len > 0:
        p:
          text "Error(s) found."
        ul:
          for msg in errList:
            li:
              bold: text msg
      form(action="/register-form", `method` = "POST"):
        input(`type` = "text", name = "email")
        button(`type` = "submit"):
          text "Send Email Address"
  return $vnode

proc checkEmailFormat(email: string): seq[string] = 
  result = @[]
  var parts = email.split('@')
  if parts.len < 2:
    result.add "MissingAtSymbol"

routes:
  get "/":
    resp "hello world"
  get "/register-form":
    resp registerForm(@[])
  get "/register-form/@err":
    let errors = @"err".split("|")
    resp registerForm(errors)
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