class Coffer < Formula
  desc "A simple, fast, and secure key-value store"
  homepage "https://github.com/missuo/coffer"
  version ""
  if Hardware::CPU.arm?
    url "https://github.com/missuo/coffer/releases/download/v#{version}/coffer-aarch64-apple-darwin"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  else
    url "https://github.com/missuo/coffer/releases/download/v#{version}/coffer-x86_64-apple-darwin"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  end
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "coffer-aarch64-apple-darwin" => "coffer"
    else
      bin.install "coffer-x86_64-apple-darwin" => "coffer"
    end
  end

  test do
    system "#{bin}/coffer", "--help"
  end
end
