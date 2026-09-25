class Awsipranges < Formula
  desc "Quickly query the AWS IP Ranges"
  homepage "https://github.com/cmlccie/awsipranges"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.9.0/awsipranges-aarch64-apple-darwin.tar.xz"
      sha256 "b2e3cdb51ecfd5c82d56aec267fb075322fae3f982119a32875faaa979dbec27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.9.0/awsipranges-x86_64-apple-darwin.tar.xz"
      sha256 "0e13bc8415b56e23e9dea3add8a1715a80e92504ae9d573d92a92afe33c1f2d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.9.0/awsipranges-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4de18140536b266aa609fa13ddedd48c5976aa1c9dea3841d0392d8cdeb91b9b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.9.0/awsipranges-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba6c15cb5e1ba85290fbd525b4197a68be53f6ad892597b634b5797380ef057f"
    end
  end
  license "BSD-2-Clause-Patent"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
    if OS.linux? && Hardware::CPU.arm?
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
