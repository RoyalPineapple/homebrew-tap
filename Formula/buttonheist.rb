# Homebrew formula for Button Heist CLI + MCP server.
#
# Formula shape lives here. Release artifact names and repository constants
# live in scripts/release-contract.sh. The release workflow renders this into
# RoyalPineapple/homebrew-tap with real SHA-256 values.
#
# Users install with:
#   brew install RoyalPineapple/tap/buttonheist

class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.6.11"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.6.11/buttonheist-0.6.11-macos.tar.gz"
  sha256 "09e4f6c9002473a6a997ce88c6139bf5a8f4fb83b228d52ba4f54607edb6b43a"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.6.11/buttonheist-mcp-0.6.11-macos.tar.gz"
    sha256 "30d9ec3097e72f80d05ea6bacf8de12bff30025cb949e1d03a3804dd6756e8a1"
  end

  depends_on :macos
  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install "buttonheist"
    bin.install "heist-plan" if (buildpath/"heist-plan").exist?
    lib.install "ThePlans" if (buildpath/"ThePlans").exist?
    resource("mcp").stage { bin.install "buttonheist-mcp" }
  end

  def caveats
    <<~EOS
      MCP server is installed at:
        #{opt_bin}/buttonheist-mcp

      Add to your project's .mcp.json:
        {
          "mcpServers": {
            "buttonheist": {
              "command": "#{opt_bin}/buttonheist-mcp",
              "args": []
            }
          }
        }
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/buttonheist --version")
    assert_predicate bin/"heist-plan", :exist?
    assert_predicate bin/"buttonheist-mcp", :exist?
    assert_predicate bin/"buttonheist-mcp", :executable?
    assert_predicate lib/"ThePlans/arm64-apple-macosx/release/Modules/ThePlans.swiftinterface", :exist?
    refute_predicate lib/"ThePlans/arm64-apple-macosx/release/Modules/ThePlans.swiftmodule", :exist?
    assert_predicate lib/"ThePlans/arm64-apple-macosx/release/description.json", :exist?
  end
end
