class Neoclip < Formula
  desc "Neovim multi-platform clipboard provider"
  homepage "https://github.com/matveyt/neoclip"
  url "https://github.com/matveyt/neoclip/archive/adfb1430c7308f0b3036f89b037509b3d0b4610a.tar.gz"
  version "2024.08.23.1"
  sha256 "944b6b00a0e5c3d497d09d25c7d4c75bd04ddfcba2e85abf6309c94f3434591b"
  license "Unlicense"
  head "https://github.com/matveyt/neoclip.git", branch: "master"

  keg_only "it is a neovim plugin"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "libffi" => :build
  depends_on "luajit" => :build
  depends_on "pkg-config" => :build
  depends_on "nvim" => :test
  on_linux do
    depends_on "libx11" => :build
    depends_on "wayland" => :build
    depends_on "wayland-protocols" => :build # it may be redundant
  end

  def install
    system "cmake", "-S", "src", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build", "--strip"

    prefix.install "lua"
  end

  # Test requires either x11 or wayoand or macosx
  test do
    health = "health.log"
    system "nvim", "--headless",
      # set up
      "+set rtp+=#{prefix}",
      "+lua require('neoclip'):setup()",
      # execute
      "'+checkhealth neoclip'", "+w!#{health}", "+qa"

    # uncomment to debug
    # system "cat", health

    # check expectations
    system "grep", "OK", health
    system "grep", "-v", "FAIL", health

    # cleanup
    rm health
  end
end
