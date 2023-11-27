class Deeplx < Formula
  desc "DeepLX is an permanently free DeepL API written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "0.8.6"
  
  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "ae461ed36d6f384e8e0a19cb27f4e45a128229d77a7b47f94a1811f17de74f07"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "1f5930851475299d01935fd2e8d880c81f5f6fdea3f0bb55df7239e7667e9106"
  end

  depends_on "daemon"

  def install
    bin.install Dir["deeplx_*"].first => "deeplx"
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/deeplx</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>WorkingDirectory</key>
        <string>#{var}/run/deeplx</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/deeplx/deeplx.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/deeplx/deeplx.log</string>
      </dict>
      </plist>
    EOS
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

  test do
    system "#{bin}/deeplx", "--version"
  end
end



