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
  version "0.5.8"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.5.8/buttonheist-0.5.8-macos.tar.gz"
  sha256 "fdc976ba207abd8300ff2e3a34f3fc927f0fa75054a0e5f0d626e9d263037f9e"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.5.8/buttonheist-mcp-0.5.8-macos.tar.gz"
    sha256 "48106d4ba384030b88abede29fb7d115e508058a0b62f5ff0382b364a76e65ca"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    bin.install "heist-plan" if (buildpath/"heist-plan").exist?
    bin.install "ButtonHeistFrameworks" if (buildpath/"ButtonHeistFrameworks").exist?
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
    assert_predicate lib/"ThePlans/arm64-apple-macosx/release/Modules/ThePlans.swiftinterface", :exist?
    refute_predicate lib/"ThePlans/arm64-apple-macosx/release/Modules/ThePlans.swiftmodule", :exist?
    assert_predicate lib/"ThePlans/arm64-apple-macosx/release/description.json", :exist?
  end
end
