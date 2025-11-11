#!/usr/bin/env bash
set -euo pipefail

# deploy.sh
# Satu langkah deploy untuk project Telegram bot.
# - Membuat virtualenv (./venv)
# - Menginstall requirements.txt
# - Membuat .env.sample jika .env tidak ada
# - Menjadikan start.sh executable
# - (Opsional otomatis) men-setup systemd service jika dijalankan sebagai root

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$REPO_DIR/venv"
REQ_FILE="$REPO_DIR/requirements.txt"
ENV_FILE="$REPO_DIR/.env"
ENV_SAMPLE="$REPO_DIR/.env.sample"
START_SH="$REPO_DIR/start.sh"
SERVICE_NAME="$(basename "$REPO_DIR")"
PYTHON_BIN="python3"

echo "🔎 Repo: $REPO_DIR"

# 1) Pastikan python3 ada
if ! command -v $PYTHON_BIN >/dev/null 2>&1; then
  echo "❌ $PYTHON_BIN tidak ditemukan. Silakan install Python 3.x sebelum menjalankan deploy." >&2
  exit 1
fi

# 2) Buat virtualenv jika belum ada
if [ ! -d "$VENV_DIR" ]; then
  echo "🟢 Membuat virtual environment di: $VENV_DIR"
  $PYTHON_BIN -m venv "$VENV_DIR"
else
  echo "ℹ️ Virtual environment sudah ada: $VENV_DIR"
fi

# Aktifkan venv untuk instalasi
# shellcheck source=/dev/null
source "$VENV_DIR/bin/activate"

# 3) Upgrade pip dan setuptools
echo "⬆️ Meng-upgrade pip, setuptools, wheel"
pip install --upgrade pip setuptools wheel

# 4) Install dependencies
if [ -f "$REQ_FILE" ]; then
  echo "📦 Menginstall requirements dari $REQ_FILE"
  # coba install normal dulu. Jika gagal di package wheel build, keluarkan pesan bantuan.
  if ! pip install -r "$REQ_FILE" --no-cache-dir; then
    echo "⚠️ Gagal install beberapa packages lewat pip. Coba jalankan 'bash setup.sh' untuk menginstall paket sistem (build-essential, libffi-dev, dll) lalu jalankan ulang deploy.sh" >&2
    deactivate || true
    exit 1
  fi
else
  echo "⚠️ requirements.txt tidak ditemukan di $REQ_FILE — lewati instalasi paket Python." >&2
fi

# 5) Pastikan start.sh executable
if [ -f "$START_SH" ]; then
  chmod +x "$START_SH"
  echo "✅ start.sh dibuat executable"
else
  echo "⚠️ start.sh tidak ditemukan di $START_SH. Pastikan ada file start.sh yang menjalankan 'python3 main.py' atau sesuaikan." >&2
fi

# 6) Buat .env.sample / .env jika belum ada
if [ ! -f "$ENV_FILE" ]; then
  echo "📄 .env tidak ditemukan — membuat .env.sample dengan variabel yang umum digunakan"
  cat > "$ENV_SAMPLE" <<'EOF'
# SALIN file ini menjadi .env dan isi dengan nilai Anda
BOT_TOKEN=
OWNER_ID=
MONGO_URL=
DATABASE_ID=
# Contoh tambahan:
# API_ID=
# API_HASH=
EOF
  echo "✅ .env.sample dibuat. Jalankan: cp .env.sample .env  && edit .env sebelum menjalankan bot."
else
  echo "ℹ️ .env ditemukan — akan digunakan oleh service atau start.sh"
fi

# 7) Optional: Setup systemd jika dijalankan sebagai root
if [ "$(id -u)" -eq 0 ]; then
  echo "⚙️ Men-setup systemd service bernama: $SERVICE_NAME.service"
  SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"
  cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=$SERVICE_NAME
After=network.target

[Service]
Type=simple
User=$(logname 2>/dev/null || echo root)
WorkingDirectory=$REPO_DIR
ExecStart=$VENV_DIR/bin/python $REPO_DIR/main.py
Restart=on-failure
Environment=PYTHONUNBUFFERED=1

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable --now "$SERVICE_NAME"
  echo "✅ Service systemd $SERVICE_NAME ditambahkan & dijalankan (cek: sudo systemctl status $SERVICE_NAME)"
else
  echo "ℹ️ Tidak dijalankan sebagai root — tidak membuat service systemd secara otomatis."
  echo "   Jika ingin systemd, jalankan 'sudo bash systemd.sh' atau jalankan deploy.sh dengan sudo untuk membuat service otomatis."
fi

# 8) Finish
deactivate || true

cat <<MSG

🎉 Deploy selesai (ringkasan):
- Virtualenv: $VENV_DIR
- Requirements: ${REQ_FILE##*/} $( [ -f "$REQ_FILE" ] && echo '✓' || echo '✗' )
- start.sh executable: $( [ -f "$START_SH" ] && echo '✓' || echo '✗' )
- .env: $( [ -f "$ENV_FILE" ] && echo '✓ (ada)' || echo '✗ (.env.sample dibuat)')

Cara menjalankan sekarang:
1) Jika ingin langsung menjalankan manual tanpa systemd:
   source $VENV_DIR/bin/activate && bash $START_SH
2) Jika systemd dibuat (jika Anda menjalankan deploy.sh sebagai root):
   sudo systemctl status $SERVICE_NAME

Catatan:
- Jika pip install gagal karena build tools, jalankan bash setup.sh lalu ulangi deploy.sh.
- Periksa variabel di .env sebelum menjalankan agar bot dapat membaca konfigurasi.

MSG

exit 0
