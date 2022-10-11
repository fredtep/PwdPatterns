import os
from flask import Flask, render_template
import json
from os import listdir

PwdFiles = listdir('results')
menus = [os.path.splitext(file)[0] for file in PwdFiles]

# create and configure the app
app = Flask(__name__, instance_relative_config=True)
app.config.from_object('config.DebugConfig')
# a simple page that says hello
@app.route('/')
def home():
    # Opening JSON file
    with open('results/rockyou.json', 'r', encoding='utf-8') as f:
        data = json.loads(f.read())
        PasswordList = data['PasswordList']
        NumberOfPasswords = data['NumberOfPasswords']
        Length = data['Length']
        Pattern = data['Pattern']
        LowNumPattern = data['LowNumPattern']
        LowerN = data['LowerN']
        SpecAny = data['SpecAny']
    f.close()
    return render_template(
        'home.html',
        title="Research on password pattern",
        description="Wordlist : rockyou.txt",
        PasswordList=PasswordList,
        NumberOfPasswords=NumberOfPasswords,
        PwdLength=Length,
        Pattern=Pattern,
        LowNumPattern=LowNumPattern,
        LowerN=LowerN,
        SpecAny=SpecAny,
        PwdFiles=PwdFiles,
        menus=menus
    )

@app.route('/<string:pwdlist>')
def pwd_menu(pwdlist:str):
    # Opening JSON file
    
    with open('results/'+str(pwdlist)+'.json', 'r', encoding='utf-8') as f:
        data = json.loads(f.read())
        PasswordList = data['PasswordList']
        NumberOfPasswords = data['NumberOfPasswords']
        Length = data['Length']
        Pattern = data['Pattern']
        LowNumPattern = data['LowNumPattern']
        LowerN = data['LowerN']
        SpecAny = data['SpecAny']
    f.close()
    return render_template(
        'home.html',
        title="Research on password pattern",
        description="Wordlist :"+str(pwdlist),
        PasswordList=PasswordList,
        NumberOfPasswords=NumberOfPasswords,
        PwdLength=Length,
        Pattern=Pattern,
        LowNumPattern=LowNumPattern,
        LowerN=LowerN,
        SpecAny=SpecAny,
        PwdFiles=PwdFiles,
        menus=menus
    )