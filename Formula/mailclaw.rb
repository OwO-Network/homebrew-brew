class Mailclaw < Formula
  desc "CLI for interacting with a MailClaw inbox API"
  homepage "https://github.com/missuo/mailclaw"
  version "1.0.1"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-aarch64-apple-darwin"
    sha256 "851e407942ae856358876a1886f99b07873fd0866207f1c2bc2ff55659a76fde"
  else
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-x86_64-apple-darwin"
    sha256 "f6dc6b3676a39b49f640cf58ed9cef90a1080ec93236906104ec5d0a08e139e5"
  end
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "mailclaw-v#{version}-aarch64-apple-darwin" => "mailclaw"
    else
      bin.install "mailclaw-v#{version}-x86_64-apple-darwin" => "mailclaw"
    end
  end

  test do
    system "#{bin}/mailclaw", "--help"
  end
end
