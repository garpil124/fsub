# Clone Repo anda
```
git clone repo && cd nama repo
```

# run setup
```
bash setup.sh
```

# Ruun systemd
```
bash systemd.sh
```
# Pastikan config.py sudah terisi data yang diperlukan
```
OWNER_ID = int(os.environ.get('OWNER_ID', ''))
    BOT_TOKEN = os.environ.get('BOT_TOKEN', '')
    DATABASE_ID = int(os.environ.get('DATABASE_ID', ''))
    MONGO_URL = os.environ.get('MONGO_URL', '')
```
