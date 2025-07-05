#!/bin/bash
# ------------ by shkz | myhack.tech ------------

read -rp "Enter the path to the image folder (e.g., /home/user/.obsidian/myVault/images-vault): " IMG_DIR
if [[ -z "$IMG_DIR" || ! -d "$IMG_DIR" ]]; then
    echo "Error: Invalid image directory. Exiting."
    exit 1
fi

read -rp "Enter the path to your Obsidian Notes (e.g., /home/user/.obsidian/myVault/): " NOTES_DIR
if [[ -z "$NOTES_DIR" || ! -d "$NOTES_DIR" ]]; then
    echo "Error: Invalid notes directory. Exiting."
    exit 1
fi

# Checking if 'cwebp' is installed | Arch | Ubuntu
if ! command -v cwebp &>/dev/null; then
    echo "Error: 'cwebp' is not installed."

    if command -v pacman &>/dev/null; then
        echo "[*] Attempting to install 'libwebp' via pacman (Arch)..."
        sudo pacman -S --noconfirm libwebp || {
            echo "Failed to install libwebp. Please install it manually."
            exit 1
        }
    elif command -v apt &>/dev/null; then
        echo "[*] Attempting to install 'webp' via apt (Ubuntu/Debian)..."
        sudo apt update && sudo apt install -y webp || {
            echo "Failed to install webp. Please install it manually."
            exit 1
        }
    else
        echo "Please install 'cwebp' manually using your system's package manager."
        exit 1
    fi
fi

echo "[*] Starting PNG to WebP conversion in: $IMG_DIR"

# Convert .png → .webp and delete original
find "$IMG_DIR" -type f -iname '*.png' | while read -r file; do
    newfile="${file%.png}.webp"
    echo "Converting -> $file → $newfile"
    cwebp -quiet -q 85 "$file" -o "$newfile" && rm "$file"
done

echo "[+] Conversion completed!"

# Update image links in .md files (.png → .webp)
echo "[+] Updating image links in Markdown files..."

find "$NOTES_DIR" -type f -iname '*.md' | while read -r note; do
    sed -i 's/\.png/\.webp/g' "$note"
done

echo "[*] Link update completed!"
echo "[*] Current .webp file count:"
find "$IMG_DIR" -type f -iname '*.webp' | wc -l

echo "[*] Remaining .png files (should be 0!):"
find "$IMG_DIR" -type f -iname '*.png' | wc -l

echo "Done! Your vault is now optimized."
