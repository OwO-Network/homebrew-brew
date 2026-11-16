class Coffer < Formula
  desc "End-to-end encrypted credentials for you and your AI agents"
  homepage "https://github.com/missuo/coffer-releases"
  version "0.2.2"
  license "MIT"

  on_macos do
    url "https://github.com/missuo/coffer-releases/releases/download/v0.2.2/coffer-0.2.2-macos-universal.tar.gz"
    sha256 "e30d1a783399297fe4e4c52da4b707f88f7e86093f089ee5d4c31fb09566a964"
  end

  on_linux do
    on_intel do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.2/coffer-0.2.2-linux-x86_64.tar.gz"
      sha256 "b1cacb8d3956bc7b3303e3994c4871c036915ab2ae31aacb3e847fc752c29301"
    end
    on_arm do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.2/coffer-0.2.2-linux-aarch64.tar.gz"
      sha256 "efa86c824bf92fe1ec6c45585889ec8c30ef414003e20752015638cc2fad3b42"
    end
  end

  def install
    bin.install "coffer"
  end

  def caveats
    <<~EOS
      First Mac:      coffer setup --server https://<your coffer-sync worker>
      Other devices:  coffer device register --server https://<your coffer-sync worker>
                      (Linux: add --role remote)
      AI agents:      coffer skill install
                      claude mcp add coffer -- #{opt_bin}/coffer mcp
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coffer --version")
  end
end
