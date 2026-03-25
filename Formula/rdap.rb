class Rdap < Formula
  desc "A command-line RDAP client for querying domain, IP, and ASN information"
  homepage "https://github.com/xtomcom/rdap"
  version "1.0.6"
  if Hardware::CPU.arm?
    url "https://github.com/xtomcom/rdap/releases/download/v#{version}/rdap-#{version}-macos-aarch64"
    sha256 "cd35cb12fff53170c30b6d905dddfbb62071535237539ba9a6ccc135a870ceba"
    sha256 "32a013cb10f99324919b9ecb5dea9aa00f66ffe40da3e9286fea64710332e73f"
    url "https://github.com/xtomcom/rdap/releases/download/v#{version}/rdap-#{version}-macos-x86_64"
    sha256 "ec1c0a81d1561e146d05019010f3c6ac06613c0f155c6d63e0d90b83de284717"
    sha256 "8077ac93e4b1d728258c1d1b381598a1a38dff88543ca3dc636c3d4b4660b206"
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
