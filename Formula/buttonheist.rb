class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.27"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.27/buttonheist-0.2.27-macos.tar.gz"
  sha256 "9a16593e08b3d62e159113e59e6156425564dba655e3e8439deeb2331ecf52df"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.27/buttonheist-mcp-0.2.27-macos.tar.gz"
    sha256 "6339c1e68f9e2219b9bdf0315dd089ea08ced0a47fb2b24f7f0ff42f72c60bfe"
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
