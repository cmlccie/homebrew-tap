class Awsipranges < Formula
  desc "Quickly query the AWS IP Ranges"
  homepage "https://github.com/cmlccie/awsipranges"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.6.0/awsipranges-aarch64-apple-darwin.tar.xz"
      sha256 "ec6ae856a49d15f9c4503d7594890e70ca36c97baf8a8cf8a934b646c4eb7528"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.6.0/awsipranges-x86_64-apple-darwin.tar.xz"
      sha256 "60685e2a28348b9ffa84b36edeacf9c875e87c67a6ab176ad659867f3bb9bc1f"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.6.0/awsipranges-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad2c8d8aa1e22c74dd30b6ec5456352ab340b0f4543325d7d2df7b85c1d0e942"
    end
  end
  license "BSD-2-Clause-Patent"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
