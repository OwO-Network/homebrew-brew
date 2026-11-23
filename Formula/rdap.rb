class Rdap < Formula
  desc "A command-line RDAP client for querying domain, IP, and ASN information"
  homepage "https://github.com/xtomcom/rdap"
  version "1.1.1"
  license "MIT"

  if Hardware::CPU.arm?
    sha256 "4e4bc636c680b3c01e0f60d2c8e5004037edd523beae3fa7fd550c0ac4da7e5f"
    sha256 "32a013cb10f99324919b9ecb5dea9aa00f66ffe40da3e9286fea64710332e73f"
  else
    sha256 "b7169fcad7b1e8a7b65ad4f1b944ca724bdb65eafb52340b9e274517ab0dc1f1"
    sha256 "ec1c0a81d1561e146d05019010f3c6ac06613c0f155c6d63e0d90b83de284717"
  end

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
