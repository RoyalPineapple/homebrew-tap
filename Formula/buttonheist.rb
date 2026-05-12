class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.26"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.26/buttonheist-0.2.26-macos.tar.gz"
  sha256 "e9176243cd0548f35e082208755e7228f9e68b324d37568bb0f4fa4cae1cd6ad"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.26/buttonheist-mcp-0.2.26-macos.tar.gz"
    sha256 "e8644256ee11bdea9326575e45e191154ec4e67ef49c676ce64a217ff1ba2859"
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
