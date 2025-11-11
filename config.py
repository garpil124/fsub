"""
import os

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

    OWNER_ID = int(os.environ.get('OWNER_ID', ''))
    BOT_TOKEN = os.environ.get('BOT_TOKEN', '')
    DATABASE_ID = int(os.environ.get('DATABASE_ID', '0'))  # Berikan nilai default '0'
    MONGO_URL = os.environ.get('MONGO_URL', '')

    API_ID = 2040
    API_HASH = 'b18441a1ff607e10a989891a5462e627'
    BOT_ID = BOT_TOKEN.split(':', 1)[0]

Config = Config()
"""
from dotenv import load_dotenv
import os

# Memuat file .env dari direktori root
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

    OWNER_ID = int(os.environ.get('OWNER_ID', '7763935232'))
    BOT_TOKEN = os.environ.get('BOT_TOKEN', '7783930401:AAFjVzlzhYV8LcK_H_c64dg3iQe3o_WusoU')
    DATABASE_ID = int(os.environ.get('DATABASE_ID', '-1002549094524'))
    MONGO_URL = os.environ.get('MONGO_URL', 'mongodb+srv://Hancock:Malik10_@hancock.vh4empi.mongodb.net/?retryWrites=true&w=majority&appName=Hancock')

    API_ID = 29057224
    API_HASH = 'da205c3d61724a1358a02f2f09305928'
    BOT_ID = BOT_TOKEN.split(':', 1)[0]


Config = Config()
