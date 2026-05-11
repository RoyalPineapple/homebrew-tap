class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.24"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.24/buttonheist-0.2.24-macos.tar.gz"
  sha256 "c42daaded2548dbdb3bff914eb3736ae4d867fa53864be812f0b337a04b44e3f"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.24/buttonheist-mcp-0.2.24-macos.tar.gz"
    sha256 "eeb184454fb814e9b25fc3671737ec8c5e905f5928247e5585c4c28775e2d9d8"
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
