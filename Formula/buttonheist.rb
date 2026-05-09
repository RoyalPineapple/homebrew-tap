class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.22"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.22/buttonheist-0.2.22-macos.tar.gz"
  sha256 "4fb3d520ab96b8e0d2beac258aed37f13ba19a00bdb9655bfd1684a0e8580500"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.22/buttonheist-mcp-0.2.22-macos.tar.gz"
    sha256 "189b6c472154b59103760024f8b22615b428340969e018186b62cc1f09ef3fe6"
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
