class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "0.8.8"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "dd2a8fe14a5833301f88d27821a1e9d4348ee0c7d71f7bbe1d134cf34e005c32"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "8fb5eac72356151f7c45bb61e74d722b6fb67134201757e7948740d36b41d482"
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

def plist
  <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/deeplx</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardErrorPath</key>
      <string>#{var}/log/deeplx.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/deeplx.log</string>
    </dict>
    </plist>
  XML
end

  def caveats
    <<~EOS
      To start, stop, or restart deeplx using brew services, run:
        brew services start deeplx
        brew services stop deeplx
        brew services restart deeplx
    EOS
  end

  service do
    name macos: "#{plist_name}"
  end

  test do
    system "#{bin}/deeplx", "--version"
  end
end
