class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "1.1.0"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "28b6b61b000de42f073ecbb4a0a0e9be64ff7fcdbff8e9f7ee0b057e2ac0e5f5"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "254730c77208111a14feb2e42f7fad64ed4cd02a24ec3cfdc1fc801ef84b38bc"
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
