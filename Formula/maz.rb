class Maz < Formula
  desc "Local-first system of records for the era of agents"
  homepage "https://github.com/mo-cmyk/mazarbul"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.1.0/mazarbul_v0.1.0_darwin_arm64.tar.gz"
      sha256 "7f3e20add2a779fdc3940b1033e9dde39c72a23b476c950af78da0f89b938d6a"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.1.0/mazarbul_v0.1.0_darwin_amd64.tar.gz"
      sha256 "def6490c363a8a11fa9fb7d932cabda201644040747916cb049f02300a02df1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.1.0/mazarbul_v0.1.0_linux_arm64.tar.gz"
      sha256 "a1772a082b075010f2b28f1c0be1b56c7fdb1eaadb378f69ace7aaefbb7ee309"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.1.0/mazarbul_v0.1.0_linux_amd64.tar.gz"
      sha256 "3bba48a60f64994f45df6f9cb799372faf0b3155139a239d58c49dc43de42195"
    end
  end

  def install
    # maz resolves its bundled LadybugDB engine via @loader_path/../lib
    # ($ORIGIN/../lib on Linux), so the lib must sit beside bin/.
    bin.install "maz"
    lib.install Dir["lib/*"]
    man1.install Dir["man/man1/*.1"]
    bash_completion.install "completions/maz.bash" => "maz"
    zsh_completion.install "completions/maz.zsh" => "_maz"
    fish_completion.install "completions/maz.fish"
  end

  def caveats
    <<~EOS
      maz needs a model provider. For local models:
        brew install ollama && ollama serve
        maz init
      Or use a hosted provider:
        maz init --provider anthropic --api-key ...
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/maz --version")
  end
end
