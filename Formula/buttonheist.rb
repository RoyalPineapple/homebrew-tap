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
  version "0.6.18"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.6.18/buttonheist-0.6.18-macos.tar.gz"
  sha256 "36bc2aafa021f5f7cf290e4a6a6def8490e4cb26c2aeeb8453d690e74055186d"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.6.18/buttonheist-mcp-0.6.18-macos.tar.gz"
    sha256 "e0c35a1dd59c09709d8984ded68fd10bdbe141bb9ee6f54c51c6c583d69d98fe"
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
