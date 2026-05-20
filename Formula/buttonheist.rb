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
  version "0.4.1"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.4.1/buttonheist-0.4.1-macos.tar.gz"
  sha256 "c179f630246ba658c06fc9463a962cc4fdd81bde17924eb44c384a96dde00045"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.4.1/buttonheist-mcp-0.4.1-macos.tar.gz"
    sha256 "6a84f0660b97898419d5d412ec118cf5bd2dddfeeacc5ee2ec3d7519ade251c6"
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
