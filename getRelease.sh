###
 # @Author: Vincent Young
 # @Date: 2023-02-17 19:18:08
 # @LastEditors: Vincent Yang
 # @LastEditTime: 2025-01-22 15:30:46
 # @FilePath: /homebrew-brew/getRelease.sh
 # @Telegram: https://t.me/missuo
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 

#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

update_deeplx(){
    echo "Checking DeepLX..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/OwO-Network/DeepLX/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/deeplx.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ DeepLX is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating DeepLX from v${current_version} to v${last_version}${NC}"

    # Update the version number in the formula
    sed -i "s/version \".*/version \"${last_version}\"/g" Formula/deeplx.rb

    # Download the new binaries
    wget -q -O deeplx_darwin_amd64 https://github.com/OwO-Network/DeepLX/releases/download/v${last_version}/deeplx_darwin_amd64
    wget -q -O deeplx_darwin_arm64 https://github.com/OwO-Network/DeepLX/releases/download/v${last_version}/deeplx_darwin_arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum deeplx_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum deeplx_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "8s/.*/    sha256 \"${arm64_sha256}\"/" Formula/deeplx.rb
    sed -i "11s/.*/    sha256 \"${amd64_sha256}\"/" Formula/deeplx.rb

    # Delete the new binaries
    rm -f deeplx_darwin*

    echo -e "${GREEN}✓ DeepLX updated successfully${NC}"
}

update_claude2openai(){
    echo "Checking Claude2OpenAI..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/claude2openai/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/claude2openai.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ Claude2OpenAI is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating Claude2OpenAI from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/claude2openai.rb

    # Download the new binaries
    wget -q -O claude2openai_darwin_amd64 https://github.com/missuo/claude2openai/releases/download/v${last_version}/claude2openai-darwin-amd64
    wget -q -O claude2openai_darwin_arm64 https://github.com/missuo/claude2openai/releases/download/v${last_version}/claude2openai-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum claude2openai_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum claude2openai_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "7s/.*/    sha256 \"${arm64_sha256}\"/" Formula/claude2openai.rb
    sed -i "10s/.*/    sha256 \"${amd64_sha256}\"/" Formula/claude2openai.rb

    # Delete the new binaries
    rm -f claude2openai_darwin*

    echo -e "${GREEN}✓ Claude2OpenAI updated successfully${NC}"
}

update_imgzip(){
    echo "Checking ImgZip..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/imgzip/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from cask
    current_version=$(grep 'version "' Casks/imgzip.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ ImgZip is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating ImgZip from v${current_version} to v${last_version}${NC}"

    # Update version in the cask
    sed -i "s/version \".*\"/version \"${last_version}\"/" Casks/imgzip.rb

    # Download the new binaries
    wget -q -O imgzip_darwin_amd64 https://github.com/missuo/imgzip/releases/download/v${last_version}/imgzip-darwin-amd64
    wget -q -O imgzip_darwin_arm64 https://github.com/missuo/imgzip/releases/download/v${last_version}/imgzip-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum imgzip_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum imgzip_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the cask
    sed -i "5s/.*/    sha256 \"${arm64_sha256}\"/" Casks/imgzip.rb
    sed -i "9s/.*/    sha256 \"${amd64_sha256}\"/" Casks/imgzip.rb

    # Delete the new binaries
    rm -f imgzip_darwin*

    echo -e "${GREEN}✓ ImgZip updated successfully${NC}"
}

update_polyglot-sub(){
    echo "Checking Polyglot Sub..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/PolyglotSub/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from cask
    current_version=$(grep 'version "' Casks/polyglot-sub.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ Polyglot Sub is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating Polyglot Sub from v${current_version} to v${last_version}${NC}"

    # Update version in the cask
    sed -i "s/version \".*\"/version \"${last_version}\"/" Casks/polyglot-sub.rb

    # Download the new binaries
    wget -q -O Polyglot.dmg https://github.com/missuo/PolyglotSub/releases/download/v${last_version}/Polyglot.dmg

    # Calculate the SHA256 hash for the new binaries
    sha256=$(sha256sum Polyglot.dmg | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the cask
    sed -i "3s/.*/  sha256 \"${sha256}\"/" Casks/polyglot-sub.rb

    # Delete the new binaries
    rm -f Polyglot*

    echo -e "${GREEN}✓ Polyglot Sub updated successfully${NC}"
}

update_fixtwitter(){
    echo "Checking FixTwitter..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/FixTwitter/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/fixtwitter.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ FixTwitter is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating FixTwitter from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/fixtwitter.rb

    # Download the new binaries
    wget -q -O fixtwitter_darwin_amd64 https://github.com/missuo/FixTwitter/releases/download/v${last_version}/fixtwitter-darwin-amd64
    wget -q -O fixtwitter_darwin_arm64 https://github.com/missuo/FixTwitter/releases/download/v${last_version}/fixtwitter-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum fixtwitter_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum fixtwitter_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "9s/.*/      sha256 \"${arm64_sha256}\"/" Formula/fixtwitter.rb
    sed -i "12s/.*/      sha256 \"${amd64_sha256}\"/" Formula/fixtwitter.rb

    # Delete the new binaries
    rm -f fixtwitter_darwin*

    echo -e "${GREEN}✓ FixTwitter updated successfully${NC}"
}

update_fixtwitter-nosb(){
    echo "Checking FixTwitter-NoSB..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/FixTwitter/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/fixtwitter-nosb.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ FixTwitter-NoSB is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating FixTwitter-NoSB from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/fixtwitter-nosb.rb

    # Download the new binaries
    wget -q -O fixtwitter_nosb_darwin_amd64 https://github.com/missuo/FixTwitter/releases/download/v${last_version}/fixtwitter-darwin-amd64
    wget -q -O fixtwitter_nosb_darwin_arm64 https://github.com/missuo/FixTwitter/releases/download/v${last_version}/fixtwitter-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum fixtwitter_nosb_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum fixtwitter_nosb_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "9s/.*/      sha256 \"${arm64_sha256}\"/" Formula/fixtwitter-nosb.rb
    sed -i "12s/.*/      sha256 \"${amd64_sha256}\"/" Formula/fixtwitter-nosb.rb

    # Delete the new binaries
    rm -f fixtwitter_nosb_darwin*

    echo -e "${GREEN}✓ FixTwitter-NoSB updated successfully${NC}"
}

echo "======================================"
echo "  Homebrew Formula Update Script"
echo "======================================"
echo ""

update_deeplx
echo ""
update_claude2openai
echo ""
update_imgzip
echo ""
update_polyglot-sub
echo ""
update_fixtwitter
echo ""
update_fixtwitter-nosb

echo ""
echo "======================================"
echo "  Update Check Complete"
echo "======================================"
