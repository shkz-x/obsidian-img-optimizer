# obsidian-img-optimizer | PNG to WEBP

This is a small script I made to optimize the size of my Obsidian vault by converting all .png images to .webp using the cwebp tool. The idea came up after I renewed my yearly Obsidian Sync plan and realized I was using more space than necessary, mostly due to heavy ".png" screenshots and diagrams. To avoid paying for extra storage, I batch-converted them to ".webp", keeping decent quality while drastically reducing file size :)

In my case, my image-vault went from 300 MB down to 120 MB aprox. If applied to larger vaults with lots of images, the impact can be more significant.
The script uses cwebp, which is available on Arch Linux (libwebp package), Ubuntu/Debian (webp package), and most other Linux distributions. 

The script will attempt to install it automatically if you are on one of these systems:

✅ Tested on Arch Linux <br>
✅ Tested on Ubuntu 24.04 LTS.

<br>

---

<br>

# ⚠️ Before you run it...

**Make a backup of your vault** just in case. The script deletes your original `.png` files after converting them and updates all `.md` links to use `.webp` instead. It's been safe in my use case, but better be cautious.

<br>



## What it does

- Converts all `.png` files in a folder to `.webp` (quality = 85)
- Deletes the original `.png`
- Rewrites all links in `.md` files from `.png` → `.webp`

<br>


## Usage

```bash
chmod +x convert_to_webp.sh
./convert_to_webp.sh
```

<br>

You’ll be prompted to enter: <br>
- The path to your image folder
- The path to your Obsidian vault (where .md files are)

