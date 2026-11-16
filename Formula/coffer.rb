class Coffer < Formula
  desc "End-to-end encrypted credentials for you and your AI agents"
  homepage "https://github.com/missuo/coffer-releases"
  version "0.2.0"
  license "MIT"

  on_macos do
    url "https://github.com/missuo/coffer-releases/releases/download/v0.2.0/coffer-0.2.0-macos-universal.tar.gz"
    sha256 "f70ded5919870a1b3b4895368d6ad370059a7dd5c3ed00b68bf6bac0205ca50d"
  end

  on_linux do
    on_intel do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.0/coffer-0.2.0-linux-x86_64.tar.gz"
      sha256 "0296b5320525ad779304eaa1ce3992a6c705cded6ce3abbf3d7a01e40d9edb2e"
    end
    on_arm do
      url "https://github.com/missuo/coffer-releases/releases/download/v0.2.0/coffer-0.2.0-linux-aarch64.tar.gz"
      sha256 "402948043cdbd73374d7df7fa78698d2803b844d41ecef5379805b4275b80a4c"
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
