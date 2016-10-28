class Goenv < Formula
  desc "Like pyenv and rbenv, but for Go."
  homepage "https://github.com/syndbg/goenv"
  url "https://github.com/syndbg/goenv/archive/v20160814.tar.gz"
  sha256 "715af41eb25b4f4f7c41df002e8e508f29fbe90a8dc7b566198098ca47a1d640"
  head "https://github.com/syndbg/goenv.git"

  bottle :unneeded

  def install
    inreplace "libexec/goenv", "/usr/local", HOMEBREW_PREFIX
    prefix.install Dir["*"]
    %w[goenv-install goenv-uninstall go-build].each do |cmd|
      bin.install_symlink "#{prefix}/plugins/go-build/bin/#{cmd}"
    end
  end

  def caveats; <<-EOS.undent
    To use Homebrew's directories rather than ~/.goenv add to your profile:
      export GOENV_ROOT=#{var}/goenv

    To enable shims and autocompletion add to your profile:
      if which goenv > /dev/null; then eval "$(goenv init -)"; fi
    EOS
  end

  test do
    shell_output("eval \"$(#{bin}/goenv init -)\" && goenv versions")
  end
end
