cask "alixby" do
    version "3.10.25"
    arch = Hardware::CPU.arch.to_s
    sha256s = {
      "x86_64" => "245c8afa6c850e4359b27cd11233ccd137e023c74cf7cb294ba26056049527ee",
      "aarch64" => "4d4cb73d89bc04165e585b39a6818f02d691858571d16ee8df81400b74873d75"
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
  