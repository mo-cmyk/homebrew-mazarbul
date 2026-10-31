class Maz < Formula
  desc "Local-first system of records for the era of agents"
  homepage "https://github.com/mo-cmyk/mazarbul"
  version "0.2.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.1/mazarbul_v0.2.1_darwin_arm64.tar.gz"
      sha256 "d924d68349ba18e3b440112c1e9b40a4a24fe32450171010d481bfa349375097"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.1/mazarbul_v0.2.1_darwin_amd64.tar.gz"
      sha256 "86dc864d2c4eb64b8bf715f93ac569e3f4f841e1d7bd6f16cebed01e7f4c2bde"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.1/mazarbul_v0.2.1_linux_arm64.tar.gz"
      sha256 "c77012a7fd9058d213c94ec6db9a7c5ee91f28c14be9c0e35e14dd78b493bdcc"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.1/mazarbul_v0.2.1_linux_amd64.tar.gz"
      sha256 "7bf2906322ef05b01a87e592f61f6e99dafd2d32f3d2215942e15cb9eeb6f773"
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
