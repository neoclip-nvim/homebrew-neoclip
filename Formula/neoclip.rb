class Neoclip < Formula
  desc "Neovim multi-platform clipboard provider."
  homepage "https://github.com/matveyt/neoclip"
  # TODO add version
  license "Unlicense"
  head "https://github.com/matveyt/neoclip.git"

  keg_only "neovim plugin"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "libffi" => :build
  depends_on "pkg-config" => :build
  depends_on "luajit" => :build
  on_linux do
    depends_on "wayland" => :build
    depends_on "wayland-protocols" => :build # it may be redundant
    depends_on "libx11" => :build
  end

  def install
    system "cmake", "-S", "src", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build", "--strip"

    prefix.install "lua"
  end

  test do
    # TODO run neovim +checkhealth
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test neoclip`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
