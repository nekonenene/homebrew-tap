# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
require_relative "../configs/config_provider"

class GitBranchDeleteMerged < Formula
  package_name = "git-branch-delete-merged"
  config = ConfigProvider.new(package_name)

  desc "Delete local branches that have been merged (includes \"Squash and merge\")"
  homepage config.github_url
  license "MIT"

  on_macos do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url    config.mac["arm64"]["url"]
      sha256 config.mac["arm64"]["sha256"]
    elsif Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url    config.mac["x86_64"]["url"]
      sha256 config.mac["x86_64"]["sha256"]
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url    config.linux["arm64"]["url"]
      sha256 config.linux["arm64"]["sha256"]
    elsif Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url    config.linux["x86_64"]["url"]
      sha256 config.linux["x86_64"]["sha256"]
    end
  end

  head do
    url "#{config.github_url}.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      system("mv git-branch-delete-merged* git-branch-delete-merged")
      bin.install "git-branch-delete-merged"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test git-branch-delete-merged`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/#{package_name} --version"
  end
end
