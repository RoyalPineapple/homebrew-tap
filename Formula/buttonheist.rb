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
  version "0.4.0"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.4.0/buttonheist-0.4.0-macos.tar.gz"
  sha256 "42d6a25b2e7f0aaaaa1594f62c9ebcb260d574cd1c3e8ea7a81ebc0081bd57fb"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.4.0/buttonheist-mcp-0.4.0-macos.tar.gz"
    sha256 "ddb0a7aac9b833afffb1381a43205934c5ae968afb798a1017894525262ce4f4"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    bin.install "ButtonHeistFrameworks" if (buildpath/"ButtonHeistFrameworks").exist?
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
  end
end
