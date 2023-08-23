# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GitBranchDeleteMerged < Formula
  desc "Delete local branches that have been merged (includes \"Squash and merge\")"
  homepage "https://github.com/nekonenene/git-branch-delete-merged-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nekonenene/git-branch-delete-merged-rs/releases/download/v1.0.1/git-branch-delete-merged-Darwin-arm64"
      sha256 "e0af9bbd94a530377c932860289af2d570339fc26fcb3a2b86b38ccd7924660e"
    elsif Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/nekonenene/git-branch-delete-merged-rs/releases/download/v1.0.1/git-branch-delete-merged-Darwin-x86_64"
      sha256 "4782dc42eac66a0a687a470479a27a7b21162deff5d8903d5bbbdcfae55d8e6a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nekonenene/git-branch-delete-merged-rs/releases/download/v1.0.1/git-branch-delete-merged-Linux-arm64"
      sha256 "54bedf6e6b1ac2d43a93706bada5ebd78e61b043f6c94fa274e5ef858d337d51"
    elsif Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/nekonenene/git-branch-delete-merged-rs/releases/download/v1.0.1/git-branch-delete-merged-Linux-x86_64"
      sha256 "325890012b989393a5974974692fbe59b93f3d615debb5400ce0731015dfc93a"
    end
  end

  head do
    url "https://github.com/nekonenene/git-branch-delete-merged-rs.git", branch: "main"
    depends_on "rust" => :build
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cargo", "install", *std_cargo_args if build.head?

    bin.install Dir["output/*"]
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
    system "#{bin}/git-branch-delete-merged --version"
  end
end
