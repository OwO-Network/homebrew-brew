class NexttraceEnhanced < Formula
    desc "一款开源的可视化路由跟踪工具，使用 Golang 开发。\n这是NextTrace加强版，旨在提供高度可定制化的可视化 Traceroute 工具。"
    homepage "https://github.com/OwO-Network/nexttrace-enhanced/"
    version "v0.3.1-beta.3"
    url "https://github.com/OwO-Network/nexttrace-enhanced/archive/refs/tags/v0.3.1-beta.3.tar.gz"
    sha256 "e50f576c56089fb6f17008e6694a7115199d314d76cbc64580730ab09fd14e45"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/OwO-Network/nexttrace-enhanced/printer.version=v0.3.1-beta.3' -s -w")
    end
  end
