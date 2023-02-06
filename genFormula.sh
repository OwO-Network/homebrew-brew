# !/bin/bash
export version="$(curl -s https://api.github.com/repos/owo-network/nexttrace-enhanced/releases/latest | jq ".name")"
url="https://github.com/OwO-Network/nexttrace-enhanced/archive/refs/tags/${version:1:$((${#version} - 1 - 1))}.tar.gz"
sha256="$(curl -sL ${url} | sha256sum | cut -f1 -d' ')"
cat >Formula/nexttrace.rb <<EOF
class Nexttrace < Formula
    desc "一款开源的可视化路由跟踪工具，使用 Golang 开发。\n这是NextTrace加强版，旨在提供高度可定制化的可视化 Traceroute 工具。"
    homepage "https://github.com/OwO-Network/nexttrace-enhanced/"
    version ${version}
    url "${url}"
    sha256 "${sha256}"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/xgadget-lab/nexttrace/printer.version=${version:1:$((${#version} - 1 - 1))}' -s -w")
    end

    def post_install
      puts "---------------------------\n⚠️  请注意nexttrace-enhanced在HomeBrew已由nexttrace重命名为nexttrace-enhanced，\n请使用来更新至最新版本，\n并在安装后通过命令来使用。\n---------------------------\n⚠️  Please be informed that nexttrace-enhanced has been renamed to nexttrace-enhanced in HomeBrew.\nPlease update to the latest version using ,\nand use the  command after installation."
    end
  end
EOF
cat >Formula/nexttrace-enhanced.rb <<EOF
class NexttraceEnhanced < Formula
    desc "一款开源的可视化路由跟踪工具，使用 Golang 开发。\n这是NextTrace加强版，旨在提供高度可定制化的可视化 Traceroute 工具。"
    homepage "https://github.com/OwO-Network/nexttrace-enhanced/"
    version ${version}
    url "${url}"
    sha256 "${sha256}"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/OwO-Network/nexttrace-enhanced/printer.version=${version:1:$((${#version} - 1 - 1))}' -s -w")
    end
  end
EOF
url="https://github.com/OwO-Network/nexttrace-enhanced/archive/refs/heads/main.zip"
sha256="$(curl -sL ${url} | sha256sum | cut -f1 -d' ')"
current=$(date "+%Y-%m-%d %H:%M:%S")
timeStamp=$(date -d "$current" +%s)
currentTimeStamp=$(((timeStamp * 1000 + 10#$(date "+%N") / 1000000) / 1000)) #将current转换为时间戳，精确到秒
version_withoutquo=$currentTimeStamp
cat >Formula/nexttrace-dev.rb <<EOF
class NexttraceDev < Formula
    desc "一款开源的可视化路由跟踪工具，使用 Golang 开发。\n这是NextTrace加强版，旨在提供高度可定制化的可视化 Traceroute 工具。\nDev通道"
    homepage "https://github.com/OwO-Network/nexttrace-enhanced/"
    version "${version_withoutquo}"
    url "${url}"
    sha256 "${sha256}"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/OwO-Network/nexttrace-enhanced/printer.version=${version_withoutquo}' -s -w")
    end
  end
EOF
