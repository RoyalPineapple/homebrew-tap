class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.28"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.28/buttonheist-0.2.28-macos.tar.gz"
  sha256 "9f153fb3c65b5743e349141b1728800698e952d768844c913504ab80c9ea965a"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.28/buttonheist-mcp-0.2.28-macos.tar.gz"
    sha256 "1fbf87dafdbfe0c5194a01a714db7108adeec1af1631ece00bef5d741d8382df"
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
