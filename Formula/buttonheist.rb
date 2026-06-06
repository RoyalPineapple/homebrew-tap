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
  version "0.5.2"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.5.2/buttonheist-0.5.2-macos.tar.gz"
  sha256 "5513afc2f394fd2edf850269d5018a5f6ebe527f8a569e1ed040f70a8c11cfef"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.5.2/buttonheist-mcp-0.5.2-macos.tar.gz"
    sha256 "df0c089b248af8a71cd71d4f03e06ab4aa0fa7ac0ecf2388b5511777597500c3"
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
