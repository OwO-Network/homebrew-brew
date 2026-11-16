class Coffer < Formula
  desc "End-to-end encrypted credentials for you and your AI agents"
  homepage "https://github.com/missuo/coffer-releases"
  version "0.2.1"
  license "MIT"

  on_macos do
    url "https://github.com/missuo/coffer-releases/releases/download/v0.2.1/coffer-0.2.1-macos-universal.tar.gz"
    sha256 "61fc1818007dc0578ef3560f495b3b8a04b54f81e4becc72811cb8d0aef714f1"
  end

  on_linux do
    on_intel do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.1/coffer-0.2.1-linux-x86_64.tar.gz"
      sha256 "46b170abcb29771ab1e18c713ae4bfd89e41ae876d5ee3a64458e7d8d4d07bac"
    end
    on_arm do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.1/coffer-0.2.1-linux-aarch64.tar.gz"
      sha256 "a94d95c8682b1d4255b8f416fa0579caf406c5a998e60fb4e2ec254a3b82e0ea"
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
