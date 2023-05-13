cask "alixby" do
    version "3.10.26"
    arch = Hardware::CPU.arch.to_s
    sha256s = {
      "x86_64" => "d55d1a7bd4b43feebf84f5e10147f951f8268b4a88f242f9ddeb1106a03d6b8d",
      "aarch64" => "e8357915856f77c18f77131b77892a7fd24ec6ac5bce8ca889ab3d5a15a852b9"
    }
    if arch == "arm64" then arch = "aarch64" end
    url "https://github.com/missuo/AliyunPanMac/releases/download/v#{version}/AliyunPan-v#{version}-#{arch}.dmg"
    sha256 sha256s[arch]
    name 'alixby'
    homepage 'https://github.com/missuo/AliyunPanMac'

    app "alixby.app"

    postflight do
    system_command '/bin/chmod', args: ['+x', "#{appdir}/alixby.app/Contents/Resources/engine/aria2c"]
    end
  end
  