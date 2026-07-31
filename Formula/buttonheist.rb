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
  version "0.6.33"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.6.33/buttonheist-0.6.33-macos.tar.gz"
  sha256 "7bc68573c8095f272ee0d3c0c4824432bb60ef6d8bf03d8675ca346e28506ebc"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.6.33/buttonheist-mcp-0.6.33-macos.tar.gz"
    sha256 "b611516fa0e3c1768fded632f2bfcd5f11539efb9c3e4ee4852e341f50c3ceaa"
  end

  depends_on :macos
  on_macos do
    depends_on macos: :sonoma
  end
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
