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

update_rdap(){
    echo "Checking rdap..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/xtomcom/rdap/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/rdap.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ rdap is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating rdap from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/rdap.rb

    # Download the new binaries
    wget -q -O rdap_macos_aarch64 https://github.com/xtomcom/rdap/releases/download/v${last_version}/rdap-${last_version}-macos-aarch64
    wget -q -O rdap_macos_x86_64 https://github.com/xtomcom/rdap/releases/download/v${last_version}/rdap-${last_version}-macos-x86_64

    # Calculate the SHA256 hash for the new binaries
    aarch64_sha256=$(sha256sum rdap_macos_aarch64 | cut -d ' ' -f 1)
    x86_64_sha256=$(sha256sum rdap_macos_x86_64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "8s/.*/    sha256 \"${aarch64_sha256}\"/" Formula/rdap.rb
    sed -i "11s/.*/    sha256 \"${x86_64_sha256}\"/" Formula/rdap.rb

    # Delete the new binaries
    rm -f rdap_macos*

    echo -e "${GREEN}✓ rdap updated successfully${NC}"
}

update_xpost(){
    echo "Checking xpost..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/xpost/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/xpost.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ xpost is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating xpost from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/xpost.rb

    # Download the new binaries
    wget -q -O xpost_darwin_amd64 https://github.com/missuo/xpost/releases/download/v${last_version}/xpost-darwin-amd64
    wget -q -O xpost_darwin_arm64 https://github.com/missuo/xpost/releases/download/v${last_version}/xpost-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum xpost_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum xpost_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "7s/.*/    sha256 \"${arm64_sha256}\"/" Formula/xpost.rb
    sed -i "10s/.*/    sha256 \"${amd64_sha256}\"/" Formula/xpost.rb

    # Delete the new binaries
    rm -f xpost_darwin*

    echo -e "${GREEN}✓ xpost updated successfully${NC}"
}

update_speedtest-rust(){
    echo "Checking speedtest-rust..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/speedtest-rust/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/speedtest-rust.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ speedtest-rust is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating speedtest-rust from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/speedtest-rust.rb

    # Download the new binaries
    wget -q -O speedtest_darwin_amd64 https://github.com/missuo/speedtest-rust/releases/download/v${last_version}/speedtest-darwin-amd64
    wget -q -O speedtest_darwin_arm64 https://github.com/missuo/speedtest-rust/releases/download/v${last_version}/speedtest-darwin-arm64

    # Calculate the SHA256 hash for the new binaries
    amd64_sha256=$(sha256sum speedtest_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum speedtest_darwin_arm64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "7s/.*/    sha256 \"${arm64_sha256}\"/" Formula/speedtest-rust.rb
    sed -i "10s/.*/    sha256 \"${amd64_sha256}\"/" Formula/speedtest-rust.rb

    # Delete the new binaries
    rm -f speedtest_darwin*

    echo -e "${GREEN}✓ speedtest-rust updated successfully${NC}"
}

update_mailclaw(){
    echo "Checking mailclaw..."

    # Get the latest version from GitHub API
    last_version=$(curl -Ls "https://api.github.com/repos/missuo/mailclaw/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')

    # Get current version from formula
    current_version=$(grep 'version "' Formula/mailclaw.rb | sed -E 's/.*version "([^"]+)".*/\1/')

    # Compare versions
    if [ "$current_version" = "$last_version" ]; then
        echo -e "${GREEN}✓ mailclaw is already up to date (v${current_version})${NC}"
        return 0
    fi

    echo -e "${YELLOW}→ Updating mailclaw from v${current_version} to v${last_version}${NC}"

    # Update version in the formula
    sed -i "s/version \".*\"/version \"${last_version}\"/" Formula/mailclaw.rb

    # Download the new binaries
    wget -q -O mailclaw_darwin_arm64 https://github.com/missuo/mailclaw/releases/download/v${last_version}/mailclaw-v${last_version}-aarch64-apple-darwin
    wget -q -O mailclaw_darwin_amd64 https://github.com/missuo/mailclaw/releases/download/v${last_version}/mailclaw-v${last_version}-x86_64-apple-darwin

    # Calculate the SHA256 hash for the new binaries
    arm64_sha256=$(sha256sum mailclaw_darwin_arm64 | cut -d ' ' -f 1)
    amd64_sha256=$(sha256sum mailclaw_darwin_amd64 | cut -d ' ' -f 1)

    # Update the SHA256 hashes in the formula
    sed -i "7s/.*/    sha256 \"${arm64_sha256}\"/" Formula/mailclaw.rb
    sed -i "10s/.*/    sha256 \"${amd64_sha256}\"/" Formula/mailclaw.rb

    # Delete the new binaries
    rm -f mailclaw_darwin*

    echo -e "${GREEN}✓ mailclaw updated successfully${NC}"
}

echo "======================================"
echo "  Homebrew Formula Update Script"
echo "======================================"
echo ""

update_deeplx
sleep 5
update_claude2openai
sleep 5
update_imgzip
sleep 5
update_polyglot-sub
sleep 5
update_fixtwitter
sleep 5
update_fixtwitter-nosb
sleep 5
update_xpost
sleep 5
update_rdap
sleep 5
update_speedtest-rust
sleep 5
update_mailclaw

echo ""
echo "======================================"
echo "  Update Check Complete"
echo "======================================"
