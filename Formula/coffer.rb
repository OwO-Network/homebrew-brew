class Coffer < Formula
  desc "End-to-end encrypted credentials for you and your AI agents"
  homepage "https://github.com/missuo/coffer-releases"
  version "0.2.3"
  license "MIT"

  on_macos do
    url "https://github.com/missuo/coffer-releases/releases/download/v0.2.3/coffer-0.2.3-macos-universal.tar.gz"
    sha256 "8828bbd855c4566d711de410a24fa6f49750e0e2061da23cbd950b7f0adaf704"
  end

  on_linux do
    on_intel do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.3/coffer-0.2.3-linux-x86_64.tar.gz"
      sha256 "cab14a3463370f2079089125034f4cb0e62f294dcf009821357bb4e49419c02a"
    end
    on_arm do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.3/coffer-0.2.3-linux-aarch64.tar.gz"
      sha256 "46cceb3346a93928d886a2d4834aee499f9183ab0d9a4c54c2087ba9dcf60a26"
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
