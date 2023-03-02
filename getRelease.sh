
###
 # @Author: Vincent Young
 # @Date: 2023-02-17 19:18:08
 # @LastEditors: Vincent Young
 # @LastEditTime: 2023-02-17 19:30:52
 # @FilePath: /homebrew-brew/getRelease.sh
 # @Telegram: https://t.me/missuo
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 

update_chatgpt(){
    last_version=$(curl -Ls "https://api.github.com/repos/lencx/ChatGPT/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')
    sed -i "s/version.*/version \"${last_version}\"/g" Casks/chatgpt.rb
}

update_deeplx(){
    last_version=$(curl -Ls "https://api.github.com/repos/OwO-Network/DeepLX/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//g')
    sed -i "s/version.*/version \"${last_version}\"/g" Formula/deeplx.rb
}

update_chatgpt
update_deeplx
