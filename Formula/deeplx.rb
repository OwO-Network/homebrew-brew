class Deeplx < Formula
  desc "DeepLX is an permanently free DeepL API written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "0.8.8"
  
  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "dd2a8fe14a5833301f88d27821a1e9d4348ee0c7d71f7bbe1d134cf34e005c32"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "8fb5eac72356151f7c45bb61e74d722b6fb67134201757e7948740d36b41d482"
  end

  depends_on "daemon"

  def install
    bin.install Dir["deeplx_*"].first => "deeplx"
  end

  def post_install
    (var/"log/deeplx").mkpath
    (var/"run/deeplx").mkpath
    (etc/"deeplx/plugins").mkpath
    install_startup_script
  end

  def uninstall
    post_uninstall
    super
  end

  def post_uninstall
    system "#{HOMEBREW_PREFIX}/bin/brew", "services", "stop", "deeplx"
    (etc/"rc.d/deeplx").unlink if (etc/"rc.d/deeplx").exist?
  end

  def caveats
    <<~EOS
      To start deeplx manually, run:
        sudo deeplx start

      To stop deeplx manually, run:
        sudo deeplx stop

      To restart deeplx manually, run:
        sudo deeplx restart

      To start deeplx automatically at login, copy and paste the following command:
        sudo cp -fv #{etc}/rc.d/deeplx /etc/rc.d/
    EOS
  end

  service do
    name macos: "#{plist_name}"
  end
      
  test do
    system "#{bin}/deeplx", "--version"
  end
end
