<!--
 * @Author: Vincent Young
 * @Date: 2023-02-07 03:06:58
 * @LastEditors: Vincent Young
 * @LastEditTime: 2023-03-03 02:12:55
 * @FilePath: /homebrew-brew/README.md
 * @Telegram: https://t.me/missuo
 * 
 * Copyright © 2023 by Vincent, All Rights Reserved. 
-->
# OwO Network - Homebrew
This is the repository used for [OwO Network](https://github.com/OwO-Network) Homebrew installations.

## Preparation
1. You should make sure that `Homebrew` is already installed on your Mac. if not, you can install it using the following command.
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
2. You should use the `tap` command to add our repository.
```shell
brew tap owo-network/brew
```

## Install
After tapping `owo-network/brew`, you can install packages with the commands
below.

### Casks

| Name | Description | Install command |
| --- | --- | --- |
| [imgzip](https://github.com/missuo/imgzip) | A simple and efficient image compression tool | `brew install --cask owo-network/brew/imgzip` |
| [koe](https://github.com/missuo/koe) | A zero-GUI macOS voice input tool | `brew install --cask owo-network/brew/koe` |
| [mist](https://github.com/missuo/Mist) | Lightweight S3 image uploader for macOS | `brew install --cask owo-network/brew/mist` |
| [polyglot-sub](https://github.com/missuo/PolyglotSub) | Subtitle translator based on DeepLX | `brew install --cask owo-network/brew/polyglot-sub` |

### Formulae

| Name | Description | Install command |
| --- | --- | --- |
| [claude2openai](https://github.com/missuo/claude2openai) | A proxy to convert Claude API into OpenAI API format | `brew install owo-network/brew/claude2openai` |
| [coffer](https://github.com/missuo/coffer) | A simple, fast, and secure key-value store | `brew install owo-network/brew/coffer` |
| [deeplx](https://github.com/OwO-Network/DeepLX) | DeepLX is a permanently free DeepL API client written in Golang. | `brew install owo-network/brew/deeplx` |
| [fixtwitter](https://github.com/missuo/fixtwitter) | Background service that automatically replaces X.com links with fxtwitter.com in clipboard | `brew install owo-network/brew/fixtwitter` |
| [fixtwitter-nosb](https://github.com/missuo/fixtwitter) | Background service that automatically replaces X.com links with no.sb in clipboard | `brew install owo-network/brew/fixtwitter-nosb` |
| [mailclaw](https://github.com/missuo/mailclaw) | CLI for interacting with a MailClaw inbox API | `brew install owo-network/brew/mailclaw` |
| [rdap](https://github.com/xtomcom/rdap) | A command-line RDAP client for querying domain, IP, and ASN information | `brew install owo-network/brew/rdap` |
| [speedtest-rust](https://github.com/missuo/speedtest-rust) | Speedtest CLI powered by Apple CDN, written in Rust | `brew install owo-network/brew/speedtest-rust` |
| [us-visa](https://github.com/missuo/USVisaWaitTimes) | A tool for checking US visa wait times | `brew install owo-network/brew/us-visa` |
| [xpost](https://github.com/missuo/xpost) | A command-line tool and HTTP API for posting to X (Twitter) | `brew install owo-network/brew/xpost` |

## Uninstall
```shell
brew uninstall [NAME]
```
## Untap
```shell
brew untap owo-network/brew
```

## Author
**homebrew-brew** © [OwO Network Limited](https://github.com/OwO-Network), Released under the [GPL-3.0](./LICENSE) License.<br>
