class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DLX"
  version "1.2.5"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "afb270c6fc76bc46572fc7671bf23060ea15bde08a16b40922bb2e981619a362"
  else
    url "https://github.com/OwO-Network/DLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "8c9d28d951ea615ae988d4d01453f2b51f08530800214b1b58f6d1622b4bba74"
  end

  def install
    bin.install Dir["deeplx_*"].first => "deeplx"
    (var/"deeplx").mkpath
    (var/"log").mkpath
  end

  def uninstall
    system "brew", "services", "stop", "#{name}" if (var/"log/deeplx.log").exist?
    (var/"log/deeplx.log").unlink if (var/"log/deeplx.log").exist?
    (var/"deeplx").rmtree if (var/"deeplx").exist?
    super
  end

  def post_uninstall
    system "rm", "-rf", "/opt/homebrew/etc/deeplx"
  end

  service do
    run [opt_bin/"deeplx"]
    working_dir var/"deeplx"
    keep_alive true
    log_path var/"log/deeplx.log"
    error_log_path var/"log/deeplx.log"
  end
  
  test do
    system "#{bin}/deeplx", "--version"
  end
end
