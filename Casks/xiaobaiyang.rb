cask "xiaobaiyang" do
    version "3.10.25"
    arch = Hardware::CPU.arch.to_s
    sha256s = {
      "x86_64" => "1d9102a4384b5e3c68951410f4bb1c4bf905179c8b8b48e4bea32dc54b9b1ec1",
      "aarch64" => "29d8135c1c8e754d0c17349dcc1714f35259be78e51f18dde95e08166dab30c6"
    }
    if arch == "arm64" then arch = "aarch64" end
    url "https://github.com/missuo/AliyunPanMac/releases/download/v#{version}/AliyunPan-v#{version}-#{arch}.dmg"
    sha256 sha256s[arch]
    name 'xiaobaiyang'
    homepage 'https://github.com/missuo/AliyunPanMac/'

    app "阿里云盘.app"
  end
  