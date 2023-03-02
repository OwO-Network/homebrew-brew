class Deeplx < Formula
  desc "DeepLX is an permanently free DeepL API written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "0.7.3"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "ca09e0871aa94f548778a65a40a9b9f2b7e73b73296b4d4ca4c62e6d65aaee47"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "77c7e3d3b2c7a9429a9a7e6d07206a0a0a96d8c5f3fa3df0cc45217fc9540a9e"
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
          <string>--server-port</string>
          <string>8080</string>
          <string>--server-endpoint</string>
          <string>/chat</string>
          <string>--logging-level</string>
          <string>info</string>
          <string>--logging-file</string>
          <string>#{var}/log/deeplx/deeplx.log</string>
          <string>--storage-dbfile</string>
          <string>#{var}/run/deeplx/deeplx.db</string>
          <string>--model-file</string>
          <string>#{etc}/deeplx/model.bin</string>
          <string>--plugins-dir</string>
          <string>#{etc}/deeplx/plugins</string>
          <string>--security-secret-key</string>
          <string>secret</string>
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
    (etc/"deeplx").mkpath
    unless (etc/"deeplx/model.bin").exist?
      ohai "Copying default model"
      system "curl", "-L", "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/model.bin", "-o", "#{etc}/deeplx/model.bin"
    end
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
      The default configuration assumes that the model file is located at #{etc}/deeplx/model.bin
      and that plugins are located in #{etc}/deeplx/plugins.
      You can change these settings by modifying the plist file at #{plist_path}.

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



