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

  depends_on "nvim" => :test

  # Test requires either x11 or wayoand or macosx
  test do
    health = 'health.log'
    system "nvim", "--headless",
      # set up
      "+set\ rtp+=#{prefix}",
      "+lua\ require('neoclip'):setup()",
      # execute
      "'+checkhealth neoclip'", "+w!#{health}", "+qa"

    # uncomment to debug
    # system "cat", health

    # check expectations
    system "grep", "OK", health
    system "grep", "-v", "FAIL", health

    # cleanup
    system "rm", health
  end
end
