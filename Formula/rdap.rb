class Rdap < Formula
  desc "A command-line RDAP client for querying domain, IP, and ASN information"
  homepage "https://github.com/xtomcom/rdap"
  version "1.0.9"
  license "MIT"

  if Hardware::CPU.arm?
    sha256 "b98aa974d8e40ae9b6848326536bbae2c69f8d896d6753d6f6c64d5964df4fb7"
    sha256 "32a013cb10f99324919b9ecb5dea9aa00f66ffe40da3e9286fea64710332e73f"
  else
    sha256 "04826fbcc881170607e6afc07fb22c64a9b4c770b2050fe34ba87eb07f05fccb"
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
