# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GitBranchDeleteMergedGo < Formula
  desc "Delete local branches that have been merged (includes \"Squash and merge\")"
  homepage "https://github.com/nekonenene/git-branch-delete-merged"
  url "https://github.com/nekonenene/git-branch-delete-merged/archive/refs/tags/v1.3.5.tar.gz"
  sha256 "60a2f2d7307ce96c7249bf306c3ce0e526a51ecf156259593cdb599f4c9166a2"
  license "MIT"

  depends_on "go" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test git-branch-delete-merged-go`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/git-branch-delete-merged --version"
  end
end
