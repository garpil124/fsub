from dotenv import load_dotenv
import os

load_dotenv()

class Config:
    startmsg = (
        'The bot is up and running. These bots '
        'can store messages in custom chats, '
        'and users access them through the bot.'
    )
    forcemsg = (
        'To view messages shared by bots. '
        'Join first, then press the Try Again button.'
    )

    OWNER_ID = int(os.environ.get('OWNER_ID', '5944164836'))
    BOT_TOKEN = os.environ.get('BOT_TOKEN', '8266467068:AAG7PNYC1cbWbLgLyRLo7Fkuio2qYzaO8yg')
    DATABASE_ID = int(os.environ.get('DATABASE_ID', '-1003443158125'))
    MONGO_URL = os.environ.get('MONGO_URL', 'mongodb+srv://fsub:zqtjy3zlzU2blIGk@cluster0.nikqwau.mongodb.net/fsub?retryWrites=true&w=majority')

    API_ID = 38471748
    API_HASH = '3fec9eeb6468fbe2f7f1821cb6f48436'

Config = Config()
