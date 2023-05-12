class USVisa < Formula
    desc "A tool for checking US visa wait times"
    homepage "https://github.com/missuo/USVisaWaitTimes"
    version "0.0.1"
    if Hardware::CPU.arm?
        url "https://github.com/missuo/USVisaWaitTimes/releases/download/v#{version}/us-visa_darwin_arm64"
        sha256 "1764cd97a121231c180e2f85563e96537521377650bf3f311f37cf9e84060d99"
      else
        url "https://github.com/missuo/USVisaWaitTimes/releases/download/v#{version}/us-visa_darwin_amd64"
        sha256 "fe352e9ad73a630dab5ddec3ab806fc8d3af68786f5afeceea49c44702a32ed6"
      end
    
      def install
        binary_name = if Hardware::CPU.arm?
          "us-visa_darwin_arm64"
        else
          "us-visa_darwin_amd64"
        end
    
        bin.install binary_name => "us-visa"
      end
  end
  