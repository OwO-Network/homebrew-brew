class Rdap < Formula
  desc "A command-line RDAP client for querying domain, IP, and ASN information"
  homepage "https://github.com/xtomcom/rdap"
  version "1.0.4"
  if Hardware::CPU.arm?
    url "https://github.com/xtomcom/rdap/releases/download/v#{version}/rdap-#{version}-macos-aarch64"
    sha256 "cd35cb12fff53170c30b6d905dddfbb62071535237539ba9a6ccc135a870ceba"
    sha256 "26c9c4246c9deb64d5833b68e5d0b7d1ee0585f5250b869491065ebeeb86897a"
    url "https://github.com/xtomcom/rdap/releases/download/v#{version}/rdap-#{version}-macos-x86_64"
    sha256 "ec1c0a81d1561e146d05019010f3c6ac06613c0f155c6d63e0d90b83de284717"
    sha256 "f131a55c90a56b5367ded781c9feb01f345bcd8644d82cee05acbd37abb77b9d"
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "rdap-#{version}-macos-aarch64" => "rdap"
    else
      bin.install "rdap-#{version}-macos-x86_64" => "rdap"
    end
  end

  test do
    system "#{bin}/rdap", "--help"
  end
end
