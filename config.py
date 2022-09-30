import os

class Config(object):

    basedir = os.path.abspath(os.path.dirname(__file__))

    # Set up the App SECRET_KEY
    # SECRET_KEY = config('SECRET_KEY'  , default='S#perS3crEt_007')
    SECRET_KEY = os.getenv('SECRET_KEY', '3a7e56c91dbc8e3797eb6ca9d9238ec6')

    # Assets Management
    ASSETS_ROOT = os.getenv('ASSETS_ROOT', '/static')
    TEMPLATES_ROOT = os.getenv('TEMPLATES_ROOT','/templates')    
    
             
class ProductionConfig(Config):
    DEBUG = False

    # Security
    SESSION_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_DURATION = 3600



class DebugConfig(Config):
    FLASK_ENV = 'development'
    DEBUG = True
    TESTING = True
