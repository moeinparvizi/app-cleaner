#!/bin/bash

# --- تنظیم زبان ---
echo "Choose language / زبان را انتخاب کنید:"
echo "1) English"
echo "2) فارسی"
read -rp "Enter choice (1 or 2): " LANG_CHOICE

case $LANG_CHOICE in
    1) source ./lang/en.sh ;;
    2) source ./lang/fa.sh ;;
    *) echo "Invalid choice, defaulting to English." ; source ./lang/en.sh ;;
esac

# --- آماده‌سازی مسیر گزارش ---
REPORT_DIR="./reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/report-$(date +%Y%m%d-%H%M%S).txt"

# --- شروع کار ---
echo "$MSG_CHECK_SOURCES" | tee -a "$REPORT_FILE"

# اجرای apt update و ذخیره خطاها
sudo apt update 2> /tmp/apt-errors.txt | tee -a "$REPORT_FILE"

echo -e "\n$MSG_PROBLEMATIC_REPOS\n" | tee -a "$REPORT_FILE"

grep -E "E: The repository|NO_PUBKEY|does not have a Release file|403  Forbidden" /tmp/apt-errors.txt | tee -a "$REPORT_FILE"

echo -e "\n$MSG_CHECK_LIST_FILES\n" | tee -a "$REPORT_FILE"

shopt -s nullglob
for file in /etc/apt/sources.list.d/*.list; do
    echo "$MSG_FILE $file" | tee -a "$REPORT_FILE"
    cat "$file" | tee -a "$REPORT_FILE"

    echo -n "$MSG_DELETE_PROMPT" | tee -a "$REPORT_FILE"
    read -r answer
    echo "$answer" | tee -a "$REPORT_FILE"

    if [[ $answer == "y" ]]; then
        sudo rm "$file"
        echo "$MSG_DELETED $file" | tee -a "$REPORT_FILE"
    else
        echo "$MSG_KEPT" | tee -a "$REPORT_FILE"
    fi
    echo "------------------------------------" | tee -a "$REPORT_FILE"
done
shopt -u nullglob

echo -e "\n$MSG_DONE" | tee -a "$REPORT_FILE"
echo "$MSG_RUN_AGAIN" | tee -a "$REPORT_FILE"
