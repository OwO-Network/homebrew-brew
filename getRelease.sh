
###
 # @Author: Vincent Young
 # @Date: 2023-02-17 19:18:08
 # @LastEditors: Vincent Young
 # @LastEditTime: 2023-03-03 01:10:41
 # @FilePath: /homebrew-brew/getRelease.sh
 # @Telegram: https://t.me/missuo
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 

update_deeplx(){
    last_version=$(curl -Ls "https://api.github.com/repos/OwO-Network/DeepLX/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')
    sed -i "s/version \".*/version \"${last_version}\"/g" Formula/deeplx.rb
    wget https://github.com/OwO-Network/DeepLX/releases/download/v${last_version}/deeplx_darwin_amd64
    wget https://github.com/OwO-Network/DeepLX/releases/download/v${last_version}/deeplx_darwin_arm64
    amd64_sha256=$(sha256sum deeplx_darwin_amd64 | cut -d ' ' -f 1)
    arm64_sha256=$(sha256sum deeplx_darwin_arm64 | cut -d ' ' -f 1)
    echo amd64_sha256
    echo arm64_sha256
    # sed -i '' '0,/sha256 \"[0-9a-f]*\"/s//sha256 \"${arm64_sha256}\"/' Formula/deeplx.rb
    # sed -i '' '1,/sha256 \"[0-9a-f]*\"/s//sha256 \"${amd64_sha256}\"/' Formula/deeplx.rb
}
update_deeplx
