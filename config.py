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

    OWNER_ID = int(os.environ.get('OWNER_ID', '0'))
    BOT_TOKEN = os.environ.get('BOT_TOKEN', '')
    DATABASE_ID = int(os.environ.get('DATABASE_ID', '0'))
    MONGO_URL = os.environ.get('MONGO_URL', '')

    API_ID = int(os.environ.get('API_ID', '0'))
    API_HASH = os.environ.get('API_HASH', '')
    BOT_ID = BOT_TOKEN.split(':', 1)[0]

Config = Config()
