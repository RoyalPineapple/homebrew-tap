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
  version "0.5.5"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.5.5/buttonheist-0.5.5-macos.tar.gz"
  sha256 "c5228d86bf4da9e1ebad832c0509c8df793619b2bcf4ccfff9c23f0f94b34ca4"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.5.5/buttonheist-mcp-0.5.5-macos.tar.gz"
    sha256 "20555dba14455e88f20b0b22fe0a370d10624643a0826beed0182604c49a474c"
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
