class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.02"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v#{version}/buttonheist-#{version}-macos.tar.gz"
  sha256 "ed53651c9215088e2b0f23d6c03a00a6f18503860715cb53517bce389cc0efb5"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v#{version}/buttonheist-mcp-#{version}-macos.tar.gz"
    sha256 "7d6dc11c8445ae227f0f85d23c96fd69161227be32e2cd97d09f87ce7f4d8fcb"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
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
