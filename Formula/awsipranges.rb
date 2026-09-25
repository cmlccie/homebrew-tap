class Awsipranges < Formula
  desc "Quickly query the AWS IP Ranges"
  homepage "https://github.com/cmlccie/awsipranges"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.8.1/awsipranges-aarch64-apple-darwin.tar.xz"
      sha256 "343a9cc06bf81fcece7a78078e8f986aa435f5a03c8f6ac408edcb338be0ce74"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.8.1/awsipranges-x86_64-apple-darwin.tar.xz"
      sha256 "004c0729a1de53920ee7c17c4ae84618e967fbfb458053e052f69306c456c682"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.8.1/awsipranges-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1c39ab0fa4298f3fa767e91f41c4d2e45d7fda3dfd3521910d961082e6caae49"
    end
  end
  license "BSD-2-Clause-Patent"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "awsipranges"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "awsipranges"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "awsipranges"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
